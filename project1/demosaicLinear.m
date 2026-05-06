%The function takes a single input argument channel, which is a 2D matrix representing a single color channel of the raw image.

function interpolated_channel = demosaicLinear(channel)

[m, n] = size(channel); 
interpolated_channel = zeros(m, n); 
for i = 2:m-1
    for j = 2:n-1
        %The function  iterates over each pixel in the input channel using nested for loops. For each pixel, the function checks if the pixel is on an even row and an odd column, or an odd row and an even column. These are the locations of the green pixels in the Bayer pattern.
%If the pixel is on an even row and an odd column, or an odd row and an even column, the function computes the value of the pixel as the average of the four nearest neighboring pixels 
        if mod(i, 2) == 0 && mod(j, 2) == 1 % even row, odd column
            interpolated_channel(i,j) = (channel(i-1,j) + channel(i+1,j) + channel(i,j-1) + channel(i,j+1)) / 4;
        elseif mod(i, 2) == 1 && mod(j, 2) == 0 % odd row, even column
            interpolated_channel(i,j) = (channel(i-1,j) + channel(i+1,j) + channel(i,j-1) + channel(i,j+1)) / 4;
        else 
            interpolated_channel(i,j) = (channel(i-1,j-1) + channel(i-1,j+1) + channel(i+1,j-1) + channel(i+1,j+1)) / 4;
        end
    end
end
