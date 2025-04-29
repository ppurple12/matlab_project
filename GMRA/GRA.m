function T = GRA(L, Q, tau)
% Puts together all the pieces and does the 
% complete Group Role Assignment (GRA) process, avoiding the mess
% INPUTS:
%   L = Role range Vector (n) - holds the values of required roles
%   Q = Qualification Matrix (mxn) - contains 
%       qualification for each agent for each role
%   tau = Qualification Threshold - value that  a specific Q[i, j] 
%         must be over to be considered
% OUTPUTS:
%   T = Assignment Matrix (mxn), where a 1 indicates an optimal 
%       choice and 0 indicated the opposite

[m, n] = size(Q);
M = transferQtoM(m, n, Q, L, tau);
M = KMPrep(m, M);
T = KM_algorithm(m, M); 
display(T);
T = deriveT(m, n, T, L);

end