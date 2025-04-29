function M = transferQtoM(m, n, Q, L, tau)
% Converts an mxn matrix to a mxm square matrix
% INPUTS:
%   m = amount of rows in Q
%   n = amount of columns in Q
%   Q = Qualification Matrix (mxn) - contains 
%       qualification for each agent for each role
%   L = Role range vector (n) - holds the values of required roles
%   tau = Qualification Threshold - value that  a specific Q[i, j] 
%         must be over to be considered
% OUTPUTS:
%   M = square qualification matrix (mxm)

% if Qualification Threshold exists, make sure Q matrix is qualified
if nargin > 4 
    for i = 1:m
        for j = 1: n
            if Q(i, j) <= tau
                Q(i, j) = -m*n; % if a spefic Q[i, j] does not
                %  qualify, make sure it CANNOT be chosen (value is -mxn)
            end 
        end 
    end
end % once this block is finished, matrix is "Qualified" (Q')

%inits mxm matrix of zeros
M = zeros(m, m); 

%go through each row until m
for i = 1:m
    k = 1;
    for j = 1:n
        if L(j) == 1
            %if the specifc column is required, add it to M at pos k
            M(i, k) = Q(i, j);
            k = k + 1;
        else
             %if the specifc column is required more than once,
             % add it that many times
            if L(j) > 1
                x = L(j);
                for g = 1: x
                   if k > m
                        break;
                    end
                    M(i, k) = Q(i, j); 
                    k = k + 1;
                end
            end
        end
 
    end
   
    % Fill remaining columns with 1s
    while k <= m
        M(i, k) = 1;
        k = k + 1;
    end   
end 

% update M[i, j] with 1 - M[i, j] as 
% K-M algorithm finds Min opimization, not max
for i = 1:m
    for j = 1: m
        M(i, j) = 1 - M(i, j) ;
    end
end