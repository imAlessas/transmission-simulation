function padded_sequence = add_padding_bits(compact_sequence, k, r)
% ADD_PADDING_BITS Adds padding bits to the end of a compact sequence to meet interleaving requirements.
%
% INPUT:
%   compact_sequence: A vector representing the compact sequence.
%   k:                An integer representing the divisor used in determining the number of padding bits.
%   r:                An integer representing the number of bits reserved for storing the padding information.
%
% OUTPUT:
%   padded_sequence:  A vector representing the sequence with added padding bits.

    % Determine the number of bits needed for padding
    bits_to_pad = count_padding_bits(compact_sequence, k, r);

    % Convert the number of bits to pad to binary representation
    binary_padding_value = str2num(dec2bin(bits_to_pad, r)')';

    % Add padding bits to the end of the sequence
    padded_sequence = [compact_sequence, zeros(1, bits_to_pad - r), binary_padding_value];
end




function number_of_padding_bits = count_padding_bits(compact_sequence, k, r)
% COUNT_PADDING_BITS Calculates the number of padding bits needed for interleaving.
%
% INPUT:
%   compact_sequence: A vector representing the compact sequence.
%   k:                An integer representing the divisor used in determining the number of padding bits.
%   r:                An integer representing the number of bits reserved for storing the padding information.
%
% OUTPUT:
%   number_of_padding_bits: The number of padding bits needed.

    % Calculate the number of padding bits required
    number_of_padding_bits = k - rem(length(compact_sequence), k);

    % Adjust the number of padding bits if it is less than the storage_bits
    if number_of_padding_bits < r
        number_of_padding_bits = number_of_padding_bits + k;
    end
end
