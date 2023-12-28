function task(n)
    % TASK displays a header for a specific task identified by the input number.
    %
    % INPUT:
    %   n:    the task number to be displayed in the header.
    %
    % USAGE:
    %   task(1) - Display a header for Task 1.

    % Display two newlines for separation
    disp(newline), disp(newline);

    % Display the header for the specified task number
    disp(" -- -- -- -- -- -- TASK " + n + " -- -- -- -- -- -- ");

    % Display a newline for separation
    disp(newline);
end
