% Analysis of Shannon-Fano Source Encoding (Task 3)
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(3);

% Probability vector sorted in descending order
P = sort(PROBABILITY_VECTOR, 'descend'); % Probability vector sorted from highest to lowest
show(RESULT, P', 'p'); % Display the sorted probability vector
show(DEBUG, sum(P), 'sum(p)'); % Display the sum of probabilities


% Values obtained with Shannon-Fano code algorithm
m = [3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5]; 
m_0 = [0, 1, 1, 2, 1, 2, 3, 2, 3, 3, 4, 5];
m_1 = [3, 2, 2, 1, 2, 2, 1, 2, 1, 1, 1, 0];
show(DEBUG, m == (m_0 + m_1), 'm == (m_0 + m_1)'); % Check if m equals the sum of m_0 and m_1

% Calculate Averages
m_average = dot(P, m); % Average codeword length
show(RESULT, m_average);

m_0_average = dot(P, m_0); % Average number of 0 symbols
show(DEBUG, m_0_average);

m_1_average = dot(P, m_1); % Average number of 1 symbols
show(DEBUG, m_1_average);

% Calculate Probabilities
P_0 = m_0_average / m_average; % Probability of 0 symbol
show(RESULT, P_0);

P_1 = m_1_average / m_average; % Probability of 1 symbol
show(RESULT, P_1);

show(DEBUG, P_0 + P_1, 'P_0 + P_1'); % Display sum of probabilities (P_0 + P_1)

% Calculate Binary Entropy
H_bin = -P_0 * log2(P_0) - P_1 * log2(P_1); % Binary source entropy after coding
show(RESULT, H_bin);

% Calculate Data Rate
R = H * (m_average * tau) ^ (-1); % Data rate
show(RESULT, R);

% Calculate Compression Ratio
K = m_average / H; % Compression ratio
show(RESULT, K);
