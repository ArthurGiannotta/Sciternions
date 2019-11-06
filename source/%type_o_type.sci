function b = %type_o_type(type1, type2)
    // Equality operator between types.
    //
    // Syntax
    //   b = %type_o_type(type1, type2)
    //
    // Examples
    // get_type(%i) == get_type(%pi) // true
    // get_type(0) == get_type([0, 0]) // false
    //
    // See also
    //  %type_n_type
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    b = and(type1.data == type2.data)
endfunction
