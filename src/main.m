clc, clearvars, clear, format compact

import utils.*

% Display Level Configuration:
% RESULT: Display values as per guidelines
% DEBUG: Additional display for variables or comparisons
% PLOTS: Toggle for generating plots
RESULT = 1;  % Set to 1 to display result values
DEBUG = 0;   % Set to 1 to enable additional debugging display
PLOTS = 0;   % Set to 1 to generate plots, 0 to disable plots




% = = = = = = = = = = = = = = = = = = = =
% Initial constant parameters

% source number 7
ALPHABET = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
PROBABILITY_VECTOR = [11, 7, 9, 1, 6, 6, 13, 14, 13, 5, 11, 4]/100;

TAU = 60e-9; % symbol duration time, [s]
SNR = 8.1; % Signal-to-Noise-Ration, [dB]
% Source Code: Shannon-Fano
% Error correction code: Cyclic
CODEWORD_LENGTH = 31; % m
% 
F_0 = 2.5e+9; % carrier frequency [Hz]
% Modulation: BPSK
PHASE_SHIFT = pi; % [rad]
U = 1; % amplitude BPSK signal [V]

transmitted_symbol_number = 20;









% = = = = = = = = = = = = = = = = = = = =
% Source generation

alphabet_matrix = [ALPHABET; PROBABILITY_VECTOR];
show(DEBUG, alphabet_matrix);

initial_symbol_sequence = symbol_sequence_generator(alphabet_matrix, transmitted_symbol_number);
show(DEBUG, initial_symbol_sequence);



% = = = = = = = = Task 2 = = = = = = = =
% Analysis of data source with Shannon-Fano code 

run("analysis\source_data_analysis.m")



% = = = = = = = = = = = = = = = = = = = =
% Perform Shannon-Fano Source Encoding

shannon_fano_encoded_sequence = shannon_fano_encoding(initial_symbol_sequence);
show(RESULT, shannon_fano_encoded_sequence);



% = = = = = = = = Task 3 = = = = = = = =
% Analysis of Shannon-Fano Source Encoding

run("analysis\shannon_fano_encoding_analysis.m")



% = = = = = = = = Task 4 = = = = = = = =
% Analysis of Shannon theorem's condition

run("analysis\shannon_theorem_condition_analysis.m")





% = = = = = = = = Task 5 = = = = = = = =
% Analysis of cyclic coding




% = = = = = = = = Task 6 = = = = = = = =




% = = = = = = = = = = = = = = = = = = = =
% Perform Cyclic-Hamming channel coding




% = = = = = = = = = = = = = = = = = = = =
% Perform interleaving




% = = = = = = = = = = = = = = = = = = = =
% Perform scrambling


% = = = = = = = = Task 7 = = = = = = = =
% Analysis of BPSK spectrum

run("analysis\spectrum_analysis.m")



% = = = = = = = = Task 8 = = = = = = = =
% Analysis of Probability of > 2 errors occurring

run("analysis\over_two_errors_prob_analysis.m");




