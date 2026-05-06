function matchingPoints = descriptorMatching(points1, points2, percentageThreshold)
    % Calculate the Euclidean distances between descriptors
    distances = pdist2(points1', points2');
    % Calculate the distances between matching points

   % Plot a histogram of the distances
    figure;
    histogram(distances);
    xlabel('Distance');
    ylabel('Frequency');
    title('Distribution of Distances');
    % Sort the distances in ascending order
    sortedDistances = sort(distances(:));
    
    % Calculate the threshold based on the percentageThreshold
    thresholdIndex = round(percentageThreshold/100 * numel(sortedDistances));
    threshold = sortedDistances(thresholdIndex);
    
    % Find the matching points based on the threshold
    [rowIndices, colIndices] = find(distances <= threshold);
    
    % Create the matchingPoints array
    matchingPoints = [rowIndices, colIndices]';
end