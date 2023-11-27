function show(show, var, str)
% this functions it is used to help to debug the MATLAB code. When the
% variable DEBUG = 1 the variable or the operation will be displayed on the
% Command Window.
    arguments
            show;
            var;
            str string = "";
    end

    if(show && str == "")
        disp(inputname(2)), disp(var), disp(newline);
    elseif(show)
        disp(str), disp(var), disp(newline);
    end
end
