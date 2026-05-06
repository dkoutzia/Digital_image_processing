function out = demosaicIM(img,method,M,N,bayer_pattern)

%For each Bayer pattern type, the code extracts the red, green1, green2, and blue color channels from the input image. 
switch bayer_pattern
    case 'RGGB'
        red= img(1:2:end,1:2:end);
        green1= img(1:2:end ,2:2:end);
        green2 = img(2:2:end, 1:2:end);
        blue=img(2:2:end, 2:2:end);
    case 'BGGR'
        red= img(2:2:end, 2:2:end);
        green1= img(1:2:end ,2:2:end);
        green2 = img(2:2:end, 1:2:end);
        blue=img(1:2:end,1:2:end);
    case 'GRBG'
        red= img(1:2:end,2:2:end);
        green1= img(1:2:end ,1:2:end);
        green2 = img(2:2:end, 2:2:end);
        blue=img(2:2:end, 1:2:end);
    case 'GBRG'
        red= img(2:2:end,1:2:end);
        green1= img(1:2:end ,1:2:end);
        green2 = img(2:2:end, 2:2:end);
        blue=img(1:2:end, 2:2:end);
     otherwise
        error('Invalid Bayer pattern type');
   
end

%For each color channel, the code applies the chosen demosaicing method to interpolate the missing color information in each pixel.
switch method
    case 'nearest'
        red_interp = demosaicNN(red);
        green1_interp = demosaicNN(green1);
        green2_interp = demosaicNN(green2);
        blue_interp = demosaicNN(blue);
    case  'linear'
        red_interp = demosaicLinear(red);
        green1_interp = demosaicLinear(green1);
        green2_interp = demosaicLinear(green2);
        blue_interp = demosaicLinear(blue);
     otherwise
        error('Invalid method');
end

%the code resizes the interpolated color channels to the desired output size (M x N) and combines them into a full-color image.
    red_interp = imresize(red_interp, [M, N]);
    green1_interp = imresize(green1_interp, [M, N]);
    green2_interp = imresize(green2_interp, [M, N]);
    blue_interp = imresize(blue_interp, [M, N]);
    out = zeros(M, N, 3);
    %The red channel is placed in the first layer of the output image, the green channel is averaged between the green1 and green2 channels and placed in the second layer of the output image, and the blue channel is placed in the third layer of the output image.
    out(:,:,1) = red_interp;
    out(:,:,2) = (green1_interp + green2_interp) / 2;
    out(:,:,3) = blue_interp;
end
