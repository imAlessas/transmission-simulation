function padded_sequence = add_padding_bits(compact_sequence)
% ADD_PADDING_BITS adds padding bits to the end of a compact sequence to meet interleaving requirements.
%
% INPUT:
%   compact_sequence:          A vector representing the compact sequence.
%
% OUTPUT:
%   padded_sequence:           A vector representing the sequence with added padding bits.

    % Determine the number of bits needed for padding
    bits_to_pad = count_padding_bits(compact_sequence);

    % Convert the number of bits to pad to binary representation
    binary_padding_value = str2num(dec2bin(bits_to_pad, 5)')';

    % Add padding bits to the end of the sequence
    padded_sequence = [compact_sequence, zeros(1, bits_to_pad - 5), binary_padding_value];
end




function number_of_padding_bits = count_padding_bits(compact_sequence)
% COUNT_PADDING_BITS calculates the number of padding bits needed for interleaving.
%
% INPUT:
%   compact_sequence:          A vector representing the compact sequence.
%
% OUTPUT:
%   number_of_padding_bits:    The number of padding bits needed.

    % Define the number of bits reserved for storing the padding information
    storage_bits = 5;

    % Define the divisor used in determining the number of padding bits
    divisor = 26;

    % Calculate the number of padding bits required
    number_of_padding_bits = divisor - rem(length(compact_sequence), divisor);

    % Adjust the number of padding bits if it is less than the storage_bits
    if number_of_padding_bits < storage_bits
        number_of_padding_bits = number_of_padding_bits + divisor;
    end
end
