function decoded_data = hamming_decoding(codeword_matrix, codeword_length, k, generation_polynomial)
% The function performs decoding of Hamming group (m,k) codewords specified in
% matrix form for multiple codewords.
% Input:
%   cdWrd - a matrix with m rows, each row represents a single codeword to be decoded;
%   m     - Hamming codeword length;
%   k     - number of information symbols per codeword;
% Output:
%   decoded_data - a matrix with k rows, each row represents a decoded and corrected information block.
  
% First, determine the number of control symbols  
r = codeword_length - k;

% Specify syndrome calculation matrix
% Each column contains symbols from equations

[~, cyclic_encoding_matrix] = cyclgen(codeword_length, generation_polynomial);

syndrome_matrix = cyclic_encoding_matrix(:, (1:r));
% syndrome_matrix

syndrome_matrix =  [syndrome_matrix; eye(r)];

% Calculate syndrome for each codeword
% Use rem() function to find modulo 2 sum as a remainder of division by 2
% syndrome_matrix

syndrome_value = rem(codeword_matrix * syndrome_matrix, 2);     % Use matrix multiplication to improve performance
syndrome_value = syndrome_value * 2.^(r - 1 : -1 : 0)';

% error_indexes = syndrome_value .* (syndrome_value <= codeword_length);    % Error indices match symbol positions for Group code

% For cyclic code, additionally conversion of indexes must be performed
% Each number matches the erroneus symbol position for matching syndrome.
% I.e., position 0 - no errors, so remains 0
%       position 1 (001) - error in 0000001, which is 7-th symbol
%       position 2 (010) - error in 0000010, which is 6-th symbol

positions = (1 : codeword_length)';
syndrome_decimal_value_vector = [];

for i = 1 : codeword_length
    syndrome_decimal_value_vector = [syndrome_decimal_value_vector ; bin2dec(num2str(syndrome_matrix(i, :)))];
end

associations = [positions, syndrome_decimal_value_vector];
associations = sortrows(associations, 2);

correction_index = [0, associations(:, 1)'];   % Cyclic
error_indexes = correction_index(syndrome_value + 1);    % Cyclic

% Specify table of all error vector. Note: the first row must be "no errors" vector.
error_vector =  [zeros(1, codeword_length)
                  eye(codeword_length)]; 

% Perform correction, by adding error vector to received codeword.
% Note: Add +1 to syndrom because of indexing in Matlab (starts from 1, not 0)
codeword = rem(codeword_matrix + error_vector(error_indexes + 1, :), 2);

% Read the columns of data symbols to form decoded data
decoded_data = codeword(:, 1:k);    % Cyclic code



