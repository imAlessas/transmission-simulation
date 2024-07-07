function mixed_sequence = interleaving(unmixed_sequence, column_length)
% INTERLEAVING reorganizes a sequence by interleaving its elements into a matrix.
%
% INPUT:
%   unmixed_sequence:   A vector representing the original sequence to be interleaved.
%
% OUTPUT:
%   mixed_sequence:     A vector representing the interleaved sequence.

    % Calculate the number of length of each row (also the number of columns) based on the input sequence length
    row_length = length(unmixed_sequence) / column_length;

    % Write on the columns and read on the rows to create the interleaved matrix
    interleaver_matrix = [];

    % Iterate through the rows
    for i = 1 : row_length
        % Extract the current column from the unmixed sequence
        current_column = unmixed_sequence(column_length * (i-1) + 1 : column_length * i)';
        
        % Append the current column to the matrix
        interleaver_matrix = [interleaver_matrix, current_column];
    end
    
    % Initialize the interleaved sequence
    mixed_sequence = [];

    % Iterate through the columns of the matrix
    for i = 1 : column_length
        % Append the elements from each row of the current column to the interleaved sequence
        mixed_sequence = [mixed_sequence, interleaver_matrix(i, 1 : end)];
    end

end
