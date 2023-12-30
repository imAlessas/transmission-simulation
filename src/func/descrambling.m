function unscrambled_sequence = descrambling(scrambled_sequence, scrambler_key)
% DESCRAMBLING performs descrambling by applying the scrambling function in reverse.
% Note: XOR is a cyclic operation, and applying it twice with the same key results in the original sequence.
%
% INPUT:
%   scrambled_sequence:     the input scrambled sequence to be descrambled.
%   scrambler_key:          the same scrambler key used for the scrambling operation.
%
% OUTPUT:
%   unscrambled_sequence:   the resulting descrambled sequence.

    % Utilize the scrambling function in reverse to perform descrambling
    unscrambled_sequence = scrambling(scrambled_sequence, scrambler_key);
end
