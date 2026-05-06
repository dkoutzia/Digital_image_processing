function [c,R] = isCorner(I,p,k,Rthres)
[M1, M2] = size(I);

%To avoid any problems, we don't take the 1st two and last two pixels in
%x and y
if p(1)<3 || p(2)<3 ||  p(1)>M1-3 || p(2)> M2-3
    R=0;
    c = false;
    return;
end

%we use meshgrid to take the 5x5 part of the image centered at p
[X,Y] = meshgrid(p(1)-2:p(1)+2,p(2)-2:p(2)+2);

S = I(X,Y);

maskx = [1 0 -1; 1 0 -1; 1 0 -1];
masky = [1 1 1; 0 0 0; -1 -1 -1];

%We then compute x and y derivatives
Ix = conv2(S, maskx, 'same');
Iy = conv2(S, masky, 'same');

%We then compute products of derivatives
Ixx = Ix .^ 2;
Iyy = Iy .^ 2;
Ixy = Ix .* Iy;

h = fspecial('gaussian',3,1);
    
%We use the gaussian filter on products of derivatives
Sxx = conv2(Ixx, h, 'same');
Syy = conv2(Iyy, h, 'same');
Sxy = conv2(Ixy, h, 'same');

       M = [ Sxx(2,2) Sxy(2,2) ; Sxy(2,2) Syy(2,2) ];
       R = det(M) - k * (trace(M)^2);
       
       % If R is greater than threshold, assign the R value to that pixel 
       if(R>Rthres)
           c = true;
       else
           c = false;
       end
 

end