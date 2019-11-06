function b = unequal(var1, var2)
    // Unequality operator.
    //
    // Syntax
    //   b = unequal(var1, var2)
    //
    // Parameters
    // b: boolean, true if both operands are unequal, false otherwise
    // var1: any*, the first operand
    // var2: any*, the second operand
    //
    // Description
    // The importance of doing 'unequal(x, y)' instead of 'x ~= y' is that the 'unequal' function takes into consideration numerical errors due to the floating point precision.
    //
    // *: If %fastmode is enabled, this function only works with complex numbers, quaternions, vectors, matrices and hypermatrices.
    //
    // Examples
    // sqrt(2)^2 ~= 2 // true
    // unequal(sqrt(2)^2, 2) // false
    //
    // See also
    //  equal
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if %fastmode then
        b = norm(var1 - var2) > %epsilon
    else
        type1 = get_type(var1)
        type2 = get_type(var2)

        if (type1.data(1) == %real.data(1) || type1 == %quat) && (type2.data(1) == %real.data(1) || type2 == %quat) then
            b = norm(var1 - var2) > %epsilon
        else
            b = var1 ~= var2
        end
    end
endfunction
