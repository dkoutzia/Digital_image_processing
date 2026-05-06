
function[rawim, XYZ2Cam, wbcoeffs] = readdng(RawImage);

% Open the DNG file using LibTIFF
obj = Tiff(RawImage, 'r');

% Read the RAW image
offsets = getTag(obj, 'SubIFD');
setSubDirectory(obj, offsets(1));
rawim = read(obj);
close(obj);

% Read the metadata
meta_info = imfinfo(RawImage);

% Extract useful information from the metadata
y_origin = meta_info.SubIFDs{1}.ActiveArea(1) + 1;
x_origin = meta_info.SubIFDs{1}.ActiveArea(2) + 1;
width = meta_info.SubIFDs{1}.DefaultCropSize(1);
height = meta_info.SubIFDs{1}.DefaultCropSize(2);
blacklevel = meta_info.SubIFDs{1}.BlackLevel(1);
whitelevel = meta_info.SubIFDs{1}.WhiteLevel;
wbcoeffs = (meta_info.AsShotNeutral).^-1;
wbcoeffs = wbcoeffs / wbcoeffs(2);
XYZ2Cam = meta_info.ColorMatrix2;
XYZ2Cam = reshape(XYZ2Cam, 3, 3)';

% Convert the RAW image to a processed image
rawim = double(rawim - blacklevel) / double(whitelevel - blacklevel);
rawim = max(0, min(rawim, 1));

% Crop the processed image to the useful part
rawim = double(rawim(y_origin:y_origin+height-1, x_origin:x_origin+width-1));
end
