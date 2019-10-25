function r = %quat_a_s(q, s)
    // Quaternion-complex addition.
    //
    // Syntax
    //   result = %quat_a_s(quat, s)
    //
    // Parameters
    // result: quaternion, the sum of the quaternion and the complex number
    // quat: quaternion, the first operand
    // s: real|complex|vector, the second operand
    //
    // Description
    // The sum of a quaternion with a complex number is defined as the quaternion which has each component equal to the sum of the operands components.
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

    if SCITERNIONS_FASTMODE then
        r = q; select length(s); case 1 then r(2) = r(2) + real(s); r(3)(1) = r(3)(1) + imag(s) case 2 then r(2) = r(2) + s(1); r(3)(1) = r(3)(1) + s(2) case 3 then r(3) = r(3) + s case 4 then r(2) = r(2) + s(1); r(3) = r(3) + s(2:4) end
    else
        if get_type(s).data(2) > %vector.data(2) then
            error("%quat_a_s(quat, s): Can''t add a quaternion with a matrix/hypermatrix.")
        end

        select length(s)
        case 1 then
            r = quat(q.real + real(s), [q.imag(1) + imag(s), q.imag(2:3)])
        case 2 then
            r = quat(q.real + s(1), [q.imag(1) + s(2), q.imag(2:3)])
        case 3 then
            r = quat(q.real, q.imag + s)
        case 4 then
            r = quat(q.real + s(1), q.imag + s(2:4))
        else
            error("%quat_a_s(quat, s): Can''t add a quaternion with a vector with size bigger than 4.")
        end
    end
endfunction
