function q = rotation_quaternion_degrees(varargin)
    // Creates a rotation quaternion.
    //
    // Syntax
    //   q = rotation_quaternion_degrees(degrees, axis)
    //
    // Parameters
    // q: quaternion, the rotation quaternion to be created
    // degrees: real, the angle of rotation in degrees
    // axis: unit vector, the axis of rotation
    //
    // Description
    // This is an alias for the function 'rquatd'. Go see its documentation for full details.
    //
    // See also
    //  rquatd
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    q = alias(rquatd, varargin)
endfunction
