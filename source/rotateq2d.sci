function r = rotateq2d(x, q)
    // Two-dimensional rotation using quaternion.
    //
    // Syntax
    //   result = rotateq2d(x, q)
    //
    // Parameters
    // result: vector, the rotated 2D vector
    // x: vector, the 2D vector to rotate
    // q: quaternion, the rotation quaternion
    //
    // Description
    // The rotation of a two-dimensional vector 'x' using a rotation quaternion 'q' is defined to be a function given by the first two imaginary parts of the following quaternion product:
    //
    // <latex>$\overrightarrow{Rot}_(\vec{x}, q) = \overrightarrow{Rot}([a, b], q) \triangleq \overrightarrow{Im}(\bar{q} \circ (0, a, b, 0) \circ q)$</latex>
    //
    // To rotate three-dimensional vectors, use 'rotateq3d' instead. To get the result in its quaternion form, use 'rotateq'. To get the result in its reduced form, use 'rotate_using_quaternion'.
    //
    // Examples
    // x_axis = [1; 0]; y_axis = [0; 1]; z_axis = [0; 0; 1]
    // y = rotateq2d(x_axis, rquatd(-90, z_axis)) // The negative sign means counterclockwise
    // if equal(y, y_axis) then
    //     display("It worked!!! Rotating the x axis 90 degrees counterclockwise around the z axis gives the y axis.")
    // end
    //
    // See also
    //  rotate_using_quaternion
    //  rotateq
    //  rotateq3d
    //  rquat
    //  rquatd
    //  %quat_m_quat
    //  %quat_5
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if %fastmode then
        A = q.real; D = q.imag(3)
        b = x(1); c = x(2)

        r = [(A * A - D * D) * b + 2 * A * D * c; (A * A - D * D) * c - 2 * A * D * b]
    else
        check_args("rotateq2d(x, q)", x, %vector, q, %quat)

        if length(x) ~= 2 then
            error("rotateq2d(x, q): Argument checking failed for argument 1. Cannot two-dimensionally rotate a vector that is not two-dimensional.")
        end

        if unequal(q.imag(1:2), [0; 0]) then
            error("rotateq2d(x, q): Invalid two-dimensional rotation. The rotation quaternion axis can only be [0; 0; 1] or [0; 0; -1] .")
        elseif unequal(norm(q), 1) then
            warning("rotateq2d(x, q): Performing dubious rotation. The quaternion should be a unit quaternion.")
        end

        r = (~q * x * q).imag(1:2)
    end
endfunction
