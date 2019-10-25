function out = alias(func, args)
    // Function alias.
    //
    // Syntax
    //   varargout = alias(func, varargin)
    //
    // Parameters
    // varargout: list, the list of outputs
    // func: function, the original function
    // varargin: list, the list of inputs
    //
    // Description
    // This function passes the input arguments of an alias to the original function. It also returns the outputs of the original function to its alias.
    //
    // Examples
    // function q = quaternion(varargin)
    //     q = alias(quat, varargin)
    // endfunction
    //
    // See also
    //  quaternion
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    n = length(args)

    if n == 0 then
        out = func()
    else
        if SCITERNIONS_FASTMODE then
            select n
            case 1 then
                out = func(args(1))
            case 2 then
                out = func(args(1), args(2))
            case 3 then
                out = func(args(1), args(2), args(3))
            case 4 then
                out = func(args(1), args(2), args(3), args(4))
            case 5 then
                out = func(args(1), args(2), args(3), args(4), args(5))
            end
        else
            str = "out = func("
            for i = 1:length(args) do
                str = str + "args(" + string(i) + "),"
            end
            str = part(str, 1:$-1) + ")"
    
            execstr(str)
        end
    end
endfunction
