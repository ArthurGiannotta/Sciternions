function r = rotateq2d(x, q)
    // 2D rotation using quaternion.
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
    // The two-dimensional rotation of a vector 'x' using a rotation quaternion 'q' is defined to be a function given by the first two imaginary parts of the following quaternion product:
    //
    // <latex>$\overrightarrow{Rot}_(\vec{x}, q) = \overrightarrow{Rot}([a, b], q) \triangleq \overrightarrow{Im}(\bar{q} \circ (0, a, b, 0) \circ q)$</latex>
    //
    // To get the result in its quaternion form, you can use the function 'rotateq'.
    //
    // Examples
    // x_axis = [1, 0]; y_axis = [0, 1]; z_axis = [0, 0, 1]
    // y = rotateq2d(x_axis, rquatd(90, z_axis))
    // if equal(y, y_axis) then
    //     display("It worked!!! Rotating the x axis 90 degrees around the z axis gives the y axis.")
    // end
    //
    // See also
    //  rotateq
    //  rotateq3d
    //  rquat
    //  rquatd
    //  %quat_m_quat
    //  %quat_5
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if fastmode then
        A = q.real; V = q.imag
        B = V(1); C = V(2); D = V(3)
        b = s(1); c = s(2)

        r = tlist(["quat", "real", "imag"], - B * b - C * c, [A * b - D * c, A * c + D * b, B * c - C * b])

        A = p.real; a = q.real; V = p.imag; v = q.imag

        B = V(1); C = V(2); D = V(3)
        b = v(1); c = v(2); d = v(3)

        r = tlist(["quat", "real", "imag"], A * a - B * b - C * c - D * d, [A * b + B * a + C * d - D * c, A * c + C * a - B * d + D * b, A * d + D * a + B * c - C * b])
    else
        check_args("rotateq2d(x, q)", x, %vector, q, %quat)

        if length(x) ~= 2 then
            error("rotateq2d(x, q): Argument checking failed for argument 1. Cannot 2D rotate a vector which is not two-dimensional.")
        end

        r = q * x * ~q

        if isfield(q, "axis") then
            // check [0, 0, 1 or 0, 0,-1]
        else
            warning("rotateq2d(x, q): Performing dubious rotation. The quaternion should be a ROTATION quaternion.")

            if abs(r.imag(3)) > %epsilon then
                error("rotateq2d(x, q): Invalid 2D rotation (the rotation quaternion does not have a valid axis of rotation).")
            end
        end

        
    end
endfunction
