function r = %quat_a_s(q, s)
    // Quaternion-complex and quaternion-vector addition.
    //
    // Syntax
    //   result = %quat_a_s(quat, s)
    //
    // Parameters
    // result: quaternion, the sum of the quaternion and the complex number or the vector
    // quat: quaternion, the first operand
    // s: real|complex|vector, the second operand
    //
    // Description
    // The sum of a quaternion with a complex number or a vector is defined as the quaternion which has each component equal to the sum of the operands components.
    // <latex>$(A,\ B,\ C,\ D) + (a + b\ i) = (A+a,\ B+b,\ C,\ D)$</latex>
    // <latex>$(A,\ B,\ C,\ D) + [a,\ b] = (A+a,\ B+b,\ C,\ D)$</latex>
    // <latex>$(A,\ B,\ C,\ D) + [b,\ c,\ d] = (A,\ B+b,\ C+c,\ D+d)$</latex>
    // <latex>$(A,\ B,\ C,\ D) + [a,\ b,\ c,\ d] = (A+a,\ B+b,\ C+c,\ D+d)$</latex>
    //
    // Examples
    // quat(0, 0, 0, 0) + 1 // quat(1, 0, 0, 0)
    // quat(0, 1, 1, -1) + (1 - 2*%i) // quat(1, -1, 1, -1)
    //
    // See also
    //  quat
    //  %s_a_quat
    //  %quat_a_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~SCITERNIONS_FASTMODE then
        if get_type(s).data(2) > %vector.data(2) then
            error("%quat_a_s(quat, s): Can''t add a quaternion with a matrix/hypermatrix.")
        end
    end

    select length(s)
    case 1 then
        r = tlist(["quat", "real", "imag"], q.real + real(s), q.imag + [imag(s), 0, 0])
    case 2 then
        r = tlist(["quat", "real", "imag"], q.real + s(1), q.imag + [s(2), 0, 0])
    case 3 then
        r = q; r.imag = r.imag + s
    case 4 then
        r = tlist(["quat", "real", "imag"], q.real + s(1), q.imag + s(2:4))
    else
        error("%quat_a_s(quat, s): Can''t add a quaternion with a vector with size bigger than 4.")
    end
endfunction
