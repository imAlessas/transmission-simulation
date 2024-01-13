clc, clear, format compact

import communications.*  % Used for cyclegen
import func.*

% Number of tests to perform
number_of_tests = 100;

% Initialize result array to store test outcomes
result = 1 : number_of_tests;

% The length of the codeword, also called m
codeword_length = 31;

% The number of actual information symbols
k = 26;

% Generation polynomial: z^5 + z^2 + z^0
generation_polynomial = [1 0 0 1 0 1];

% Record the start time for the test duration calculation
tic;

% Loop through each test
for i = 1 : length(result)
    fprintf('Test #%i', i);

    % Generate a random number N for the length of the symbol sequence
    N = k * randi(1e6, 1);

    % Generate a random binary symbol sequence
    symbol_sequence = randi(2, 1, N) - 1;

    % Reshape the symbol sequence into a matrix
    symbol_sequence_matrix = reshape(symbol_sequence, k, N/k)';

    % Perform Hamming encoding on the symbol sequence matrix
    encoded_sequence_matrix = hamming_encoding(symbol_sequence_matrix, codeword_length, k, generation_polynomial);

    % Introduce random errors in the encoded sequence matrix
    for j = 1 : length(encoded_sequence_matrix(:,1))
        error_position = randi(codeword_length, 1);
        encoded_sequence_matrix(j, error_position) = ~encoded_sequence_matrix(j, error_position);
    end

    % Perform Hamming decoding on the encoded sequence matrix
    decoded_sequence_matrix = hamming_decoding(encoded_sequence_matrix, codeword_length, k, generation_polynomial);

    % Reshape the decoded sequence matrix into a vector
    decoded_sequence = reshape(decoded_sequence_matrix', 1, []);

    % Compare the original symbol sequence with the decoded sequence
    result(i) = sum(symbol_sequence ~= decoded_sequence);

    % Display test result (✔ if passed, ✘ if failed)
    if result(i) == 0
        fprintf('   ✔\n');
    else
        fprintf('   ✘     %i\n', result(i));
    end
end

% Calculate the total number of errors
errors = sum(result);

% Record the end time for the test duration calculation
test_duration = toc;

% Display a new line for better readability
disp(newline)

% Display the overall test result
if errors == 0
    disp("Test successfully passed!");
else
    disp("Test failed!");
    disp("Total errors occurred: " + errors);
end

% Display the total duration of the test
disp("Test duration: " + test_duration);
