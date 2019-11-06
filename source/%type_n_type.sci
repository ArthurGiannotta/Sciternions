function b = %type_n_type(type1, type2)
    // Inequality operator between types.
    //
    // Syntax
    //   b = %type_n_type(type1, type2)
    //
    // Examples
    // get_type(0) ~= get_type([0, 0]) // true
    // get_type(0) ~= get_type(%pi) // false
    //
    // See also
    //  %type_o_type
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    b = or(type1.data ~= type2.data)
endfunction
