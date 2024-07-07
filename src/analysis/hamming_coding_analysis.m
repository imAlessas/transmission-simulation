% Analysis of Cyclic Hamming Encoding (Task 6)

task(6);

% Initialize SNR vector
SNR_vector = 0 : 1/2 : 15; 


% Generation of binary sequence

if ~GENERATE_NEW_SEQUENCE
    if ~SIMULATION && ANALYSIS
        fprintf("Error: Unable to use the current sequence because SIMULATION flag is disable.\n" + ...
            "Try enabling it.\nA new sequence will be generated from scratch.\n\n\n")
        N = 1e4; % number of bits to be sent
        N = floor(N / k) * k; % match information block size
        binary_sequence = randi(2, 1, N) - 1; 
    else
        binary_sequence = padded_sequence;
        N = length(padded_sequence);
    end
    
else
    N = 1e4; % number of bits to be sent
    N = floor(N / k) * k; % match information block size
    binary_sequence = randi(2, 1, N) - 1;
end

show(DEBUG, binary_sequence);
show(DEBUG, N);




% Generate carrier signal

% Define the time-step
delta_t = tau / samples_per_symbol;

% Time intervals for one symbol
time_intervals = 0: delta_t: tau - delta_t;

% Create the carrier signal
carrier_signal = sin(2 * pi * f0 * time_intervals); % Carrier signal

% Calculate the energy per symbol
Eb = dot(carrier_signal, carrier_signal);




% Hamming encoding

hamming_encoded_sequence = hamming_encoding(binary_sequence, codeword_length, k, generation_polynomial);
show(DEBUG, hamming_encoded_sequence);

% Update the number of bits
M = N;
N = length(hamming_encoded_sequence);
show(DEBUG, M);
show(DEBUG, N)

% Modulate the sequence with BPSK
BPSK_signal = kron(-2 * hamming_encoded_sequence + 1, carrier_signal);



% Generate noise power

% Reversed SNR formula
EbN0 = 10.^(SNR_vector / 10);

% Obtain noise spectral power density
N0 = Eb./EbN0;

% Calculate sigma for BPSK
sigma = sqrt(N0 / 2);




% Prepare the vectors for the for-loop
BER_no_hamming = 1 : length(SNR_vector);
BER_with_hamming = 1 : length(SNR_vector);

for i = 1 : length(SNR_vector)
    % Calculate the GWN for a specific SNR value
    noise = sigma(i) * randn(1, N * samples_per_symbol);

    % Add the noise
    signal_with_noise = BPSK_signal + noise; % add noise in transmitted channel;



    % Use CORRELATION RECEIVER to detect symbols

    % Slice recieved signal into segments in each column
    sliced_signal_with_noise = reshape(signal_with_noise, samples_per_symbol, N);

    % Detect the signal with the BPSK threshold
    detected_signal = carrier_signal * sliced_signal_with_noise < 0;

    
    errors_number_no_hamming = sum(detected_signal ~= hamming_encoded_sequence);

    % Calculate BER value
    BER_no_hamming(i) = errors_number_no_hamming / N;
    

    % Hamming decoding
    decoded_data_sequence = hamming_decoding(detected_signal, codeword_length, k, generation_polynomial); 

    % Check number of erros
    errors_number_with_hamming = sum (decoded_data_sequence ~= binary_sequence);

    % Calculate BER value
    BER_with_hamming(i) = errors_number_with_hamming/M;

    % Displays resulst
    if DEBUG
        fprintf("SNR value: %f\n", SNR_vector(i));
        fprintf("   BER without coduing: %f\n", BER_no_hamming(i));
        fprintf("   BER with coduing:    %f\n", BER_with_hamming(i));
        fprintf("\n");
    end

end

% Calculate Theoretical BER
x = sqrt(EbN0 * 2);
error_propability = 1 - 1/2 * (1 + erf(x / sqrt(2)));



if RESULT && PLOTS
    % creates figure and settings
    f = figure(1);
    f.Name = 'Analysis of BER curve';
    f.NumberTitle = 'off';
    f.Position = [450, 100, 700, 600];
    
    % Draw plot without Hamming code
    semilogy(SNR_vector, BER_no_hamming, "b"), grid on;

    % Draw plot with Hamming code
    hold on, semilogy(SNR_vector, BER_with_hamming, "r"), hold off;

    % Draw theoretical plot
    hold on, semilogy(SNR_vector, error_propability, 'm'), hold off;

    % Draw SNR project value
    hold on, plot([SNR SNR], [1e-4, 1e-1], 'g--'), hold off;

    
    xlabel("Signal-to-Noise Ratio, [dB]"), ylabel("Bit Error Rate"); % lables
    ylim([1e-4, 1e-1]), xlim([0, 10]); % limits
    legend('Uncoded', 'Coded', 'Theoretical', 'Given SNR value'); % legend
end




















