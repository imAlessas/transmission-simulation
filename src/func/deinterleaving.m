function unmixed_sequence = deinterleaving(mixed_sequence)
% DEINTERLEAVING rearranges an interleaved sequence into its original form.
%
% INPUT:
%   mixed_sequence:     A vector representing the interleaved sequence.
%
% OUTPUT:
%   unmixed_sequence:   A vector representing the original sequence.

    % Define the length of each column (also the number of rows)
    column_length = 31;

    % Calculate the number of columns (also the number of rows) based on the input sequence length
    row_length = length(mixed_sequence) / column_length;

    % Initialize the matrix for deinterleaving
    deinterleaver_matrix = [];

    % Iterate through the columns of the interleaved sequence
    for i = 1 : column_length
        % Extract the current column from the mixed sequence
        current_column = mixed_sequence(row_length * (i-1) + 1 : row_length * i)';
        
        % Append the current column to the matrix
        deinterleaver_matrix = [deinterleaver_matrix, current_column];
    end
  
    % Initialize the deinterleaved sequence
    unmixed_sequence = [];

    % Iterate through the rows of the matrix
    for i = 1 : row_length
        % Append the elements from each column of the current row to the deinterleaved sequence
        unmixed_sequence = [unmixed_sequence, deinterleaver_matrix(i, 1 : end)];
    end

end
