function r = %quat_s_quat(x, y)
    // Quaternion-quaternion subtraction.
    //
    // Syntax
    //   result = %quat_s_quat(quat1, quat2)
    //
    // Parameters
    // result: quaternion, the difference of the quaternions
    // quat1: quaternion, the first operand
    // quat2: quaternion, the second operand
    //
    // Description
    // The difference of two quaternions is defined as the quaternion which has each component equal to the difference of the operands components.
    // <latex>$(A,\ B,\ C,\ D) - (a,\ b,\ c,\ d) = (A-a,\ B-b,\ C-c,\ D-d)$</latex>
    //
    // Examples
    // quat(0, 1, 1, -1) - quat(2, 0, 1, 1) // quat(-2, 1, 0, -2)
    //
    // See also
    //  quat
    //  %quat_s_s
    //  %s_s_quat
    //  %quat_a_quat
    //  %quat_m_quat
    //  %quat_5
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if SCITERNIONS_FASTMODE then
        r = x; r(2) = r(2) - y(2); r(3) = r(3) - y(3)
    else
        r = quat(x.real - y.real, x.imag - y.imag)
    end
endfunction
