function interpolated_channel = demosaicNN(channel)
%mosim = demosaicBaseline(im);The function takes a single input argument channel, which is a 2D matrix representing a single color channel of the raw image.

[height, width] = size(channel);
 %The function initializes a 2D matrix interpolated_channel with twice the height and width of the input channel, since each pixel in the input channel will be expanded to a 2x2 block in the output channel.
interpolated_channel = zeros(2*height, 2*width);
%the function then iterates over each pixel in the output channel using nested for loops. For each pixel, the function computes the corresponding pixel location
for i = 1:2*height
    for j = 1:2*width
%The round function is used here to ensure that the nearest-neighbor interpolation is performed correctly.
        x = round(i/2);
        y = round(j/2); 
        if x <= height && y <= width
            interpolated_channel(i,j) = channel(x,y);
        end
    end
end