function b = equal(var1, var2)
    // Equality operator.
    //
    // Syntax
    //   b = equal(var1, var2)
    //
    // Parameters
    // b: boolean, true if both operands are equal, false otherwise
    // var1: any*, the first operand
    // var2: any*, the second operand
    //
    // Description
    // The importance of doing 'equal(x, y)' instead of 'x == y' is that the 'equal' function takes into consideration numerical errors due to the floating point precision.
    //
    // *: If %fastmode is enabled, this function only works with complex numbers, quaternions, vectors, matrices and hypermatrices.
    //
    // Examples
    // sqrt(2)^2 == 2 // false
    // equal(sqrt(2)^2, 2) // true
    //
    // See also
    //  unequal
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if %fastmode then
        b = norm(var1 - var2) <= %epsilon
    else
        type1 = get_type(var1)
        type2 = get_type(var2)

        if (type1.data(1) == %real.data(1) || type1 == %quat) && (type2.data(1) == %real.data(1) || type2 == %quat) then
            b = norm(var1 - var2) <= %epsilon
        else
            b = var1 == var2
        end
    end
endfunction
