clc, clear, format compact

import utils.*

% Number of tests to perform
number_of_tests = 100;

% Alphabet and probability vector for the symbol matrix
ALPHABET = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
PROBABILITY_VECTOR = [11, 7, 9, 1, 6, 6, 13, 14, 13, 5, 11, 4]/100;
alphabet_matrix = [ALPHABET; PROBABILITY_VECTOR];

% Initialize result array to store test outcomes
result = 1 : number_of_tests;

% Record the start time for the test duration calculation
tic;

% Loop through each test
for i = 1 : length(result)
    fprintf('Test #%i', i);

    % Generate a random symbol sequence based on the provided matrix
    symbol_sequence = symbol_sequence_generator(alphabet_matrix, randi(1e4, 1));

    % Encode the generated symbol sequence using Shannon-Fano encoding
    encoded_sequence = shannon_fano_encoding(symbol_sequence);

    % Decode the encoded sequence using Shannon-Fano decoding
    decoded_sequence = shannon_fano_decoding(encoded_sequence);

    % Compare the original symbol sequence with the decoded sequence
    result(i) = sum(symbol_sequence ~= decoded_sequence);

    % Display test result
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
