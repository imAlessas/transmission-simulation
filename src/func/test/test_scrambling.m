clc, clear, format compact

import func.*

% Set the number of tests to be performed
number_of_tests = 100;

% Initialize an array to store test results
result = 1 : number_of_tests;

% Start measuring the test duration
tic;

% Loop through each test iteration
for i = 1 : length(result)
    fprintf('Test #%i', i);

    % Generate a random codeword length
    codeword_length = randi(1e4, 1);

    % Generate a random number N for the length of the symbol sequence
    N = codeword_length * randi(1e4, 1);

    % Generate a random binary symbol sequence
    symbol_sequence = randi(2, 1, N) - 1;

    % Generate a random scrambler key
    scrambler_key = randi(2, 1, codeword_length) - 1;

    % Scramble the symbol sequence using the scrambling function
    scrambled_sequence = scrambling(symbol_sequence, scrambler_key);

    % Descramble the scrambled sequence using the descrambling function
    unscrambled_sequence = descrambling(scrambled_sequence, scrambler_key);

    % Count the number of errors between the original and descrambled sequences
    result(i) = sum(symbol_sequence ~= unscrambled_sequence);

    % Check and display the test result (✔ if passed, ✘ if failed)
    if result(i) == 0
        fprintf('   ✔\n');
    else
        fprintf('   ✘     %i\n', result(i));
    end
end

% Calculate the total number of errors
errors = sum(result);

% Store the total duration of the test
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

