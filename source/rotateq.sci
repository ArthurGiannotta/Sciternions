function r = rotateq(x, q)
    // Rotation using quaternion.
    //
    // Syntax
    //   result = rotateq(x, q)
    //
    // Parameters
    // result: quaternion, the rotated object in its quaternion form
    // x: complex|vector|quaternion, the object to rotate
    // q: quaternion, the rotation quaternion
    //
    // Description
    // The rotation of an object 'x' using a rotation quaternion 'q' is defined to be a function given by the following quaternion product:
    //
    // <latex>$Rot(x, q) \triangleq \bar{q} \circ x \circ q$</latex>
    //
    // To get the result in its vector form, use one of the other rotation functions 'rotateq2d' or 'rotateq3d'. To get the result in its reduced form, use 'rotate_using_quaternion'.
    //
    // Examples
    // x_axis = [1; 0; 0]; y_axis = [0; 1; 0]; z_axis = [0; 0; 1]
    // y = rotateq(x_axis, rquatd(-90, z_axis)) // The negative sign means counterclockwise
    // if equal(y, y_axis) then
    //     display("It worked!!! Rotating the x axis 90 degrees counterclockwise around the z axis gives the y axis.")
    // end
    //
    // See also
    //  rotate_using_quaternion
    //  rotateq2d
    //  rotateq3d
    //  rquat
    //  rquatd
    //  %quat_m_quat
    //  %quat_5
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        check_args("rotateq(x, q)", x, [%vector, %quat, %complex, %real], q, %quat)

        if length(x) > 4 then
            error("rotateq(x, q): Argument checking failed for argument 1. Cannot rotate a vector with size greater than 4.")
        elseif unequal(norm(q), 1) then
            warning("rotateq(x, q): Performing dubious rotation. The quaternion should be a unit quaternion.")
        end
    end

    r = ~q * x * q
endfunction
