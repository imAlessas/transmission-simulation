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
RESULT = 1;     % Set to 1 to display result values
DEBUG = 0;      % Set to 1 to enable additional debugging display
PLOTS = 0;      % Set to 1 to generate plots, 0 to disable plots
SIMULATION = 0; % Set to 1 to compute the simulation
ANALYSIS = 1;   % Set to 1 to enable the analysis



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
transmitted_symbol_number = 3;     % number of symbols   
samples_per_symbol = 500;           % samples per symbol
r = ceil(log2(codeword_length + 1));% r
k = codeword_length - r;            % k

% Used for the scrambling/descrmabling algorithm
scrambler_key = randi(2, 1, codeword_length) - 1; 








% = = = = = = = = = = = = = = = = = = = =
% Source generation

if SIMULATION
    alphabet_matrix = [alphabet; probability_vector];
    show(DEBUG, alphabet_matrix);
    
    initial_symbol_sequence = symbol_sequence_generator(alphabet_matrix, transmitted_symbol_number);
    show(DEBUG, initial_symbol_sequence);
end



% = = = = = = = = Task 2 = = = = = = = =
% Analysis of data source with Shannon-Fano code 

if ANALYSIS
    run("analysis\source_data_analysis.m");
end


% = = = = = = = = = = = = = = = = = = = =
% Perform Shannon-Fano Source Encoding

if SIMULATION
    shannon_fano_encoded_sequence = shannon_fano_encoding(initial_symbol_sequence);
    show(DEBUG, shannon_fano_encoded_sequence);
    
    padded_encoded_sequence = add_padding_bits(shannon_fano_encoded_sequence);
    show(DEBUG, padded_encoded_sequence);
end



% = = = = = = = = Task 3 = = = = = = = =
% Analysis of Shannon-Fano Source Encoding

if ANALYSIS
    run("analysis\shannon_fano_encoding_analysis.m");
end



% = = = = = = = = Task 4 = = = = = = = =
% Analysis of Shannon theorem's condition

if ANALYSIS
    run("analysis\shannon_theorem_condition_analysis.m");
end





% = = = = = = = = Task 5 = = = = = = = =
% Analysis of cyclic coding

if ANALYSIS
    run("analysis\cyclic_coding_analysis.m");
end



% = = = = = = = = Task 6 = = = = = = = =

if ANALYSIS
    % 1 - For the analysis will be generated a new sequence
    % 0 - The current sequence will be analized (better with high value for
    %     transmitted_symbol_number)
    %     NOTE: to work, the SIMULATION flag should be 1.
    GENERATE_NEW_SEQUENCE = 1;

    run("analysis\hamming_coding_analysis.m");
end




% = = = = = = = = = = = = = = = = = = = =
% Perform Cyclic-Hamming channel coding

if SIMULATION
    binary_data_matrix = reshape(padded_encoded_sequence, k, length(padded_encoded_sequence) / k)';

    hamming_encoded_matrix = hamming_encoding(binary_data_matrix, codeword_length, k, generation_polynomial);
    
    hamming_encoded_sequence = hamming_encoded_matrix(:)';
    show(DEBUG, hamming_encoded_sequence);
end


% = = = = = = = = = = = = = = = = = = = =
% Perform interleaving

if SIMULATION
    interleaved_sequence = interleaving(hamming_encoded_sequence);
    show(DEBUG, interleaved_sequence)
end


% = = = = = = = = = = = = = = = = = = = =
% Perform scrambling

if SIMULATION
    scrambled_sequence = scrambling(interleaved_sequence, scrambler_key);
    show(DEBUG, scrambled_sequence);
end



% = = = = = = = = Task 7 = = = = = = = =
% Analysis of BPSK spectrum

if ANALYSIS
    run("analysis\spectrum_analysis.m")
end



% = = = = = = = = Task 8 = = = = = = = =
% Analysis of Probability of > 2 errors occurring

if ANALYSIS
    run("analysis\over_two_errors_prob_analysis.m");
end




