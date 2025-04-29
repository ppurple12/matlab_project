% Soccer team optimization
%-------------------------------------------------------------------------
% We assume a really intense soccer coach wants to maximize the skillset of
% his U8 soccer team. He attributes a value for each player in potential
% positions (Forward, Midfielder, Defender, GK). He uses this neat MATLAB
% code to find who to assign where depending on formation

players = {'Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Frank', 'Grace', 'Hannah', 'Ivy', 'Jack', ...
           'Karen', 'Liam', 'Megan', 'Nathan', 'Olivia', 'Paul', 'Quinn', 'Rachel', 'Sam', 'Tom'};
roles = {'Attacker', 'Midfielder ', 'Defender', 'Goalie'};

Q = rand(20, 4);  %arbritary qualification matrix
% formations
formation1 = [3, 3, 4, 1]; % 4-3-3
formation2 = [2, 5, 3, 1]; % 3-5-2
formation3 = [2, 4, 4, 1]; % 4-4-2

% the coach refuses to let a player with less than a 0.5 (50%)
% play in that specific position
tau = 0.5;

% Formation 1
T = GRA(formation1, Q, tau);
fprintf("\n--------------------------------------------------\n" + ...
    "--------- Formation 1 Optimal Assignment ---------\n" + ...
    "--------------------------------------------------\n")
displayResults(players, roles, Q, T)

% 20 minutes into the first half, the coach 
% realizes this formation is not what this
% team needs right now and switched to 
% Formation 2 - a 3-5-2
T = GRA(formation2, Q, tau);
fprintf("\n--------------------------------------------------\n" + ...
    "--------- Formation 2 Optimal Assignment ---------\n" + ...
    "--------------------------------------------------\n")
displayResults(players, roles, Q, T)

% For the second half, as his team is still struggling
% he switched to Formation 3 - a 4-4-2
T = GRA(formation1, Q, tau);
fprintf("\n--------------------------------------------------\n" + ...
    "--------- Formation 3 Optimal Assignment ---------\n" + ...
    "--------------------------------------------------\n")
displayResults(players, roles, Q, T)