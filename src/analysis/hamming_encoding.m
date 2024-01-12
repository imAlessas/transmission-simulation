function [encoded_data, CntSym] = hamming_encoding(binDt, m, k)
% The function calculates Hamming group (m,k) encoder output in matrix form 
% for multiple data blocks.
% Input:
%   binDt - a matrix with k rows, each row represents a single data block to be coded;
%   m     - Hamming codeword length;
%   k     - number of information symbols per codeword;
% Output:
%   encDt - a matrix with m rows, each row represents a Hamming group codeword.

% First, determine the number of control symbols  
r = m - k;

% Encoding matrix - derrived from coding equations.
% Each column represents one equation (non-systematic code).
EncMtx = ...


% Calculate control symbol values 
% Use rem() function to find modulo 2 sum as a remainder of division by 2
encoded_data = rem(binDt * EncMtx,2);   % Use matrix multiplication to improve performance