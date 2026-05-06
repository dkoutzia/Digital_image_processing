[rawim, XYZ2Cam, wbcoeffs] = readdng('RawImage.DNG');
bayer = input('What bayer pattern you want to use (RGGB,BGGR,GRBG,GBRG)? ', 's');
interp=input('What  interpolation method you want to use (nearest,linear)? ', 's');
switch bayer
    case 'GBRG'
        switch interp
            case 'linear'
[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, 'GBRG', 'linear',4000,6000);
figure;
imshow(Clinear); %Clinear image
title('Clinear,GBRG,linear');
figure;
imshow(Cxyz);  %Cxyz image
title('Cxyz,GBRG,linear');
figure;
imshow(Ccam); %Ccam image
title('Ccam,GBRG,linear');
figure;
imshow(Csrgb); %Csrgb image
title('Csrgb,GBRG,linear');
            
            case 'nearest'
                [Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, 'GBRG', 'nearest',4000,6000);
figure;
imshow(Clinear);
title('Clinear,GBRG,nearest');
figure;
imshow(Cxyz);
title('Cxyz,GBRG,nearest');
figure;
imshow(Ccam);
title('Ccam,GBRG,nearest');
figure;
imshow(Csrgb);
title('Csrgb,GBRG,nearest');
            otherwise
                error('invalid  interpolation method')
        end
        
    case 'GRBG'
        switch interp
            case 'linear'
[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, 'GRBG', 'linear',4000,6000);
figure;
imshow(Clinear);
title('Clinear,GRBG,linear');
figure;
imshow(Cxyz);
title('Cxyz,GRBG,linear');
figure;
imshow(Ccam);
title('Ccam,GRBG,linear');
figure;
imshow(Csrgb);
title('Csrgb,GRBG,linear');
     
            case 'nearest'
                [Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, 'GRBG', 'nearest',4000,6000);
figure;
imshow(Clinear);
title('Clinear,GRBG,nearest');
figure;
imshow(Cxyz);
title('Cxyz,GRBG,nearest');
figure;
imshow(Ccam);
title('Ccam,GRBG,nearest');
figure;
imshow(Csrgb);
title('Csrgb,GRBG,nearest');
            otherwise
                error('invalid  interpolation method')
        end
        
    case 'RGGB'
        switch interp
            case 'linear'
[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, 'RGGB', 'linear',4000,6000);
figure;
imshow(Clinear);
title('Clinear,RGGB,linear');
figure;
imshow(Cxyz);
title('Cxyz,RGGB,linear');
figure;
imshow(Ccam);
title('Ccam,RGGB,linear');
figure;
imshow(Csrgb);
title('Csrgb,RGGB,linear');
            
            case 'nearest'
                [Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, 'RGGB', 'nearest',4000,6000);
figure;
imshow(Clinear);
title('Clinear,RGGB,nearest');
figure;
imshow(Cxyz);
title('Cxyz,RGGB,nearest');
figure;
imshow(Ccam);
title('Ccam,RGGB,nearest');
figure;
imshow(Csrgb);
title('Csrgb,RGGB,nearest');
            otherwise
                error('invalid  interpolation method')
        end
        
    case 'BGGR'
        switch interp
            case 'linear'
[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, 'BGGR', 'linear',4000,6000);
figure;
imshow(Clinear);
title('Clinear,BGGR,linear');
figure;
imshow(Cxyz);
title('Cxyz,BGGR,linear');
figure;
imshow(Ccam);
title('Ccam,BGGR,linear');
figure;
imshow(Csrgb);
title('Csrgb,BGGR,linear');
           
            case 'nearest'
                [Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, 'BGGR', 'nearest',4000,6000);
figure;
imshow(Clinear);
title('Clinear,BGGR,nearest');
figure;
imshow(Cxyz);
title('Cxyz,BGGR,nearest');
figure;
imshow(Ccam);
title('Ccam,BGGR,nearest');
figure;
imshow(Csrgb);
title('Csrgb,BGGR,nearest');
            otherwise
                error('invalid interpolation method')
        end
    otherwise
        error('invalid bayer pattern')
end


figure;
subplot(3, 3, 1);
imshow(Clinear(:, :, 1));
title('Channel red Clinear');
subplot(3, 3, 2);
imhist(Clinear(:, :, 1));
title('Histogram of channel red Clinear');
subplot(3, 3, 3);
imshow(Clinear(:, :, 2));
title('Channel green Clinear');
subplot(3, 3, 4);
imhist(Clinear(:, :, 2));
title('Histogram of channel green Clinear');

subplot(3, 3, 5);
imshow(Clinear(:, :, 3));
title('Channel blue Clinear');
subplot(3, 3, 6);
imhist(Clinear(:, :, 3));
title('Histogram of channel blue Clinear');

figure;
subplot(3, 3, 1);
imshow(Ccam(:, :, 1)); %shows red channel of Ccam
title('Channel red Ccam');
subplot(3, 3, 2);
imhist(Ccam(:, :, 1));
title('Histogram of channel red Ccam');
subplot(3, 3, 3);
imshow(Ccam(:, :, 2));
title('Channel green Ccam');
subplot(3, 3, 4);
imhist(Ccam(:, :, 2));
title('Histogram of channel green Ccam');

subplot(3, 3, 5);
imshow(Ccam(:, :, 3));
title('Channel blue Ccam');
subplot(3, 3, 6);
imhist(Ccam(:, :, 3));
title('Histogram of channel blue Ccam');

figure;
subplot(3, 3, 1);
imshow(Ccam(:, :, 1));
title('Channel red Cxyz');
subplot(3, 3, 2);
imhist(Cxyz(:, :, 1));
title('Histogram of channel red Cxyz');
subplot(3, 3, 3);
imshow(Cxyz(:, :, 2));
title('Channel green Cxyz');
subplot(3, 3, 4);
imhist(Cxyz(:, :, 2));
title('Histogram of channel green Cxyz');

subplot(3, 3, 5);
imshow(Cxyz(:, :, 3));
title('Channel blue Cxyz');
subplot(3, 3, 6);
imhist(Cxyz(:, :, 3));

figure;
subplot(3, 3, 1);
imshow(Csrgb(:, :, 1));
title('Channel red Csrgb');
subplot(3, 3, 2);
imhist(Cxyz(:, :, 1));
title('Histogram of channel red Csrgb');
subplot(3, 3, 3);
imshow(Csrgb(:, :, 2));
title('Channel green Csrgb');
subplot(3, 3, 4);
imhist(Csrgb(:, :, 2));
title('Histogram of channel green Csrgb');


subplot(3, 3, 5);
imshow(Csrgb(:, :, 3));
title('Channel blue Csrgb');
subplot(3, 3, 6);
imhist(Csrgb(:, :, 3));

title('Histogram of channel blue Csrgb');