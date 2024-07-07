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
    symbol_sequence = randi([0, 1], 1, N);

    % Perform Hamming encoding on the symbol sequence
    encoded_sequence = hamming_encoding(symbol_sequence, codeword_length, k, generation_polynomial);

    % Introduce random errors in the encoded sequence
    num_codewords = length(encoded_sequence) / codeword_length;
    for j = 1 : num_codewords
        error_position = randi(codeword_length, 1);
        encoded_sequence((j-1) * codeword_length + error_position) = ...
            ~encoded_sequence((j-1) * codeword_length + error_position);
    end

    % Perform Hamming decoding on the encoded sequence
    decoded_sequence = hamming_decoding(encoded_sequence, codeword_length, k, generation_polynomial);

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
