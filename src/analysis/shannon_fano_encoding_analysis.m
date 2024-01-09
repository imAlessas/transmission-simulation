% Analysis of Shannon-Fano Source Encoding (Task 3)
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(3);

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
R = H * (m_average * TAU) ^ (-1); % Data rate
show(RESULT, R);

% Calculate Compression Ratio
K = m_average / H; % Compression ratio
show(RESULT, K);
