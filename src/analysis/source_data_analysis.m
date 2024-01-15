% Analysis of a Data Source with Shannon-Fano Code (Task 2)
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs


task(2);


% Calculate source entropy
H = - dot(probability_vector, log2(probability_vector)); % sum(a .* b) = a * b' = dot(a,b)
show(RESULT, H);

% Number of symbols in the alphabet
N  = length(probability_vector);
show(DEBUG, N);

% Maximum source entropy
H_max = log2(N);
show(RESULT, H_max);

% Calculate the redundancy coefficient 'rho'
source_redoundancy = 1 - H/H_max;
show(RESULT, source_redoundancy);
