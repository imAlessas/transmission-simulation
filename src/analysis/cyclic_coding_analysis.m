% Analysis of cyclic error correction code (Tak 5)

task(5)

% generate a sequence of k binary symbols
binary_sequence =  randi(2, 1, k) - 1;

% generate decoding and encoding matrix
[cyclic_decoding_matrix, cyclic_encoding_matrix] = cyclgen(codeword_length, generation_polynomial);

% reorder the matrixes
% [6 -> 31, 1 ->]
reorder = [6:codeword_length, 1:5];

cyclic_encoding_matrix = cyclic_encoding_matrix (:, reorder); 

cyclic_decoding_matrix = (cyclic_decoding_matrix (:, reorder))'; 

% Associates the syndrome to the bit.
% This vector has been calculated in the hamming_decoding function and
% copy-pasted here.
associations = [0 31 30 13 29 26 12 20 28 2 25 4 11 23 19 8 27 21 1 14 24 9 3 5 10 6 22 15 18 17 7 16];


% encode the codeword
codeword = mod(binary_sequence * cyclic_encoding_matrix, 2);
initial_codeword = codeword;

% decode without errors
syndrome_no_error = mod(codeword * cyclic_decoding_matrix, 2);



% introduce one error
error_position = randi(31, 1);
codeword(error_position) =~ codeword(error_position);

codeword_one_error = codeword;
show(DEBUG, codeword_one_error);

% get the error syndrome
syndrome_one_error = mod(codeword_one_error * cyclic_decoding_matrix, 2);

% convert the syndrome int decimal
syndrome_one_error_decimal = bin2dec(num2str(syndrome_one_error));

% get the index of the wrong symbol
wrong_symbol_position = associations(syndrome_one_error_decimal + 1);

% correct the error
codeword_one_error(wrong_symbol_position) = ~codeword_one_error(wrong_symbol_position);

show(RESULT, sum(initial_codeword ~= codeword_one_error), "One error introduced")



% introduce second error
error_position = randi(31, 1);
codeword(error_position) =~ codeword(error_position);


codeword_two_errors = codeword;
show(DEBUG, codeword_two_errors);

% get the error syndrome
syndrome_two_errors = mod(codeword_two_errors * cyclic_decoding_matrix, 2);

% convert the syndrome int decimal
syndrome_two_errors_decimal = bin2dec(num2str(syndrome_two_errors));

% get the index of the wrong symbol
wrong_symbol_position = associations(syndrome_two_errors_decimal + 1);

% correct the error
codeword_two_errors(wrong_symbol_position) = ~codeword_two_errors(wrong_symbol_position);

show(RESULT, sum(initial_codeword ~= codeword_two_errors), "Two errors introduced");

