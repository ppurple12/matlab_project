function displayResults(agents, roles, Q, T)    

    % print header row with proper spacing
    header = sprintf(['%-10s', repmat(['%-', num2str(10), 's'], 1, length(roles))], 'Agents', roles{:});
    disp(header);
    disp(repmat('-', 1, length(header))); % Print separator line

    % print Q matrix with assignments 
    for i = 1:length(agents)
        fprintf('%-12s', agents{i}); % Correct cell array indexing with {}

        for j = 1:length(roles)
            if T(i, j) == 1
                % enclose chosen agent-role combos with <x>
                fprintf(' <%.2f> ', Q(i, j));
            else
                fprintf('  %.2f  ', Q(i, j));
            end
        end
        fprintf('\n'); % new line
    end
end

