clc; clear; format compact

% Import functions from the specified package or directory
import func.*

% Number of tests to perform
number_of_tests = 100;

% Initialize result array to store test outcomes
result = zeros(1, number_of_tests);

% Record the start time for the test duration calculation
tic;

% Loop through each test
for i = 1 : number_of_tests
    fprintf('Test #%i', i);

    % Generate a random codeword length between 15 and 115 (inclusive)
    codeword_length = 15 + randi(1e2, 1);

    % Calculate the number of bits needed to store the padding information
    r = ceil(log2(codeword_length + 1));

    % Calculate the length of the compact sequence without padding bits
    k = codeword_length - r;

    % Generate a random length for the symbol sequence
    N = randi(1e8, 1);

    % Generate a random binary symbol sequence of length N
    symbol_sequence = randi([0, 1], 1, N);

    % Add padding bits to the symbol sequence
    padded_sequence = add_padding_bits(symbol_sequence, k, r);

    % Remove padding bits from the padded sequence
    compact_sequence = remove_padding_bits(padded_sequence, r);

    % Compare the original symbol sequence with the compacted sequence
    result(i) = sum(symbol_sequence ~= compact_sequence);

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
disp("Test duration: " + test_duration + " seconds");
