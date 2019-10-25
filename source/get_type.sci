function ty = get_type(variable)
    // Gets the type of a variable.
    //
    // Syntax
    //   ty = get_type(variable)
    //
    // Description
    // This function returns an object representing a type. It should be used instead of 'type'.
    //
    // Examples
    // ty1 = get_type(1)
    // ty2 = get_type([0, 0])
    // ty3 = get_type([0; 0; 0])
    // ty1 == ty2 // false
    // ty2 == ty3 // true
    //
    // See also
    //  type
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    [ty(1), ty(2)] = type(variable)
    ty = tlist(["type", "data"], ty)
endfunction
