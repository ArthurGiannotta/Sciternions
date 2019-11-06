function r = rotate_using_quaternion(varargin)
    // Rotation using quaternion.
    //
    // Syntax
    //   result = rotate_using_quaternion(x, q)
    //
    // Parameters
    // result: complex|vector|quaternion, the rotated object in its reduced form
    // x: complex|vector|quaternion, the object to rotate
    // q: quaternion, the rotation quaternion
    //
    // Description
    // This is an alias for the function 'rotateq'. Go see its documentation for full details. The only difference is that 'rotate_using_quaternion' automatically reduces the result. Take a look at the documentation of the function 'reduce' for an explanation.
    //
    // See also
    //  rotateq
    //  reduce
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    r = reduce(alias(rotateq, varargin))
endfunction
