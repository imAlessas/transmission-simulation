% Analysis of Cyclic Hamming Encoding (Task 6)



% photo in gallery, date: 11/12/23

SNR_vector = 0 : 1/2 : 15;

% error correcting code parameters
r = ceil(log2(codeword_length + 1));
k = codeword_length - r;

% Generation of binary data
N = 1e4; % number of bits to be sent
N = floor(N/k)*k; % match information block size
binary_sequence = randi(2, 1, N) - 1; 


% Generate carrier signal
delta_t = tau / samples_per_symbol; % time step
t = 0: delta_t: tau - delta_t; % time interval for one symbol
s0 = sin(2 * pi * f0 * t); % Carrier signal
Eb = dot(s0, s0); % sum(s0.^2) // energy per symbol
SNR = 8.1; % SNR in course project


% Hamming encoding
binary_data = reshape(binary_sequence, k, N / k)'; % Matrix of information blocks to be coded
encoded_data = encHamming(binary_data, codeword_length, k); % encode data
encoded_data = encoded_data';
encoded_data = encoded_data(:)'; % unwrap data into signle row
M = N;
N = length(encoded_data); % update number of bits

% Generate noise power
EbN0 = 10.^(SNR_vector / 10); % Linear SNR
N0 = Eb./EbN0; % noise spectral power density
sigma = sqrt(N0 / 2);

for i = length(SNR_vector)
    noise = sigma(i) * randn(1, N * samples_per_symbol); % noise in AWGN channel
    signal_with_noise = sTx + noise; % add noise in transmitted channel;

    % correltaion reciever
    sliced_signal_with_noise = reshape(signal_with_noise, samples_per_symbol, N); % slice recieved signal into segments in each column
    demDt = s0 * sliced_signal_with_noise < 0;

    % Check number of erros and estimate probability
    NumErr = sum(demDt ~= encoded_data);
    BERval(i) = NumErr / N;
    
    % Hamming decoding
    codeword = reshape(demDt, codeword_length, N/codeword_length)'; % codeword to be decoded
    decoded_data = hamming_decoding(binary_data, codeword_length, k, generation_polynomial); % encode data
    decoded_data = decoded_data';
    decoded_data = decoded_data(:)'; % unwrap dato into signle row
    NumErr1 = sum (decoded_data ~= binary_sequence);
    BERval1(i) = NumErr1/M;
    fprintf('BPSK : SNR %f, Uncoded BER: %f, Coded BER: %f\n', SNR_vector(i), BERval(i), BERval1(i));
end

EbN3 = 10.^(SNRval / 10); % Linear SNR
x = sqrt(EbN3 * 2);
Perr = 1 - 1/2 * (1 + erf(x / sqrt(2)));

semilogy(SNR_vector, BERval, "b"), grid on, xlabel("SNR, dB"), ylabel("BER"), hold on;
semilogy(SNR_vector, BERval1, "r"), grid on, xlabel("SNR, dB"), ylabel("BER"), hold off;




















