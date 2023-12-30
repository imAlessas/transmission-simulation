clc, clear, format compact

import utils.*


% Number of tests to perform
number_of_tests = 100;

% Define the alphabet and probability vector for the symbol matrix
ALPHABET = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
PROBABILITY_VECTOR = [11, 7, 9, 1, 6, 6, 13, 14, 13, 5, 11, 4]/100;
matrix = [ALPHABET; PROBABILITY_VECTOR];

% Initialize result array to store test outcomes
result = 1 : number_of_tests;

% Define the number of symbols in each test
symbol_number = 1e6;

% Define the accepted fluctuation for probability comparison
accepted_fluctuation = 0.01;

% Record the start time for the test duration calculation
tic;

% Initialize symbol sequence and probability vector for the current test
symbol_sequence = [];
current_probability_vector = zeros(1, length(ALPHABET));

% Loop through each test
for i = 1:length(result)
    fprintf('Test #%i', i);
    
    % Generate a symbol sequence based on the provided matrix
    symbol_sequence = symbol_sequence_generator(matrix, symbol_number);

    % Calculate the current probability vector from the generated symbol sequence
    for j = 1: length(ALPHABET)
        current_probability_vector(j) = sum(symbol_sequence(:) == j);
    end
    current_probability_vector = current_probability_vector / symbol_number;

    % Compare the expected probability vector with the current probability vector
    result(i) = sum( abs( PROBABILITY_VECTOR - current_probability_vector) >= accepted_fluctuation);

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

% Plot the source probability distribution
f = figure(1);
f.Name = 'Source probability distribution';
f.NumberTitle = 'off';
f.Position = [450, 100, 700, 600];

stem(ALPHABET, current_probability_vector), grid on;
xlabel('Alphabet'), ylabel('Probabilty'), title('Source probability distribution');
xlim([0, 13]), ylim([0, .15]);

