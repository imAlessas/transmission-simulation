function scrambled_sequence = scrambling(unscrambled_sequence, scrambler_key)
% SCRAMBLING performs a simple scrambling operation on a given sequence.
%
% INPUT:
%   unscrambled_sequence:   the input sequence to be scrambled.
%   scrambler_key:          the scrambling key used for the XOR operation.
%
% OUTPUT:
%   scrambled_sequence:     the resulting scrambled sequence.

    % Initialize the output sequence
    scrambled_sequence = [];

    % Determine the length of the scrambler key
    codeword_length = length(scrambler_key);

    % Loop through the input sequence in codeword-sized chunks
    for i = 1 : length(unscrambled_sequence) / codeword_length
        % Extract the current codeword from the input sequence
        current_codeword = unscrambled_sequence(codeword_length * (i - 1) + 1 : codeword_length * i);
        
        % Perform XOR operation with the scrambler key
        scrambled_codeword = xor(current_codeword, scrambler_key);

        % Append the scrambled codeword to the output sequence
        scrambled_sequence = [scrambled_sequence, scrambled_codeword];
    end
end
