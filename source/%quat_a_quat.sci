function r = %quat_a_quat(x, y)
    // Quaternion-quaternion addition.
    //
    // Syntax
    //   result = %quat_a_quat(quat1, quat2)
    //
    // Parameters
    // result: quaternion, the sum of the quaternions
    // quat1: quaternion, the first operand
    // quat2: quaternion, the second operand
    //
    // Description
    // The sum of two quaternions is defined as the quaternion which has each component equal to the sum of the operands components.
    // <latex>$(A,\ B,\ C,\ D) + (a,\ b,\ c,\ d) = (A+a,\ B+b,\ C+c,\ D+d)$</latex>
    //
    // Examples
    // quat(0, 1, 1, -1) + quat(2, 0, 1, 1) // quat(2, 1, 2, 0)
    //
    // See also
    //  quat
    //  %quat_a_s
    //  %s_a_quat
    //  %quat_s_quat
    //  %quat_m_quat
    //  %quat_5
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    r = tlist(["quat", "real", "imag"], x.real + y.real, x.imag + y.imag)
endfunction
