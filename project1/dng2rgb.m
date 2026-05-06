function[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, bayertype, method,M,N);
% Convert a raw image with Bayer pattern to sRGB, linear, XYZ, and camera RGB images.
% Inputs:
%   - rawim: M0 x N0 matrix with the raw image values
%   - XYZ2Cam: 3x3 matrix with the transformation from XYZ to camera RGB
%   - wbcoeffs: 3-element vector with the white balance coefficients
%   - bayertype: string with the Bayer pattern type ('BGGR', 'GBRG', 'GRBG', 'RGGB')
%   - method: string with the interpolation method ('nearest', 'linear')
% Outputs:
%   - Csrgb: M x N matrix with the sRGB image
%   - Clinear: M x N matrix with the linear image
%   - Cxyz: M x N matrix with the XYZ image
%   - Ccam: M x N matrix with the camera RGB image

%apply white balance
mask = wbmask(size(rawim,1),size(rawim,2),wbcoeffs,bayertype)
balanced_bayer= rawim.*mask;

%interpolation
Clinear=demosaicIM(balanced_bayer,method,M,N,bayertype);
Clinear = max(0,min(Clinear,1));

%color space conversion
xyz2rgb = [+3.2406, - 1.5372, - 0.4986;-0.9689, + 1.8758, + 0.0415;+0.0557, -0.2040, + 1.0570]
rgb2xyz= (xyz2rgb)^-1
rgb2cam = XYZ2Cam * rgb2xyz; %  previously defined matrices
rgb2cam = rgb2cam ./ repmat(sum(rgb2cam,2),1,3); % Normalize rows to 1
cam2rgb = (rgb2cam)^-1;
Ccam = apply_cmatrix(Clinear, rgb2cam);
Cxyz= apply_cmatrix(Ccam, (XYZ2Cam)^-1);
Cxyz = max(0,min(Cxyz,1));

% Brightness and Gamma correction
    lin_srgb = apply_cmatrix(Clinear, cam2rgb);
    grayim = rgb2gray(lin_srgb);
    grayscale = 0.25/mean(grayim(:));
    bright_srgb = min(1,lin_srgb * grayscale);
    Csrgb = bright_srgb.^(1/2.2);
    Csrgb = max(0,min(Csrgb,1));

end