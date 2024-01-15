function decoded_data_matrix = hamming_decoding(encoded_data_matrix, codeword_length, k, generation_polynomial)
    % HAMMING_DECODING performs decoding of Hamming group (m, k) codewords specified in
    % matrix form for multiple codewords.
    %
    % INPUT:
    %   encoded_data_matrix:        Matrix containing encoded Hamming codewords.
    %   codeword_length:            Length of the codeword (total symbols per codeword).
    %   k:                          Number of actual information symbols.
    %   generation_polynomial:      Generator polynomial for Hamming encoding.
    %
    % OUTPUT:
    %   decoded_data:               Matrix containing decoded and corrected information blocks.
    
    % Determine the number of control symbols
    r = codeword_length - k;
    
    % Specify syndrome calculation matrix
    [~, cyclic_encoding_matrix] = cyclgen(codeword_length, generation_polynomial);
    syndrome_matrix = cyclic_encoding_matrix(:, (1:r));
    syndrome_matrix = [syndrome_matrix; eye(r)];
    
    % Calculate syndrome for each codeword
    syndrome_value = rem(encoded_data_matrix * syndrome_matrix, 2);
    syndrome_value = syndrome_value * 2.^(r - 1 : -1 : 0)';
    
    % Define associations between syndrome values and error positions
    positions = (1 : codeword_length)';
    syndrome_decimal_value_vector = [];
    
    for i = 1 : codeword_length
        syndrome_decimal_value_vector = [syndrome_decimal_value_vector; bin2dec(num2str(syndrome_matrix(i, :)))];
    end
    
    associations = [positions, syndrome_decimal_value_vector];
    associations = sortrows(associations, 2);
    
    correction_index = [0, associations(:, 1)'];
    error_indexes = correction_index(syndrome_value + 1);
    
    % Define error vector table
    error_vector = [zeros(1, codeword_length);
                    eye(codeword_length)];
    
    % Perform correction by adding the error vector to the received codeword
    codeword = rem(encoded_data_matrix + error_vector(error_indexes + 1, :), 2);
    
    % Read the columns of data symbols to form decoded data
    decoded_data_matrix = codeword(:, 1:k);
end
