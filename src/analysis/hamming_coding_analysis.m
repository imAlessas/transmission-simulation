clc, clear, format compact

% ------- TASK 6 ---------------

% photo in gallery, date: 11/12/23

Ts = 60e-9; % symbol duration time
f0 = 2.5e9; % carrier frequency
SNR = 0 : 1/2 : 15;

% error correcting code parameters
m = 31;
r = ceil(log2(m + 1));
k = m - r;

% Generation of binary data
N = 1e4; % number of bits to be sent
N = floor(N/k)*k; % match information block size
sB = randi(2, 1, N) - 1; 


% Generate carrier signal
L = 500; % samples per symbol
dT = Ts / L; % time step
t = 0: dT: Ts - dT; % time interval for one symbol
s0 = sin(2 * pi * f0 * t); % Carrier signal
Eb = dot(s0, s0); % sum(s0.^2) // energy per symbol
SNRVal = 8.1; % SNR in course project


% Hamming encoding
binDt = reshape(sB, k, N / k)'; % Matrix of information blocks to be coded
encDt = encHamming(binDt, m, k); % encode data
encDt = encDt';
encdDt = encDt(:)'; % unwrap dato into signle row
M = N;
N = length(encDt): % update number of bits

% Generate noise power
EbN0 = 10.^(SNR / 10); % Linear SNR
N0 = Eb./EbN0; % noise spectral power density
sigma = sqrt(N0 / 2);

for i = length(SNR)
    sNoise = sigma(i) * randn(1, N * L); % noise in AWGN channel
    sRx = sTx + sNoise; % add noise in transmitted channel;

    % correltaion reciever
    sRxMtx = reshape(sRx, L, N); % slice recieved signal into segments in each column
    demDt = s0 * sRxMtx < 0;

    % Check number of erros and estimate probability
    NumErr = sum(demDt ~= encdDt);
    BERval(i) = NumErr / N;
    
    % Hamming decoding
    cdWrd = reshape(demDt, m, N/m)'; % codeword to be decode
    decDt = decHamming(binDt, m, k); % encode data
    decDt = decDt';
    decDt = decDt(:)'; % unwrap dato into signle row
    NumErr1 = sum (decDt ~= sB);
    BERval1(i) = NumErr1/M;
    fprintf('BPSK : SNR %f, Uncoded BER: %f, Coded BER: %f\n', SNR(i), BERval(i), BERval1(i));
end

EbN3 = 10.^(SNRval / 10); % Linear SNR
x = sqrt(EbN3 * 2);
Perr = 1 - 1/2 * (1 + erf(x / sqrt(2)));

semilogy(SNR, BERval, "b"), grid on, xlabel("SNR, dB"), ylabel("BER"), hold on;
semilogy(SNR, BERval1, "r"), grid on, xlabel("SNR, dB"), ylabel("BER"), hold off;




















