clc, clear, format compact


% --------- TASK 5 -------------

% needed to use cyclgen function
import communications.* 


% Get binary data by encoding your name
codeword_length = 31; % codeword length
r = round(log2(codeword_length + 1) + 0.49); % check symbols
k = codeword_length - r; % data symbols

generation_polynomial = [1 0 0 1 0 1]; % z^5 + z^2 + z^0



% generated by your name: 26 symbols
% vocals = 1, consonants = 0
binary_data =  [1 0 1 0 0 1 0 0 0 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 0 0];

% generate decoding and encoding matrix
[cyclic_decoding_matrix, cyclic_encoding_matrix] = cyclgen(codeword_length, generation_polynomial);

% reorder the matrix
% copy this reorder index in index on function put zero at the beginning: [0 7 8 9 ... 31 1 2 ... 6]

reorder = [6:codeword_length, 1:5]; % change data symbols position: first 6 -> 32, then 0 -> 5

cyclic_encoding_matrix = cyclic_encoding_matrix (:, reorder); % copy in function encHamming

cyclic_decoding_matrix = (cyclic_decoding_matrix (:, reorder))'; % copy in function decHamming

% encode the codeword
codeword = mod(binary_data * cyclic_encoding_matrix, 2);

% decode without errors
syndrome_no_error = mod(codeword * cyclic_decoding_matrix, 2);


% introduce one error
error_position = 2;
codeword(error_position) =~ codeword(error_position);

syndrome_one_error = mod(codeword * cyclic_decoding_matrix, 2)





