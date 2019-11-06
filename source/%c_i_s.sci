function l = %c_i_s(varargin)
    // String insertion in vector.
    //
    // Syntax
    //   l = %c_i_s(varargin)
    //
    // Examples
    // v(2) = ""
    // v(1) = 0
    //
    // function [s, c] = func()
    //     s = 0
    //     c = "";
    // endfunction
    // [l(1), l(2)] = func()
    //
    // See also
    //  %s_i_c
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    s = varargin($)

    // Converts a vector into a normal list
    l = list()
    for i = 1:length(s) do
        l($+1) = s(i)
    end

    l(varargin(1:$-2)) = varargin($-1)
endfunction
