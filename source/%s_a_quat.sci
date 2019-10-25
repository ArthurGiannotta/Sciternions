function r = %s_a_quat(s, q)
    // Complex-Quaternion addition.
    //
    // Syntax
    //   result = %s_a_quat(s, quat)
    //
    // Parameters
    // result: quaternion, the sum of the quaternion and the complex number
    // s: real|complex|vector, the first operand
    // quat: quaternion, the second operand
    //
    // Description
    // The sum of a complex number with a quaternion is defined as the quaternion which has each component equal to the sum of the operands components.
    // <latex>$(A + B\ i) + (a,\ b,\ c,\ d) = (A+a,\ B+b,\ c,\ d)$</latex>
    // <latex>$[A,\ B] + (a,\ b,\ c,\ d) = (A+a,\ B+b,\ C,\ D)$</latex>
    // <latex>$[B,\ C,\ D] + (a,\ b,\ c,\ d) = (a,\ B+b,\ C+c,\ D+d)$</latex>
    // <latex>$[A,\ B,\ C,\ D] + (a,\ b,\ c,\ d) = (A+a,\ B+b,\ C+c,\ D+d)$</latex>
    //
    // Examples
    // 1 + quat(0, 0, 0, 0) // quat(1, 0, 0, 0)
    // (1 - 2*%i) + quat(0, 1, 1, -1) // quat(1, -1, 1, -1)
    //
    // See also
    //  quat
    //  %quat_a_s
    //  %quat_a_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if SCITERNIONS_FASTMODE then
        r = q; select length(s); case 1 then r(2) = real(s) + r(2); r(3)(1) = imag(s) + r(3)(1) case 2 then r(2) = s(1) + r(2); r(3)(1) = s(2) + r(3)(1) case 3 then r(3) = s + r(3) case 4 then r(2) = s(1) + r(2); r(3) = s(2:4) + r(3) end
    else
        if get_type(s).data(2) > %vector.data(2) then
            error("%s_a_quat(s, quat): Can''t add a matrix/hypermatrix with a quaternion.")
        end

        select length(s)
        case 1 then
            r = quat(real(s) + q.real, [imag(s) + q.imag(1), q.imag(2:3)])
        case 2 then
            r = quat(s(1) + q.real, [s(2) + q.imag(1), q.imag(2:3)])
        case 3 then
            r = quat(q.real, s + q.imag)
        case 4 then
            r = quat(s(1) + q.real, s(2:4) + q.imag)
        else
            error("%s_a_quat(s, quat): Can''t add a vector with size bigger than 4 with a quaternion.")
        end
    end
endfunction
