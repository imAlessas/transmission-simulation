function compact_sequence = remove_padding_bits(padded_sequence)
% REMOVE_PADDING_BITS removes padding bits from the end of a padded sequence.
%
% INPUT:
%   padded_sequence:    A vector representing the sequence with padding bits.
%
% OUTPUT:
%   compact_sequence:   A vector representing the sequence with padding bits removed.

    % Call the get_padding_bits function to determine the number of padding bits
    padding = get_padding_bits(padded_sequence);

    % Remove the padding bits from the end of the sequence
    compact_sequence = padded_sequence(1 : end - padding);
end


function padding_bits = get_padding_bits(padded_sequence)
% GET_PADDING_BITS extracts the binary representation of the padding bits from the end of a sequence.
%
% INPUT:
%   padded_sequence:    A vector representing the sequence with padding bits.
%
% OUTPUT:
%   padding_bits:       The decimal value representing the extracted padding bits.

    % Extract the last 5 bits from the padded sequence
    bits = padded_sequence(end-4 : end);
    
    % Convert the binary representation of the bits to a string
    str = '';
    for i = 1 : length(bits)
        str = append(str, num2str(bits(i)));
    end
    
    % Convert the binary string to decimal to obtain the number of padding bits
    padding_bits = bin2dec(str);
end
