function decoded_data = hamming_decoding(encoded_data, codeword_length, k, generation_polynomial)
    % HAMMING_DECODING performs decoding of Hamming (m, k) codewords specified in
    % matrix form for multiple codewords.
    %
    % INPUT:
    %   encoded_data:               Vector containing encoded Hamming codewords.
    %   codeword_length:            Length of the codeword (total symbols per codeword).
    %   k:                          Number of actual information symbols.
    %   generation_polynomial:      Generator polynomial for Hamming encoding.
    %
    % OUTPUT:
    %   decoded_data:               Vector containing decoded and corrected information blocks.

    % Reshape the encoded data into a matrix where each row is a codeword
    encoded_data_matrix = reshape(encoded_data, codeword_length, length(encoded_data) / codeword_length)';

    % Calculate the number of control symbols (parity bits)
    r = codeword_length - k;
    
    % Generate the syndrome calculation matrix
    [~, cyclic_encoding_matrix] = cyclgen(codeword_length, generation_polynomial);
    syndrome_matrix = cyclic_encoding_matrix(:, (1:r));
    syndrome_matrix = [syndrome_matrix; eye(r)];
    
    % Calculate the syndrome for each codeword
    syndrome_value = rem(encoded_data_matrix * syndrome_matrix, 2);
    syndrome_value = syndrome_value * 2.^(r - 1 : -1 : 0)';
    
    % Get the associations vector (syndrome values to error positions mapping)
    associations = get_associations(syndrome_matrix, codeword_length);
    
    % Map the syndrome value to error position
    correction_index = [0, associations(:, 1)'];
    error_indexes = correction_index(syndrome_value + 1);
    
    % Define the error vector table
    error_vector = [zeros(1, codeword_length);
                    eye(codeword_length)];
    
    % Correct the errors in the received codewords
    codeword = rem(encoded_data_matrix + error_vector(error_indexes + 1, :), 2);
    
    % Extract the information symbols from the corrected codewords
    decoded_data_matrix = codeword(:, 1:k)';
    
    % Reshape the decoded data matrix back to a vector
    decoded_data = decoded_data_matrix(:)';
end

function associations = get_associations(syndrome_matrix, codeword_length)
    % GET_ASSOCIATIONS generates the association vector mapping syndrome values to error positions.
    %
    % INPUT:
    %   syndrome_matrix:    Matrix used for syndrome calculation.
    %   codeword_length:    Length of the codeword (total symbols per codeword).
    %
    % OUTPUT:
    %   associations:       Matrix mapping positions to syndrome values, sorted by syndrome value.
    
    % Persistent variable to store the associations across function calls
    persistent cached_associations;
    
    % Check if associations are already calculated
    if isempty(cached_associations)
        % Initialize positions and syndrome decimal value vector
        positions = (1 : codeword_length)';
        syndrome_decimal_value_vector = [];
        
        % Calculate syndrome decimal values for each position
        for i = 1 : codeword_length
            syndrome_decimal_value_vector = [syndrome_decimal_value_vector; bin2dec(num2str(syndrome_matrix(i, :)))];
        end
        
        % Create the associations matrix and sort by syndrome value
        cached_associations = [positions, syndrome_decimal_value_vector];
        cached_associations = sortrows(cached_associations, 2);
    end
    
    % Return the cached associations
    associations = cached_associations;
end
