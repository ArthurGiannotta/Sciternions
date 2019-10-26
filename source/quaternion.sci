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
    // q: quaternion, the quaternion to be created
    // a: real, the real part
    // b: real, the first imaginary part
    // c: real, the second imaginary part
    // d: real, the third imaginary part
    // v: vector, the imaginary part
    // abcd: vector, the real and imaginary parts
    // q0: quaternion, the quaternion to copy
    //
    // Description
    // This is an alias for the function 'quat'. Go see its documentation for full details.
    //
    // See also
    //  quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    q = alias(quat, varargin)
endfunction
