function q = rquatd(t, n)
    // Creates a rotation quaternion.
    //
    // Syntax
    //   q = rquatd(degrees, axis)
    //
    // Parameters
    // q: quaternion, the rotation quaternion to be created
    // degrees: real, the angle of rotation in degrees
    // axis: unit vector, the axis of rotation
    //
    // Description
    // Generates a quaternion that represents a rotation in 3D space. A rotation is defined clockwise and is represented by an axis and an angle.
    //
    // Examples
    // r = rquatd(90, %X)
    // y = rotateq(%Z, r) // y is [0; 1; 0], which is the z axis rotated by the x axis 90 degrees clockwise
    //
    // See also
    //  rotation_quaternion_degrees
    //  quat
    //  rquat
    //  qrotate
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        check_args("rquatd(degrees, axis)", t, %real, n, %vector)

        if size(n, 2) ~= 1 then
            warning("rquatd(degrees, axis): Transposing the axis, which should not be a row vector.")
            n = n'
        end

        if size(n, 1) ~= 3 then
            error("rquatd(degrees, axis): Argument checking failed for argument 2. The axis must have 3 components.")
        elseif get_type(n(1)) ~= %real || get_type(n(2)) ~= %real || get_type(n(3)) ~= %real then
            error("rquatd(degrees, axis): Argument checking failed for argument 2. The axis must have real components.")
        elseif unequal(norm(n), 1) then
            warning("rquatd(degrees, axis): Normalizing the axis, which should be a unit vector.")
            n = n / norm(n)
        end
    end

    a = 0.5 * t
    q = tlist(["quat", "real", "imag"], cosd(a), sind(a) * n)
endfunction
