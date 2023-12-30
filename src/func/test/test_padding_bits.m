clc, clear, format compact

import func.*

% Number of tests to perform
number_of_tests = 100;

% Initialize result array to store test outcomes
result = 1 : number_of_tests;

% Record the start time for the test duration calculation
tic;

% Loop through each test
for i = 1 : length(result)
    fprintf('Test #%i', i);

    % Generate a random length for the symbol sequence
    N = randi(1e8, 1);

    % Generate a random binary symbol sequence
    symbol_sequence = randi(2, 1, N) - 1;

    % Add padding bits to the symbol sequence
    padded_sequence = add_padding_bits(symbol_sequence);

    % Remove padding bits from the padded sequence
    compact_sequence = remove_padding_bits(padded_sequence);

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
disp("Test duration: " + test_duration);
