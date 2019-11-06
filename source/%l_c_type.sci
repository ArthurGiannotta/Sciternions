function l = %l_c_type(lst, ty)
    // List-type vector creation (line).
    //
    // Syntax
    //   l = %l_c_type(lst, ty)
    //
    // Examples
    // l = [%real, %complex, %vector]
    //
    // See also
    //  %l_f_type
    //  %type_c_l
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    l = lst
    l($+1) = ty
endfunction
