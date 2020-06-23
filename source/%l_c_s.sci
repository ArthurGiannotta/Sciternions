function l = %l_c_s(lst, s)
    // List-complex vector creation (line).
    //
    // Syntax
    //   l = %l_c_s(lst, s)
    //
    // Examples
    // l = ["string", 0, 1, 2]
    //
    // See also
    //  %s_c_l
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    l = lst
    l($+1) = s
endfunction
