function encoded_data = hamming_encoding(binary_data_matrix, codeword_length, k, generation_polynomial)
% The function calculates Hamming group (m,k) encoder output in matrix form 
% for multiple data blocks.
% Input:
%   binary_data - a matrix with k rows, each row represents a single data block to be coded;
%   codeword_length     - Hamming codeword length;
%   k     - number of information symbols per codeword;
% Output:
%   encoded_data - a matrix with m rows, each row represents a Hamming group codeword.
r = codeword_length - k;

% Encoding matrix - derrived from coding equations.
% Each column represents one equation (non-systematic code).
[~, cyclic_encoding_matrix] = cyclgen(codeword_length, generation_polynomial);

reorder = [r + 1 : codeword_length, 1 : r];

cyclic_encoding_matrix = cyclic_encoding_matrix (:, reorder); 


% Calculate control symbol values 
% Use rem() function to find modulo 2 sum as a remainder of division by 2
encoded_data = rem(binary_data_matrix * cyclic_encoding_matrix, 2);   % Use matrix multiplication to improve performance