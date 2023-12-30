clc, clear, format compact

% Import utility functions from the 'utils' package
import func.*

% Set number of tests
number_of_tests = 100;

% Initialize result array with values from 1 to 5
result = 1 : number_of_tests;

% Start measuring the test duration
tic;

% Loop through each test iteration
for i = 1 : length(result)
    fprintf('Test #%i', i);

    % Generate a random number N for the length of the symbol sequence
    N = 31 * randi(1e6, 1);
    
    % Generate a random binary symbol sequence
    symbol_sequence = randi(2, 1, N) - 1;
    
    % Apply interleaving to the symbol sequence
    mixed_sequence = interleaving(symbol_sequence);
    
    % Apply deinterleaving to the interleaved sequence
    unmixed_sequence = deinterleaving(mixed_sequence);
    
    % Count the number of errors between the original and deinterleaved sequences
    result(i) = sum(symbol_sequence ~= unmixed_sequence);
    
    % Check and display the test result (✔ if passed, ✘ if failed)
    if result(i) == 0
        fprintf('   ✔\n');
    else
        fprintf('   ✘     %i\n', result(i));
    end
end

% Calculate the total number of errors
errors = sum(result);

% Store the test duration
test_duration = toc;

% Display new line
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
