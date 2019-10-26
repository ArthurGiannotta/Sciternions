function q = rotation_quaternion(varargin)
    // Creates a rotation quaternion.
    //
    // Syntax
    //   q = rotation_quaternion(radians, axis)
    //
    // Parameters
    // q: quaternion, the rotation quaternion to be created
    // radians: real, the angle of rotation in radians
    // axis: unit vector, the axis of rotation
    //
    // Description
    // This is an alias for the function 'rquat'. Go see its documentation for full details.
    //
    // See also
    //  rquat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    q = alias(rquat, varargin)
endfunction
