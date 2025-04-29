function [index, found] = primeZero(m, M, coveredRows, coveredCols)
% function to aid in organizing the K-M algorithm
% INPUTS:
%   m: size of M matrix
%   M:The square matrix (m x m), where zeros represent potential assignments
%   coveredRows: index for keeping track of covered rows (size is m)
%   coveredCols: index for keeping track of covered columns (size is m)
% OUTPUT:
%   index: returns index of now primed zero
%   found: boolean true or false

found = false;
for i = 1:m
    for j = 1:m
        % checks if there is a zero that is not "covered"
        if M(i, j) == 0 && ~coveredRows(i) && ~coveredCols(j)
            % display(M); - debugging
            index = [i j]; %assigns index if found
            found = true;
            return;
        end
    end
end
index = []; % empty otherwise

end
             