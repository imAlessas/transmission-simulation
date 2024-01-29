function decoded_data_matrix = hamming_decoding(encoded_data_matrix, codeword_length, k, generation_polynomial)
    % Determine the number of control symbols
    r = codeword_length - k;
    
    % Specify syndrome calculation matrix
    [~, cyclic_encoding_matrix] = cyclgen(codeword_length, generation_polynomial);
    syndrome_matrix = cyclic_encoding_matrix(:, (1:r));
    syndrome_matrix = [syndrome_matrix; eye(r)];
    
    % Calculate syndrome for each codeword
    syndrome_value = rem(encoded_data_matrix * syndrome_matrix, 2);
    syndrome_value = syndrome_value * 2.^(r - 1 : -1 : 0)';
    
    % Calculate error indexes based on syndrome values
    error_indexes = get_error_indexes(syndrome_matrix, syndrome_value, codeword_length);
        
    % Define error vector table
    error_vector = [zeros(1, codeword_length);
                    eye(codeword_length)];
    
    % Perform correction by adding the error vector to the received codeword
    codeword = rem(encoded_data_matrix + error_vector(error_indexes + 1, :), 2);
    
    % Read the columns of data symbols to form decoded data
    decoded_data_matrix = codeword(:, 1:k);
end




function error_indexes = get_error_indexes(syndrome_matrix, syndrome_value, codeword_length)
% CALCULATE_ERROR_INDEXES calculates the error indexes based on syndrome values.
%
% INPUT:
%   syndrome_matrix:   Matrix containing syndrome patterns.
%   syndrome_value:    Syndrome values for each codeword.
%   codeword_length:   Length of the codeword.
%
% OUTPUT:
%   error_indexes:     Vector containing error indexes.

    % Initialize vector to store decimal values of binary syndrome patterns
    syndrome_decimal_value_vector = [];

    % Convert binary syndrome values to decimal for association
    for i = 1 : codeword_length
        syndrome_decimal_value_vector = [syndrome_decimal_value_vector; bin2dec(num2str(syndrome_matrix(i, :)))];
    end

    % Combine positions and corresponding decimal values for sorting
    associations = [transpose(1:codeword_length), syndrome_decimal_value_vector];

    % Sort associations based on decimal values for efficient error detection
    associations = sortrows(associations, 2);

    % Create correction index for mapping syndrome values to error positions
    correction_index = [0, associations(:, 1)'];

    % Map syndrome values to error positions using correction index
    error_indexes = correction_index(syndrome_value + 1);
end