image1 = imread('im1.png');
image2=imread('im2.png');
for_im1=imread('imForest1.png');
for_im2=imread('imForest2.png');
%convert to grayscale
im1Gray = rgb2gray(image1);
im2Gray = rgb2gray(image2);
for_im_gray1=rgb2gray(for_im1);
for_im_gray2=rgb2gray(for_im2);
%paradoteo gia descriptor
p1 = 100;
p2 = 100;
p = [p1,p2];
rhom=5;
rhoM=20;
rhostep=1;
N=8;
d1 = myLocalDescriptor(im1Gray,p,rhom ,rhoM ,rhostep ,N);
d_u1 = myLocalDescriptorUpgrade(im1Gray,p,rhom ,rhoM ,rhostep ,N);

p1 = 200;
p2 = 200;
p = [p1,p2];
d2 = myLocalDescriptor(im1Gray,p,rhom ,rhoM ,rhostep ,N);
d_u2 = myLocalDescriptorUpgrade(im1Gray,p,rhom ,rhoM ,rhostep ,N);


p1 = 202;
p2 = 202;
p = [p1,p2];
d3 = myLocalDescriptor(im1Gray,p,rhom ,rhoM ,rhostep ,N);
d_u3 = myLocalDescriptorUpgrade(im1Gray,p,rhom ,rhoM ,rhostep ,N);
     

Im=myStitch(image1,image2);
figure;
imshow(Im);