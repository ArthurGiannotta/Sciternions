function r = %quat_5(q)
    // Quaternion conjugate.
    //
    // Syntax
    //   result = %quat_5(q)
    //
    // Parameters
    // result: quaternion, the conjugate of the operand
    // q: quaternion, the operand
    //
    // Description
    // The conjugate of a quaternion is defined to be the quaternion which has the same real part, but opposite imaginary part. The conjugate of a rotation quaternion is the inverse rotation quaternion.
    //
    // <latex>$\overline{(A,\ B,\ C,\ D)} = \overline{(A, \overrightarrow{BCD})} = (A, -\overrightarrow{BCD}) = (A,\ -B,\ -C,\ -D)$</latex>
    //
    // Examples
    // ~quat(1, 1, 1, 1) // quat(1, -1, -1, -1)
    //
    // See also
    //  quat
    //  %quat_a_quat
    //  %quat_s_quat
    //  %quat_m_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    r = tlist(["quat", "real", "imag"], q.real, -q.imag)
endfunction
