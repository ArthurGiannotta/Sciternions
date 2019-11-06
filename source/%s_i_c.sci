function l = %s_i_c(varargin)
    // Vector insertion in string.
    //
    // Syntax
    //   l = %s_i_c(varargin)
    //
    // Examples
    // v(2) = 0
    // v(1) = ""
    //
    // function [c, s] = func()
    //     c = "";
    //     s = 0
    // endfunction
    // [l(1), l(2)] = func()
    //
    // See also
    //  %c_i_s
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    c = varargin($)

    // Converts a list of strings into a normal list
    l = list()
    for i = 1:prod(size(c)) do
        l($+1) = c(i)
    end

    l(varargin(1:$-2)) = varargin($-1)
endfunction
