clc, clearvars, clear, format compact

% Import MATLAB packages
import communications.*  % used for cyclegen

% Import local packages
import utils.*
import func.*

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
alphabet = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
probability_vector = [11, 7, 9, 1, 6, 6, 13, 14, 13, 5, 11, 4]/100;

tau = 60e-9;                        % symbol duration time, [s]
SNR = 8.1;                          % Signal-to-Noise-Ration, [dB]
                                    % Source Code: Shannon-Fano
                                    % Error correction code: Cyclic
generation_polynomial = [...        % z^5 + z^2 + z^0
    1 0 0 1 0 1]; 
codeword_length = 31;               % m

f0 = 2.5e+9;                        % carrier frequency [Hz]
                                    % Modulation: BPSK
phase_shift = pi;                   % Phase shift [rad]
U = 1;                              % amplitude BPSK signal [V]



% Additional data
transmitted_symbol_number = 50;     % number of symbols   
samples_per_symbol = 500;           % samples per symbol
r = ceil(log2(codeword_length + 1));% r
k = codeword_length - r;            % k

% Used for the scrambling/descrmabling algorithm
scrambler_key = randi(2, 1, codeword_length) - 1; 








% = = = = = = = = = = = = = = = = = = = =
% Source generation

alphabet_matrix = [alphabet; probability_vector];
show(DEBUG, alphabet_matrix);

initial_symbol_sequence = symbol_sequence_generator(alphabet_matrix, transmitted_symbol_number);
show(DEBUG, initial_symbol_sequence);



% = = = = = = = = Task 2 = = = = = = = =
% Analysis of data source with Shannon-Fano code 

run("analysis\source_data_analysis.m")



% = = = = = = = = = = = = = = = = = = = =
% Perform Shannon-Fano Source Encoding

shannon_fano_encoded_sequence = shannon_fano_encoding(initial_symbol_sequence);
show(DEBUG, shannon_fano_encoded_sequence);

padded_encoded_sequence = add_padding_bits(shannon_fano_encoded_sequence);
show(DEBUG, padded_encoded_sequence);



% = = = = = = = = Task 3 = = = = = = = =
% Analysis of Shannon-Fano Source Encoding

run("analysis\shannon_fano_encoding_analysis.m")



% = = = = = = = = Task 4 = = = = = = = =
% Analysis of Shannon theorem's condition

run("analysis\shannon_theorem_condition_analysis.m")





% = = = = = = = = Task 5 = = = = = = = =
% Analysis of cyclic coding




% = = = = = = = = Task 6 = = = = = = = =

% 1 - For the analysis will be generated a new sequence
% 0 - The current sequence will be analized (better with high value for
%     transmitted_symbol_number)
GENERATE_NEW_SEQUENCE = 1;
run("analysis\hamming_coding_analysis.m")




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




