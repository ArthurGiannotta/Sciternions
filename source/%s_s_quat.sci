function r = %s_s_quat(s, q)
    // Complex-quaternion and vector-quaternion subtraction.
    //
    // Syntax
    //   result = %s_s_quat(s, quat)
    //
    // Parameters
    // result: quaternion, the difference between the quaternion and the complex number or the vector
    // s: real|complex|vector, the first operand
    // quat: quaternion, the second operand
    //
    // Description
    // The difference between a complex number or a vector and a quaternion is defined as the quaternion which has each component equal to the difference between the operands components.
    // <latex>$(A + B\ i) - (a,\ b,\ c,\ d) = (A-a,\ B-b,\ c,\ d)$</latex>
    // <latex>$[A,\ B] - (a,\ b,\ c,\ d) = (A-a,\ B-b,\ C,\ D)$</latex>
    // <latex>$[B,\ C,\ D] - (a,\ b,\ c,\ d) = (a,\ B-b,\ C-c,\ D-d)$</latex>
    // <latex>$[A,\ B,\ C,\ D] - (a,\ b,\ c,\ d) = (A-a,\ B-b,\ C-c,\ D-d)$</latex>
    //
    // Examples
    // 1 - quat(0, 0, 0, 0) // quat(1, 0, 0, 0)
    // (1 + %i) - quat(0, 1, 1, -1) // quat(1, 0, -1, 1)
    //
    // See also
    //  quat
    //  %quat_s_s
    //  %quat_s_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        if get_type(s).data(2) > %vector.data(2) then
            error("%s_s_quat(s, quat): Can''t subtract a quaternion from a matrix/hypermatrix.")
        end
    end

    select length(s)
    case 1 then
        r = tlist(["quat", "real", "imag"], real(s) - q.real, [imag(s), 0, 0] - q.imag)
    case 2 then
        r = tlist(["quat", "real", "imag"], s(1) - q.real, [s(2), 0, 0] - q.imag)
    case 3 then
        r = q; r.imag = s - r.imag
    case 4 then
        r = tlist(["quat", "real", "imag"], s(1) - q.real, s(2:4) - q.imag)
    else
        error("%s_s_quat(s, quat): Can''t subtract a quaternion from a vector with size bigger than 4.")
    end
endfunction
