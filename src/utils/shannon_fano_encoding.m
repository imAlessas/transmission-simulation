function result = shannon_fano_encoding(symbol_sequence)
% SHANNON_FANO_ENCODING performs Shannon-Fano encoding on a given symbol sequence.
%
% INPUT:
%   symbol_sequence:    a vector representing a sequence of symbols to be encoded.
%
% OUTPUT:
%   result:             a vector containing the Shannon-Fano encoded sequence.

    result = [];
    
    % Iterate through the symbol sequence and encode each symbol
    for i = 1:length(symbol_sequence)
        result = [result, get_encoded_symbol(symbol_sequence(i))];
    end
end




function result = get_encoded_symbol(symbol)
% GET_ENCODED_SYMBOL returns the Shannon-Fano encoded representation for a given symbol.
%
% INPUT:
%   symbol:     an integer representing the input symbol to be encoded.
%
% OUTPUT:
%   result:     a vector containing the Shannon-Fano encoded representation of the input symbol.

    % Use a switch statement to assign the encoded representation based on the input symbol
    switch symbol
        case 1
            result = [1 0 0];
        case 2
            result = [ 0 1 0 0 ];
        case 3 
            result = [ 0 1 0 1 ];
        case 4 
            result = [ 0 0 0 0 0 ];
        case 5 
            result = [ 0 0 1 1 ];
        case 6 
            result = [ 0 0 1 0 ];
        case 7 
            result = [ 1 1 0 ];
        case 8 
            result = [ 1 1 1 ];
        case 9 
            result = [ 1 0 1 ];
        case 10 
            result = [ 0 0 0 1 ];
        case 11 
            result = [ 0 1 1 ];
        case 12
            result = [ 0 0 0 0 1 ];
    end
end