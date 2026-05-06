function [H, inlierMatchingPoints, outlierMatchingPoints] = myRANSAC(matchingPoints, r, N)
    inlierMatchingPoints = [];
    outlierMatchingPoints = [];
    bestScore =  inf;   
    n = size(matchingPoints,1);  % Number of point correspondences
    bestH=[];
    max=0;
    for i = 1:N
        % Step 1: Randomly select two  point correspondences
        randomIndices = randi(n);
        P_indices = randomIndices;
        score=0;

        P1_1 = matchingPoints(P_indices, 1);
        P1_2 = matchingPoints(P_indices, 2);
        P2_1 = matchingPoints(P_indices, 3);
        P2_2 = matchingPoints(P_indices, 4);
     

        % Step 2: Compute transformation parameters
        dx = P2_1 -  P1_1;
        dy = P2_2 - P1_2;
        theta = atan2(dy, dx);
        d = [dx; dy];
        H.theta = theta;
        H.d = d;
        % Step 3: Compute the score (number of inliers)
        inliers = [];
        outliers=[];
        for j = 1:n
            P1 = matchingPoints(j, 1:2);
            P2 = matchingPoints(j, 3:4);
            P2_transformed = [cos(H.theta), -sin(H.theta); sin(H.theta), cos(H.theta)] * P1' + H.d;
            distance = pdist2(P2_transformed , P2');
            score= score+distance;
            if distance <= r
                inliers = [inliers; j];
            else
                outliers=[outliers;j];
            end
        end
        
        numInliers = length(inliers);
        numoutliers=length(outliers);
        
        % Step 4: Update best transformation if score is higher
         if numInliers > max
            max=numInliers;
            bestScore = score;
            inlierMatchingPoints = inliers;   % Store the inlier coordinates
            outlierMatchingPoints = outliers; % Store the outlier coordinates
            bestH = H;      
         end
    end
  
    
    % Output the b1est transformation
    disp(size(inlierMatchingPoints));
    H = bestH;
    disp(H);
    disp(H.d);
    disp(H.theta);
end