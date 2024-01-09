function show(show, var, str)
% SHOW displays the specified variable along with an optional string, depending on the 'show' flag.
%
% INPUT:
%   show:   a logical flag indicating whether to display the variable (true) or not (false).
%   var:    the variable to be displayed.
%   str:    an optional string to be displayed along with the variable (default is an empty string).
%
% USAGE:
%   show(true, myVar) - Display the variable with its name.
%   show(true, myVar, 'Optional message') - Display the variable with an optional message.

    arguments
        show;            % A logical flag indicating whether to display the variable.
        var;             % The variable to be displayed.
        str string = ""; % An optional string to be displayed along with the variable (default is an empty string).
    end

    % Check if 'show' is true and 'str' is an empty string
    if(show && str == "")
        % Display the variable name, value, and a newline
        disp(inputname(2)), disp(var), disp(newline);
    elseif(show)
        % Display the specified string, variable value, and a newline
        disp(str), disp(var), disp(newline);
    end
end

