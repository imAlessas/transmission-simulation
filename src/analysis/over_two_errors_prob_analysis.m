% Analysis of Probability of > 2 errors occurring
% YT: https://www.youtube.com/watch?v=js9iRBYVLqs

task(8);

% probability of the case when it is not possible to correct errors with
% the Hamming code (> 2 errors)
P_uncur = 1 - (P_err_comp)^(CODEWORD_LENGTH) - CODEWORD_LENGTH * P_err * (P_err_comp)^(CODEWORD_LENGTH - 1);
show(RESULT, P_uncur);