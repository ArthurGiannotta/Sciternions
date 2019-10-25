function r = %quat_s_quat(x, y)
    // Quaternion-quaternion subtraction.
    //
    // Syntax
    //   result = %quat_s_quat(quat1, quat2)
    //
    // Parameters
    // result: quaternion, the difference between the quaternions
    // quat1: quaternion, the first operand
    // quat2: quaternion, the second operand
    //
    // Description
    // The difference between two quaternions is defined as the quaternion which has each component equal to the difference of the operands components.
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

    r = tlist(["quat", "real", "imag"], x.real - y.real, x.imag - y.imag)
endfunction
