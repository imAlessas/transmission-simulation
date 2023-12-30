function result = symbol_sequence_generator(symbol_matrix, n)
% SYMBOL_SEQUENCE_GENERATOR generates a sequence of symbols based on a given symbol matrix and the desired length of the sequence.
%
% INPUT:
%   symbol_matrix: a 2xN matrix where the first row represents symbols and the second row represents their corresponding probabilities.
%   n:             the desired length of the symbol sequence.
%
% OUTPUT:
%   result:       a 1xN vector containing the generated symbol sequence.

    arguments
        symbol_matrix;
        n;
    end

    % Initialize an empty vector for the symbol sequence with length n
    result = zeros(1, n);

    % Calculate the cumulative probability matrix using the provided function
    sum_probability_matrix = distribution_probability_matrix(symbol_matrix);
    
    % Generate the symbol sequence
    for i = 1:n
        % Generate a random number between 0.00 and 1.00
        random_number = round(rand(), 2);
        
        % Calculate the distance of each cumulative probability from the random number
        distance_from_random_number = sum_probability_matrix(2, :) - random_number;
        distance_from_random_number(distance_from_random_number < 0) = +Inf;

        % Get the index of the symbol with the minimum distance
        [~, symbol] = min(distance_from_random_number);
        
        % Assign the selected symbol to the result vector
        result(i) = symbol;
    end
end







function result = distribution_probability_matrix(symbol_matrix)
% DISTRIBUITION_PROBABILITY_MATRIX calculates the cumulative distribution probability matrix based on the input symbol_matrix.
%
% INPUT:
%   symbol_matrix: a 2xN matrix where the first row represents the alphabet symbols and the second row represents their corresponding probabilities.
%
% OUTPUT:
%   result: a 2xN matrix where the first row contains symbols and the second row contains cumulative probabilities.

    arguments
        symbol_matrix;
    end
    
    % Extract probability vector from the symbol matrix
    probability_vector = symbol_matrix(2, :);
    
    % Get the number of possible symbols
    alphabet_length = length(probability_vector);

    % Calculate the cumulative probability matrix
    cumulative_probability = 0;
    sum_probability_vector = zeros(1, alphabet_length);
    for i = 1:alphabet_length
        % Calculate cumulative probability
        cumulative_probability = cumulative_probability + probability_vector(i);
        
        % Store cumulative probability in the vector
        sum_probability_vector(i) = cumulative_probability;
    end

    % Combine symbols and cumulative probabilities into the result matrix
    result = [symbol_matrix(1, :); sum_probability_vector];
end