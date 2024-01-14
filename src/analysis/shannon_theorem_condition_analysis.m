% Analysis of Shannon theorem's condition
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(4);

C = 1 / tau; % noiseless channel capacity
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