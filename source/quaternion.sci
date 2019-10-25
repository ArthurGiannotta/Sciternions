function q = quaternion(varargin)
    // Creates a quaternion.
    //
    // Syntax
    //   q = quaternion(a, b, c, d)
    //   q = quaternion(a, v)
    //   q = quaternion(abcd)
    //   q = quaternion(q0)
    //   q = quaternion()
    //
    // Parameters
    // q: quaternion, quaternion to be created
    // a: real, real part
    // b: real, first imaginary part
    // c: real, second imaginary part
    // d: real, third imaginary part
    // v: vector, imaginary part
    // abcd: vector, real and imaginary parts
    // q0: quaternion, quaternion to copy
    //
    // Description
    // Generates an object of the quaternion class. This is an alias for the function 'quat'.
    //
    // See also
    //  quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    q = alias(quat, varargin)
endfunction
