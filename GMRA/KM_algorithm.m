function M = KM_algorithm(m, M)
    % Kuhn-Munkres (Hungarian) algorithm implementation for finding the optimal assignment.
    % INPUTS:
    %   m: Size of the matrix (m x m).
    %   M: The square matrix (m x m), where zeros represent potential assignments.
    % OUTPUT:
    %   M: The matrix with assignments marked after running the Kuhn-Munkres algorithm.


    % Initialize markers 
    stars = zeros(m, m);  % for marking starred zero
    primes = zeros(m, m); % for making primed zeros
    coveredRows = false(1, m);  %bool flag for rows
    coveredCols = false(1, m);  %bool flag for cols

    % star the zeros in the matrix
    % make sure there's only one per row and column
    for i = 1:m
        for j = 1:m
            if M(i, j) == 0 && ~any(stars(i, :)) && ~any(stars(:, j))
                stars(i, j) = 1; 
            end
        end
    end

    coveredCols = any(stars, 1);  % cover columns that have starred zeros
    
    while true
        % break condition - if all columns are covered
        if sum(coveredCols) == m  
            % disp('Termination Condition Met'); - dededebugggg
            break;
        end
        
        %uses helper function to prime a zero
        %returns index of prime (IF FOUND) and boolean
        [index, primeFound] = primeZero(m, M, coveredRows, coveredCols);
        
        while ~primeFound
            % if no primes are found, reduce the matrix
            uncoveredMatrix = M(~coveredRows, ~coveredCols); % returns all uncovered values
            minUncovered = min(uncoveredMatrix(:));  % Find the smallest uncovered value
            
            % add minUncovered to all covered rows and subtract from uncovered columns
            for i = 1:m
                if coveredRows(i)
                    M(i, :) = M(i, :) + minUncovered;
                end
                if ~coveredCols(i)
                    M(:, i) = M(:, i) - minUncovered;
                end
            end
            %try finding prime again - same helper function
           [index, primeFound] = primeZero(m, M, coveredRows, coveredCols);
        end
        
        % once a primes is found, keep track of index and add to primes
        i = index(1);
        j = index(2);
        primes(i, j) = 1;
        
        % find the column of the starred zero in prime's row
        columnIndex = find(stars(i, :) == 1, 1);

        % if no starred zero in this column, change the sequence
        if isempty(columnIndex)
            zeroSequence = [index];  % intialize a tracker for all zeros
            j = index(2);  % start at column index of the unpaired prime zero
            
            while true
                % find starred zero in column j and return row
                i = find(stars(:, j) == 1, 1);  
                
                % break condition
                if isempty(i)
                    break;
                end
                
                % check if the i j is already visited
                isVisited = false;
                for k = 1:size(zeroSequence, 1)
                    % check pairs already in seqeunce
                    if zeroSequence(k, 1) == i && zeroSequence(k, 2) == j 
                        isVisited = true;
                        break;
                    end
                end
                
                % break condition - to avoid infinite loop
                if isVisited
                    break;
                end
                
                % if no loop, add the new i j pairing to zero sequence
                zeroSequence = [zeroSequence; i, j];

                % similar process but with primes and columns
                %  find column j with primed zero in row i
                j = find(primes(i, :) == 1, 1);  
                
                % break condition - if no primed zero exists 
                if isempty(j) 
                    break;
                end

                % check if the i j is already visited
                isVisited = false;
                for k = 1:size(zeroSequence, 1)
                     % check pairs already in seqeunce
                    if zeroSequence(k, 1) == i && zeroSequence(k, 2) == j
                        isVisited = true;
                        break;
                    end
                end
                
               % break condition - to avoid infinite loop
                if isVisited
                    break;
                end
                
                % add to sequence
                zeroSequence = [zeroSequence; i, j];
            end
            
            % unstar each starred zero in the sequence and star each primed zero
            for k = 1:size(zeroSequence, 1)
                zero = zeroSequence(k, :);
                row = zero(1);
                col = zero(2);
            
                if stars(row, col) == 1  % If it's a starred zero
                    stars(row, col) = 0;  % Unstar it
                end
                if primes(row, col) == 1  % If it's a primed zero
                    stars(row, col) = 1;  % Star it
                end
            end

            % reset primes and row and col flags
            primes = zeros(m, m); 
            coveredRows = false(1, m);  
            coveredCols = false(1, m);
            
            % recheck for covered columns with new updates
            for j = 1:m
                if any(stars(:, j) == 1)  % check if there is a starred zero in column j
                    coveredCols(j) = true; 
                else
                    coveredCols(j) = false;  
                end
            end

        else
            % if there is a starred zero in the same column as primed zero
            % add it to covered row and col flags 
            coveredRows(index(1)) = 1;
            coveredCols(columnIndex) = 0;
        end
    end
    M = stars;
end


