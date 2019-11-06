function r = %quat_s_s(q, s)
    // Quaternion-complex and quaternion-vector subtraction.
    //
    // Syntax
    //   result = %quat_s_s(q, s)
    //
    // Parameters
    // result: quaternion, the difference between the operands
    // q: quaternion, the first operand
    // s: complex|vector, the second operand
    //
    // Description
    // The difference between a quaternion and a complex number or a vector is defined as the quaternion which has each component equal to the difference between the operands components.
    //
    // <latex>$(A,\ B,\ C,\ D) - (a + b\ i) = (A-a,\ B-b,\ C,\ D)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) - [b,\ c] = (A,\ B-b,\ C-c,\ D)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) - [b,\ c,\ d] = (A,\ B-b,\ C-c,\ D-d)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) - [a,\ b,\ c,\ d] = (A-a,\ B-b,\ C-c,\ D-d)$</latex>
    //
    // Examples
    // q = quat(1, 1, 1, 1)
    // q - 1 // quat(0, 1, 1, 1)
    // q - (1 + %i) // quat(0, 0, 1, 1)
    // q - [1, 1] // quat(1, 0, 0, 1)
    // q - [1, 1, 1] // quat(1, 0, 0, 0)
    // q - [1, 1, 1, 1] // quat(0, 0, 0, 0)
    //
    // See also
    //  quat
    //  %s_s_quat
    //  %quat_s_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        if get_type(s).data(2) > %vector.data(2) then
            error("%quat_s_s(q, s): Argument checking failed for argument 2. Cannot subtract a matrix/hypermatrix from a quaternion.")
        end
    end

    select length(s)
    case 1 then
        r = tlist(["quat", "real", "imag"], q.real - real(s), q.imag - [imag(s), 0, 0])
    case 2 then
        r = q; r.imag = r.imag - [s(1:2), 0]
    case 3 then
        r = q; r.imag = r.imag - s
    case 4 then
        r = tlist(["quat", "real", "imag"], q.real - s(1), q.imag - s(2:4))
    else
        error("%quat_s_s(q, s): Argument checking failed for argument 2. Cannot subtract a vector with size greater than 4 from a quaternion.")
    end
endfunction
