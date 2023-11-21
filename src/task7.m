%%  Task 7 - BASK

clc, clearvars, clear

% Calculate the plot of the modutlated signal spectrums
% Specific the individual parameters

TAU = 60e-9; % symbol duration
F_0 = 2.5e+9; % carrier frequency
U = 1; % amplitude of the carrier
mF = 0;
OMEGA_0 = 2 * pi * F_0; % angolar carrier frequency
OMEGA = pi / TAU; % base harminc angoular frequency 
K_0 = OMEGA_0 / OMEGA; % Carrier Frequency
k = K_0 * (-10 : 10); % Frequency indec range
SNR = 8.1; %



% First spectrum of periodic signal (10101010 ...)
PHI = (k * OMEGA - OMEGA_0) * TAU / 2;
C_BASK = sinc(PHI / pi) * U / 4 * 1j;

subplot(2, 1, 1), stem( k * OMEGA / (2 * pi), abs(C_BASK), 'r' ), grid on,
xlabel('Frequency [Hz]'), ylabel('Amplitude, [V]'), title('Amplitude Spctrum of periodic signal')


% Spectrum of the BSD
W = ( k(1) : 0.01 : k(end) ) * OMEGA; % angoular frequency
phi2 = (OMEGA - OMEGA_0 ) * TAU / 2; % argument of sinc function
S_BASK =  2 * TAU * sinc(phi2 / pi ) * U / 4 * 1j;
G_BASK = 1/( 2 * TAU) * abs(S_BASK) .^2;

subplot(2, 1, 2), plot( OMEGA / (2 * 1j), G_BASK, 'r' ), grid on,
xlabel('Frequency [Hz]'), ylabel('PSD'), title('Power Spctrum Density of random signal')


%% Task 7 - BFSK

TAU = 60e-9; % symbol duration
F_0 = 2.5e+9; % carrier frequency
U = 1; % amplitude of the carrier
mF = 0;
OMEGA_0 = 2 * pi * F_0; % angolar carrier frequency
OMEGA = pi / TAU; % base harminc angoular frequency 
dF = mF * OMEGA;
w1 = OMEGA_0 - dF/2;
w2 = OMEGA_0 + dF/2;
K_0 = OMEGA_0 / OMEGA; % Carrier Frequency
k = K_0 * (-10 : 10); % Frequency indec range
SNR = 8.1; %

% HAMZA has it



%% TASK 7 - BPSK

clc, clearvars, clear

TAU = 60e-9; % symbol duration [s]
F_0 = 2.5e+9; % carrier frequency [Hz]
U = 1; % amplitude of the carrier [V]
OMEGA_0 = 2 * pi * F_0; % angolar carrier frequency
OMEGA = pi / TAU; % base harminc angoular frequency 
K_0 = OMEGA_0 / OMEGA; % Carrier Frequency
k = K_0 + (-10 : 10); % Frequency indec range



% First spectrum of periodic signal (10101010 ...)
PHI = (k * OMEGA - OMEGA_0) * TAU / 2;
C_BASK1 = sinc(PHI / pi) * U / 4 * 1j; % fourirer series coefficient
C_BASK2 = C_BASK1; % fourirer series coefficient
C_BPSK = C_BASK1.*exp(1j * k * OMEGA * TAU / 2) - C_BASK2.*exp(-1j * k * OMEGA * TAU / 2);


subplot(2, 1, 1), stem( k * OMEGA / (2 * pi), abs(C_BPSK), 'r' ), grid on,
xlabel('Frequency [Hz]'), ylabel('Amplitude, [V]'), title('Amplitude Spctrum of periodic signal')


% Spectrum of the PSD
W = ( k(1) : 0.01 : k(end) ) * OMEGA; % angoular frequency
PHI = (W - OMEGA_0 ) * TAU / 2; % argument of sinc function
S_BASK1 =  2 * TAU * sinc(PHI / pi ) * U / 4 * 1j;
S_BASK2 = S_BASK1;

G_BASK1 = 1/( 2 * TAU) * abs(S_BASK1) .^2;
G_BASK2 = 1/( 2 * TAU) * abs(S_BASK2) .^2;

G_BPSK = G_BASK1 + G_BASK1; 

subplot(2, 1, 2), plot( W / (2 * pi), G_BPSK, 'r' ), grid on,
xlabel('Frequency [Hz]'), ylabel('PSD'), title('Power Spctrum Density of random signal')
