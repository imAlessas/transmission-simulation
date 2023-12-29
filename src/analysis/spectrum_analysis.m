% Analysis of BPSK spectrum
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


if RESULT && PLOTS
    % creates figure and settings
    f = figure(1);
    f.Name = 'Task 7';
    f.NumberTitle = 'off';
    f.Position = [450, 100, 700, 600];
    
    % plot 1st result
    subplot(2, 1, 1), stem( k * OMEGA / (2 * pi), abs(C_BPSK), 'b' ), grid on,
    xlabel('Frequency [GHz]'), ylabel('Amplitude, [V]'), title('Amplitude Spectrum of periodic signal')
    ylim([-0.05, 0.35]);
end