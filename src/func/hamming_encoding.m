function encoded_data_matrix = hamming_encoding(binary_data_matrix, codeword_length, k, generation_polynomial)
    % HAMMING_ENCODING performs Hamming encoding on a binary data matrix.
    %
    % INPUT:
    %   binary_data_matrix:         Binary matrix containing k information symbols.
    %   codeword_length:            Length of the codeword (total symbols per codeword).
    %   k:                          Number of actual information symbols.
    %   generation_polynomial:      Generator polynomial for Hamming cyclic encoding.
    %
    % OUTPUT:
    %   encoded_data_matrix:               Matrix containing the encoded data symbols.
    
    % Calculate the number of redundant symbols (parity symbols)
    r = codeword_length - k;
    
    % Generate the cyclic encoding matrix based on the generator polynomial
    [~, cyclic_encoding_matrix] = cyclgen(codeword_length, generation_polynomial);
    
    % Reorder the encoding matrix to match Hamming code requirements
    reorder = [r + 1 : codeword_length, 1 : r];
    cyclic_encoding_matrix = cyclic_encoding_matrix(:, reorder);
    
    % Calculate control symbol values using matrix multiplication
    % Use rem() function to find modulo 2 sum as a remainder of division by 2
    encoded_data_matrix = rem(binary_data_matrix * cyclic_encoding_matrix, 2);
end
