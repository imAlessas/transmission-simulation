clc, clearvars, clear, format compact

import utils.*

% RESULT will display the values asked in the guidelines
% DEBUG will display also other variables or comparisons
% 0 = OFF, 1 = ON
RESULT = 1; 
DEBUG = 0;


% - - - - - Initial constant parameters - - - -
PROBABILITY_VECTOR = [11, 7, 9, 1, 6, 6, 13, 14, 13, 5, 11, 4]/100; % source number 7
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






% - - - - - - - - - - Task 2 - - - - - - - - - -
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(2);

P = sort(PROBABILITY_VECTOR, 'descend'); % probability vector sorted from highst to lowest
show(RESULT, P', 'p');
show(DEBUG, sum(P), 'sum(p)');


% Values obtained with Shannon-Fano code algorithm
m = [3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5]; 
m_0 = [0, 1, 1, 2, 1, 2, 3, 2, 3, 3, 4, 5];
m_1 = [3, 2, 2, 1, 2, 2, 1, 2, 1, 1, 1, 0];
show(DEBUG, m == (m_0 + m_1), 'm == (m_0 + m_1)');

% sum(a .* b) = a * b' = dot(a,b)
H = - dot(P, log2(P)); % source entropy
show(RESULT, H);

N  = length(P); % symbols on the alphabet
show(DEBUG, N);

H_max = log2(N); % max source entropy
show(RESULT, H_max);

source_redoundancy = 1 - H/H_max; % coefficient 'rho'
show(RESULT, source_redoundancy);





% - - - - - - - - - - Task 3 - - - - - - - - - -
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(3);

% Averages
m_average = dot(P, m); % avarage codeword length
show(RESULT, m_average);

m_0_average = dot(P, m_0); % avarage number of 0 symbols
show(DEBUG, m_0_average);

m_1_average = dot(P, m_1); % average number of 1 symbols
show(DEBUG, m_1_average);

% Probabilities
P_0 = m_0_average / m_average; % probability of 0 symbol
show(RESULT, P_0);

P_1 = m_1_average / m_average; % probability of 1 symbol
show(RESULT, P_1);

show(DEBUG, P_0 + P_1, 'P_0 + P_1');

% Binary entropy
H_bin = - P_0 * log2(P_0) - P_1 * log2(P_1); % binary source entropy after coding
show(RESULT, H_bin);

R = H * (m_average * TAU) ^ (-1); % data rate
show(RESULT, R);

K = m_average / H; % compression ratio
show(RESULT, K);



% - - - - - - - - - - Task 4 - - - - - - - - - -
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(4);

C = 1 / TAU; % noiseless channel capacity
show(DEBUG, C);
show(RESULT, R < C, 'R < C');

Eb_N0 = 10^(SNR / 10);
show(DEBUG, Eb_N0);

% define the phi function
phi = @(x) 1/2 * ( 1 + erf(x / sqrt(2)) );

P_err = 1 - phi( sqrt( 2 * Eb_N0) ); % error probability
show(DEBUG, P_err);

P_err_comp = 1 - P_err; % no error probability
show(DEBUG, P_err_comp);

C_chan = ( 1 + P_err * log2(P_err) + P_err_comp * log2(P_err_comp) ) * C;
show(RESULT, C_chan);

% if R < C_chan = 1, Shannon theorem is verified. The data rate is lower
% than the channel capacity with noise: this means that it is possible to
% find a coding approach that will recover the errors. If the SNR would've
% been lower (like 5) the shannon theorem was not verified
show(RESULT, R < C_chan, 'R < C_chan'); 





% - - - - - - - - - - Task 5 - - - - - - - - - -


% - - - - - - - - - - Task 6 - - - - - - - - - -


% - - - - - - - - - - Task 7 - - - - - - - - - -
% YT: https://www.youtube.com/watch?v=Nq28LAZDURI

task(7);

omega_0 = 2 * pi * F_0; % anguolar carrier frequency
show(DEBUG, omega_0);

OMEGA = pi / TAU; % base harmonic angoular frequency 
show(DEBUG, OMEGA);

k_0 = omega_0 / OMEGA; % Carrier frequency central index
show(DEBUG, k_0);

% Define range of indexes for spectrum
k = k_0 + (-10 : 10);


% Phase value of the spectral function
phase = (k * OMEGA - omega_0) * TAU / 2;

C_BASK = sinc(phase / pi) * U / 4 * 1j; % fourirer series coefficient, BASK

% BPSK spectrum for periodocal '1' and '0' sequence (...1 0 1 0 1 0 1 0 1 0...)
C_BPSK = C_BASK .* ( exp(1j * k * OMEGA * TAU / 2) -  exp(- 1j * k * OMEGA * TAU / 2));

% creates figure and settings
f = figure(1);
f.Name = 'Task 7';
f.NumberTitle = 'off';
f.Position = [450, 100, 700, 600];

% plot 1st result
subplot(2, 1, 1), stem( k * OMEGA / (2 * pi), abs(C_BPSK), 'r' ), grid on,
xlabel('Frequency [GHz]'), ylabel('Amplitude, [V]'), title('Amplitude Spectrum of periodic signal')
ylim([-0.05, 0.35]);


% Power Spectral Density (PSD) for random input signal
omega = ( k(1) : 1/100 : k(end) ) * OMEGA; % angoular frequency 

phase = (omega - omega_0 ) * TAU / 2; % continuous phase 2

S_BASK =  2 * TAU * sinc(phase / pi ) * U / 4 * 1j;


% PSD as a normalized squarred spectral function
G_BPSK = 1/ TAU * abs(S_BASK) .^2;

subplot(2, 1, 2), plot( omega / (2 * pi), G_BPSK, 'r' ), grid on,
xlabel('Frequency [GHz]'), ylabel('PSD'), title('PSD of random signal')
ylim([-0.1e-8, 1.6e-8]);





% - - - - - - - - - - Task 8 - - - - - - - - - -
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(8);

% probability of the case when it is not possible to correct errors with
% the Hamming code (>2 errors)
P_uncur = 1 - (P_err_comp)^(CODEWORD_LENGTH) - CODEWORD_LENGTH * P_err * (P_err_comp)^(CODEWORD_LENGTH - 1);
show(RESULT, P_uncur);




