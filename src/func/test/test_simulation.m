clc, clear, format compact

% Import necessary packages
import communications.*  % Used for cyclegen
import func.*            % Import user-defined functions

% Define the alphabet and its probability vector for symbol generation
alphabet = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
probability_vector = [11, 7, 9, 1, 6, 6, 13, 14, 13, 5, 11, 4]/100;

% Set simulation parameters
tau = 60e-9;                % Symbol duration time, [s]
SNR = 8.1;                  % Signal-to-Noise-Ratio, [dB]
generation_polynomial = [1 0 0 1 0 1];  % Generator polynomial for Hamming encoding
codeword_length = 31;       % Length of the codeword (m)

% Set modulation parameters
f0 = 2.5e+9;                % Carrier frequency [Hz]
phase_shift = pi;           % Phase shift [rad]
U = 1;                      % Amplitude of BPSK signal [V]

% Additional data for simulation
samples_per_symbol = 500;   % Samples per symbol
r = ceil(log2(codeword_length + 1));          % r for Hamming encoding
k = codeword_length - r;    % k for Hamming encoding

% Number of tests to perform
number_of_tests = 100;

% Initialize result array to store test outcomes
result = 1 : number_of_tests;

% Record the start time for the test duration calculation
tic;

% Loop through each test
for i = 1 : length(result)
    fprintf('Test #%i', i);

    % Generate a random number of symbols to transmit
    transmitted_symbol_number =  randi(1e4, 1);

    % Generate the initial symbol sequence based on the alphabet and probabilities
    alphabet_matrix = [alphabet; probability_vector];
    initial_symbol_sequence = symbol_sequence_generator(alphabet_matrix, transmitted_symbol_number);

    % Perform Shannon-Fano encoding on the initial symbol sequence
    shannon_fano_encoded_sequence = shannon_fano_encoding(initial_symbol_sequence);
    
    % Add padding bits to the Shannon-Fano encoded sequence
    padded_sequence = add_padding_bits(shannon_fano_encoded_sequence);

    % Reshape the padded sequence into a matrix for Hamming encoding
    padded_matrix = reshape(padded_sequence, k, length(padded_sequence) / k)';
    
    % Perform Hamming encoding
    hamming_encoded_matrix = hamming_encoding(padded_matrix, codeword_length, k, generation_polynomial);
    hamming_encoded_matrix = hamming_encoded_matrix';

    % Unwrap the matrix into a sequence
    hamming_encoded_sequence = hamming_encoded_matrix(:)';

    % Perform interleaving on the Hamming encoded sequence
    interleaved_sequence = interleaving(hamming_encoded_sequence);

    % Generate a random scrambler key
    scrambler_key = randi(2, 1, codeword_length) - 1; 

    % Perform scrambling on the interleaved sequence
    scrambled_sequence = scrambling(interleaved_sequence, scrambler_key);

  

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

    % Reversed SNR formula
    EbN0 = 10^(SNR / 10);
    
    % Obtain noise spectral power density
    N0 = Eb./EbN0;
    
    % Calculate sigma for BPSK
    sigma = sqrt(N0 / 2);
    
    % Create noise signal
    noise_signal = sigma * randn(1, N * samples_per_symbol);
    
    % Create disturbed signal by adding noise to the modulated signal
    disturbed_signal = BPSK_signal + noise_signal;

    % Slice the received signal into segments in each column
    sliced_disturbed_signal = reshape(disturbed_signal, samples_per_symbol, N);
    
    % Detect the signal with the BPSK threshold
    detected_signal = carrier_signal * sliced_disturbed_signal < 0;



    % Perform descrambling on the detected signal
    descrambled_sequence = descrambling(detected_signal, scrambler_key);
    
    % Perform deinterleaving on the descrambled sequence
    deinterleaved_sequence = deinterleaving(descrambled_sequence);

    % Reshape the deinterleaved sequence into a matrix for Hamming decoding
    deinterleaved_matrix = reshape(deinterleaved_sequence, codeword_length, length(deinterleaved_sequence) / codeword_length)';
    
    % Perform Hamming decoding
    hamming_decoded_matrix = hamming_decoding(deinterleaved_matrix, codeword_length, k, generation_polynomial);
    hamming_decoded_matrix = hamming_decoded_matrix';
    
    % Unwrap the matrix into a sequence
    hamming_decoded_sequence = hamming_decoded_matrix(:)';

    % Remove padding bits from the decoded Hamming sequence
    unpadded_sequence = remove_padding_bits(hamming_decoded_sequence);

    % Perform Shannon-Fano decoding on the unpadded sequence
    shannon_fano_decoded_sequence = shannon_fano_decoding(unpadded_sequence);

    % Set the received symbol sequence for comparison
    received_symbol_sequence = shannon_fano_decoded_sequence;

    % Compare the original symbol sequence with the decoded sequence
    result(i) = sum(initial_symbol_sequence ~= received_symbol_sequence);

    % Display test result (✔ if passed, ✘ if failed)
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

% Display a new line for better readability
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
