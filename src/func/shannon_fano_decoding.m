function decoded_sequence = shannon_fano_decoding(encoded_sequence)
% SHANNON_FANO_DECODING decodes a Shannon-Fano encoded sequence into the original symbol sequence.
%
% INPUT:
%   encoded_sequence:   A vector containing the Shannon-Fano encoded sequence.
%
% OUTPUT:
%   decoded_sequence:   A vector representing the decoded symbol sequence.

    decoded_sequence = [];
    
    % Iterate through the encoded sequence and decode each symbol
    current_code = [];
    for i = 1:length(encoded_sequence)
        current_code = [current_code, encoded_sequence(i)];
        
        % Check if the current code matches any known code
        symbol = decode_symbol(string(mat2str(current_code)));
        
        % If a symbol is found, add it to the decoded sequence and reset the current code
        if ~isempty(symbol)
            decoded_sequence = [decoded_sequence, symbol];
            current_code = [];
        end
    end
end

function symbol = decode_symbol(code)
% DECODE_SYMBOL decodes a given code into the corresponding symbol.
%
% INPUT:
%   code:   A vector representing the encoded code to be decoded.
%
% OUTPUT:
%   symbol: The decoded symbol, or empty if the code does not match any known code.

    % Use a switch statement to check each possible code and return the corresponding symbol
    switch code
        case "[1 0 0]"
            symbol = 1;
        case "[0 1 0 0]"
            symbol = 2;
        case "[0 1 0 1]"
            symbol = 3;
        case "[0 0 0 0 0]"
            symbol = 4;
        case "[0 0 1 1]"
            symbol = 5;
        case "[0 0 1 0]"
            symbol = 6;
        case "[1 1 0]"
            symbol = 7;
        case "[1 1 1]"
            symbol = 8;
        case "[1 0 1]"
            symbol = 9;
        case "[0 0 0 1]"
            symbol = 10;
        case "[0 1 1]"
            symbol = 11;
        case "[0 0 0 0 1]"
            symbol = 12;
        otherwise
            symbol = []; % Return empty if the code does not match any known code
    end
end
