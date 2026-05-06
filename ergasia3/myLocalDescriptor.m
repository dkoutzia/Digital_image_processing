function d = myLocalDescriptor(I, p, rhom, rhoM, rhostep, N)
   
tempX = 0;
tempY = 0;

%N sized vector which has the values of each concentral circle
vectX = zeros(N,1);

%index variable is so that the code does not get too complicated
index = 1;
d = zeros(((rhoM-rhom)/rhostep),1); 



%use of the for is pretty simple
%assing the coordinates on the circle to tempX, tempY
for r=rhom:rhostep:rhoM-1
    for i=1:N
    tempX = p(1) + r*cos(2*pi/i);

    tempY = p(2) + r*sin(2*pi/i);
    
    if ceil(tempX) >= 1 && ceil(tempX) <= size(I, 1) && ceil(tempY) >= 1 && ceil(tempY) <= size(I, 2) && floor(tempX) >= 1 && floor(tempX) <= size(I, 1) && floor(tempY) >= 1 && floor(tempY) <= size(I, 2)
            % Perform bilinear interpolation and assign value to vectX
    %use billinear interpolation to find the value of vectX
    vectX(i) = (I(ceil(tempX),ceil(tempY)) + I(floor(tempX),ceil(tempY)) + I(floor(tempX),floor(tempY)) + I(ceil(tempX),floor(tempY)))/4;
    end
    end
    %assign the value which we calculated above to the corresponding index
    %of the vector d
    d(index) = mean(vectX);
    index = index+1;
end