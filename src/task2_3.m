clc, clearvars, clear, format compact


% Task 2

% Probability distribution for source #7

SYMBOL_DURATION_TIME = 60e-9; % secods

PROBABILITY_VECTOR = [0.11, 0.07, 0.09, 0.01, 0.06, 0.06, 0.13, 0.14, 0.13, 0.05, 0.11, 0.04];
p = sort(PROBABILITY_VECTOR, 'descend'); % descending

m = [3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5];
m_0 = [0, 1, 1, 2, 1, 2, 3, 2, 3, 3, 4, 5];
m_1 = [3, 2, 2, 1, 2, 2, 1, 2, 1, 1, 1, 0];

H = - dot(p, log2(p)); % = - p * log2(p') = - sum( p .* log2(p) )

N  = length(p);
H_max = log2(N);

source_redoundancy = 1 - H/H_max;




