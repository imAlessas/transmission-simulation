% Analysis of a Data Source with Shannon-Fano Code (Task 2)
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(2);

% Probability vector sorted in descending order
P = sort(PROBABILITY_VECTOR, 'descend'); % Probability vector sorted from highest to lowest
show(RESULT, P', 'p'); % Display the sorted probability vector
show(DEBUG, sum(P), 'sum(p)'); % Display the sum of probabilities


% Values obtained with Shannon-Fano code algorithm
m = [3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5]; 
m_0 = [0, 1, 1, 2, 1, 2, 3, 2, 3, 3, 4, 5];
m_1 = [3, 2, 2, 1, 2, 2, 1, 2, 1, 1, 1, 0];
show(DEBUG, m == (m_0 + m_1), 'm == (m_0 + m_1)'); % Check if m equals the sum of m_0 and m_1

% Calculate source entropy
H = - dot(P, log2(P)); % sum(a .* b) = a * b' = dot(a,b)
show(RESULT, H);

% Number of symbols in the alphabet
N  = length(P);
show(DEBUG, N);

% Maximum source entropy
H_max = log2(N);
show(RESULT, H_max);

% Calculate the redundancy coefficient 'rho'
source_redoundancy = 1 - H/H_max;
show(RESULT, source_redoundancy);