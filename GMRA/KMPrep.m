function M = KMPrep(m, M)
% Prepares the M matrix for the Kuhn-Munkres algorithm process
% M Matrix needs to adhere to following conditions:
% 1. No ines are covered and no zeros are starred or primed
% 2. For each row, subtract the smallest element to each element in the row
% 3. For each column, subtract the smallest element to each element in the
% column
% INPUTS:
%   M = square qualification matrix (mxm)
% OUTPUTS:
%   M = properly prepped M matrix

% we are assuming condition 1 is met
    % prepping condition 2: row reduction
    % saw this nice and clean way to reduce a row or column 
    % on a MatLab Q&A, works very nicely
    for i = 1:m
        M(i, :) = M(i, :) - min(M(i, :));
    end
    
    % prepping condition 3: column reduction
    for j = 1:m
        M(:, j) = M(:, j) - min(M(:, j));
    end

end