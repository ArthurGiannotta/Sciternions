function c = %type_string(ty)
    // Type stringification.
    //
    // Syntax
    //   c = %type_string(ty)
    //
    // Examples
    // string(get_type(1))
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    c = "[" + string(ty.data(1)) + " " + string(ty.data(2)) + "]"
endfunction
