function newT = deriveT(m, n, T,L)
% Derive the results of the mxm T matrix 
% to return the matrix to it's original mxn form
% INPUTS:
%   m: size of rows in original matrix
%   n  size of columns in original matrix
%   T: Results of KM_algorithm (m x m).
%   L: Role range vector (n) - holds the values of required roles
% OUTPUT:
%   T: Assignment Matrix (mxn)

    % important inits
    newT = zeros(m, n);
    col = 1;
    start = 1;

    while(col <= n) % break condition

         comboAmt = L(col); %amount of columns to combine
         combinedCol = zeros(m, 1); %init column
    
        % sum the specified columns 
        for j=start: (start + comboAmt - 1)
            % add each neccessary column from T
            combinedCol = combinedCol + T(:, j); 
        end

        % replace combined column into appropriate pos in T
        newT(:, col) = combinedCol;
        % increment
        start = start + comboAmt;
        col = col + 1;
    end
end