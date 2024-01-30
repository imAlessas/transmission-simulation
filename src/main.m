clc, clearvars, clear, format compact

% Import MATLAB packages
import communications.*  % used for cyclegen

% Import local packages
import utils.*
import func.*

% Display Level Configuration:
% SIMULATION: Runs just the simulation
% ANALYSIS: Runs the analysis
% RESULT: Display values as per guidelines
% DEBUG: Additional display for variables or comparisons
% PLOTS: Toggle for generating plots
SIMULATION = 0; % Set to 1 to compute the simulation
ANALYSIS = 1;   % Set to 1 to enable the analysis
RESULT = 1;     % Set to 1 to display result values
DEBUG = 0;      % Set to 1 to enable additional debugging display
PLOTS = 0;      % Set to 1 to generate plots, 0 to disable plots



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
transmitted_symbol_number = randi(1e5,1);     % number of symbols   
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
    
    padded_sequence = add_padding_bits(shannon_fano_encoded_sequence);
    show(DEBUG, padded_sequence);
end



% = = = = = = = = Task 3 = = = = = = = =
% Analysis of Shannon-Fano Source Encoding

if ANALYSIS
    run("analysis\shannon_fano_encoding_analysis.m");




% = = = = = = = = Task 4 = = = = = = = =
% Analysis of Shannon theorem's condition

    run("analysis\shannon_theorem_condition_analysis.m");





% = = = = = = = = Task 5 = = = = = = = =
% Analysis of cyclic coding

    run("analysis\cyclic_coding_analysis.m");



% = = = = = = = = Task 6 = = = = = = = =


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
    % Wrap into a matrix
    padded_matrix = reshape(padded_sequence, k, length(padded_sequence) / k)';

    hamming_encoded_matrix = hamming_encoding(padded_matrix, codeword_length, k, generation_polynomial);
    hamming_encoded_matrix = hamming_encoded_matrix';

    % unwrap matrix
    hamming_encoded_sequence = hamming_encoded_matrix(:)';
    % show(DEBUG, hamming_encoded_sequence);



% = = = = = = = = = = = = = = = = = = = =
% Perform interleaving


    interleaved_sequence = interleaving(hamming_encoded_sequence);
    % show(DEBUG, interleaved_sequence)



% = = = = = = = = = = = = = = = = = = = =
% Perform scrambling


    scrambled_sequence = scrambling(interleaved_sequence, scrambler_key);
    % show(DEBUG, scrambled_sequence);




% = = = = = = = = = = = = = = = = = = = =
% Perform modulation

    % Define the time-step
    delta_t = tau / samples_per_symbol;
    
    % Time intervals for one symbol
    time_intervals = 0: delta_t: tau - delta_t;
    
    % Create the carrier signal
    carrier_signal = sin(2 * phase_shift * f0 * time_intervals);
    
    % Calculate the energy per symbol
    Eb = dot(carrier_signal, carrier_signal);
    
    % Save length of encoded sequence
    N = length(scrambled_sequence);
    
    % Perform BPSK modulation
    BPSK_signal = kron(-2 * scrambled_sequence + 1, carrier_signal);
end


% = = = = = = = = Task 7 = = = = = = = =
% Analysis of BPSK spectrum

if ANALYSIS
    run("analysis\spectrum_analysis.m")




% = = = = = = = = Task 8 = = = = = = = =
% Analysis of Probability of > 2 errors occurring


    run("analysis\over_two_errors_prob_analysis.m");
end


% = = = = = = = = = = = = = = = = = = = =
% Perform Gaussion White Noise addition

if SIMULATION
    % Reversed SNR formula
    EbN0 = 10^(SNR / 10);
    
    % Obtain noise spectral power density
    N0 = Eb./EbN0;
    
    % Calculate sigma for BPSK
    sigma = sqrt(N0 / 2);
    
    % Create noise signal
    noise_signal = sigma * randn(1, N * samples_per_symbol);
    
    % Create disturbed signal
    disturbed_signal = BPSK_signal + noise_signal;


% = = = = = = = = = = = = = = = = = = = =
% Perform detection

    % Slice recieved signal into segments in each column
    sliced_disturbed_signal = reshape(disturbed_signal, samples_per_symbol, N);
    
    % Detect the signal with the BPSK threshold
    detected_signal = carrier_signal * sliced_disturbed_signal < 0;
    
    show(DEBUG, sum(detected_signal ~= scrambled_sequence), "Demodulation" )


% = = = = = = = = = = = = = = = = = = = =
% Perform descrambling

    descrambled_sequence = descrambling(detected_signal, scrambler_key);
    
    show(DEBUG, sum(descrambled_sequence ~= interleaved_sequence), "Descrambling" )



% = = = = = = = = = = = = = = = = = = = =
% Perform deinterleaving

    deinterleaved_sequence = deinterleaving(descrambled_sequence);
    
    show(DEBUG, sum(deinterleaved_sequence ~= hamming_encoded_sequence), "Deinterleaving" )
    
    
    errors_occurred = sum(deinterleaved_sequence ~= hamming_encoded_sequence);
    show(RESULT, errors_occurred, "Errors occurred during the transmission:");




% = = = = = = = = = = = = = = = = = = = =
% Perform Hamming-decoding and error correction

    % Wraps the sequence into a matrix
    deinterleaved_matrix = reshape(deinterleaved_sequence, codeword_length, length(deinterleaved_sequence) / codeword_length)';
    
    hamming_decoded_matrix = hamming_decoding(deinterleaved_matrix, codeword_length, k, generation_polynomial);
    hamming_decoded_matrix = hamming_decoded_matrix';
    
    % Unwraps the matrix into a sequence
    hamming_decoded_sequence = hamming_decoded_matrix(:)';
    
    show(DEBUG, sum(hamming_decoded_sequence ~= padded_sequence), "Channel decoding" )


% = = = = = = = = = = = = = = = = = = = =
% Remove padding bits

    unpadded_sequence = remove_padding_bits(hamming_decoded_sequence);
    
    show(DEBUG, sum(unpadded_sequence ~= shannon_fano_encoded_sequence), "Unpadding" )

% = = = = = = = = = = = = = = = = = = = =
% Perform Shannon-Fano decoding

    shannon_fano_decoded_sequence = shannon_fano_decoding(unpadded_sequence);
    
    show(DEBUG, sum(shannon_fano_decoded_sequence ~= initial_symbol_sequence), "Source decoding" )

% = = = = = = = = = = = = = = = = = = = =
% Correctness checkig

    received_symbol_sequence = shannon_fano_decoded_sequence;
    
    show(DEBUG, initial_symbol_sequence);
    show(DEBUG, received_symbol_sequence);
    
    % Shows the actual errors between the initial and the final sequence
    errors_occurred = sum(shannon_fano_decoded_sequence ~= initial_symbol_sequence);
    show(RESULT, errors_occurred, "Uncorrected errors:");
end


