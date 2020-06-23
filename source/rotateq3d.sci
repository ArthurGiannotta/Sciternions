function r = rotateq3d(x, q)
    // Three-dimensional rotation using quaternion.
    //
    // Syntax
    //   result = rotateq3d(x, q)
    //
    // Parameters
    // result: vector, the rotated 3D vector
    // x: vector, the 3D vector to rotate
    // q: quaternion, the rotation quaternion
    //
    // Description
    // The rotation of a three-dimensional vector 'x' using a rotation quaternion 'q' is defined to be a function given by the imaginary part of the following quaternion product:
    //
    // <latex>$\overrightarrow{Rot}(\vec{x}, q) \triangleq \overrightarrow{Im}(\bar{q} \circ (0, \vec{x}) \circ q)$</latex>
    //
    // To rotate two-dimensional vectors, use 'rotateq2d' instead. To get the result in its quaternion form, use 'rotateq'. To get the result in its reduced form, use 'rotate_using_quaternion'.
    //
    // Examples
    // x_axis = [1; 0; 0]; y_axis = [0; 1; 0]; z_axis = [0; 0; 1]
    // y = rotateq3d(x_axis, rquatd(-90, z_axis)) // The negative sign means counterclockwise
    // if equal(y, y_axis) then
    //     display("It worked!!! Rotating the x axis 90 degrees counterclockwise around the z axis gives the y axis.")
    // end
    //
    // See also
    //  rotate_using_quaternion
    //  rotateq
    //  rotateq2d
    //  rquat
    //  rquatd
    //  %quat_m_quat
    //  %quat_5
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        check_args("rotateq3d(x, q)", x, %vector, q, %quat)

        if length(x) ~= 3 then
            error("rotateq3d(x, q): Argument checking failed for argument 1. Cannot three-dimensionally rotate a vector that is not three-dimensional.")
        elseif unequal(norm(q), 1) then
            warning("rotateq3d(x, q): Performing dubious rotation. The quaternion should be a unit quaternion.")
        end
    end

    r = (~q * x * q).imag
endfunction
