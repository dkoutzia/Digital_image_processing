function Im = myStitch(image1, image2)
    im1 = rgb2gray(image1);
    im2 = rgb2gray(image2);
   
    
    normim1=double(im1) / 255;
    normim2=double(im2) / 255;
    
     

     % Detect corners using your function myDetectHarrisFeatures
    corners1 = myDetectHarrisFeatures(normim1);
    corners2 = myDetectHarrisFeatures(normim2);
     figure;
     imshow(im1);
     hold on;
     plot(corners1(:, 1), corners1(:, 2), 'r+');
     title('Corners in Image 1');  
     hold off;
     pause(0.1);

     figure;
     imshow(im2);
     hold on;
     plot(corners2(:,1), corners2(:,2), 'r+');
     title('Corners in Image 2');  
     hold off;

     
    points1 = zeros(15,size(corners1, 1));  % Initialize points1 outside the loop
    for i = 1:size(corners1, 1)
        p = corners1(i, :);
        descriptor = myLocalDescriptor(normim1, p, 5, 20, 1, 8); % Modify the parameters as needed
        
        points1(:, i) = descriptor;

    end
    
   points2 = zeros(15,size(corners2, 1));  % Initialize points1 outside the loop
    for i = 1:size(corners2, 1)
        p = corners2(i, :);
        descriptor = myLocalDescriptor(normim2, p, 5, 20, 1, 8); % Modify the parameters as needed
        
        points2(:, i) = descriptor;

    end
    disp(size(corners1));
    disp(size(corners2));
    disp(size(points1));
    disp(size(points2));
    % Match corners using your matching function
    [matchedPoints] = descriptorMatching(points1, points2, 30);
    % Retrieve the matched points based on the indices
    disp(size(matchedPoints));
    % Run RANSAC to estimate transformation
    matchedIndices1 = matchedPoints(1, :);
    matchedIndices2 = matchedPoints(2, :);
    matchedPoints = [corners1(matchedIndices1, :), corners2(matchedIndices2, :)];
    

    disp(size(matchedPoints));


    r = 500;  % Inlier radius threshold
    N = 2000;  % Number of iterations
    [H, inliers, outliers] = myRANSAC(matchedPoints, r, N);
   
    
   % Warp rotated im2 to align with im1
   tform = [cos(H.theta), -sin(H.theta), 0; sin(H.theta), cos(H.theta), 0; H.d(1), H.d(2), 1];
   warpedIm2 = imwarp(im2, affine2d(tform), 'OutputView', imref2d(size(im1)));
    figure;
    imshow(warpedIm2);
    Im= imfuse(im1 , warpedIm2,'blend','Scaling','joint'); 
end