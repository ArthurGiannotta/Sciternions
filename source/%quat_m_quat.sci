function r = %quat_m_quat(p, q)
    // Quaternion-quaternion multiplication.
    //
    // Syntax
    //   result = %quat_m_quat(quat1, quat2)
    //
    // Parameters
    // result: quaternion, the product of the operands
    // quat1: quaternion, the first operand
    // quat2: quaternion, the second operand
    //
    // Description
    // The product of two quaternions is defined using the distributive property of the product of complex variables.
    //
    // <latex>$(A + Bi + C j + D k)(a + b i + c j + d k) = A(a + b i + c j + d k) + B i (a + b i + c j + d k) + C j (a + b i + c j + d k) + D k (a + b i + c j + d k)$</latex>
    //
    // Using Hamilton's identity, along with its corollaries:
    //
    // <latex>$i^2 = j^2 = k^2 = i j k = -1$</latex>
    //
    // <latex>$ij = k,\ ji = -k,\ jk = i,\ kj = -i,\ ki = j,\  ik = -j$</latex>
    //
    // It follows from these relations that:
    //
    // <latex>$(A,\ B,\ C,\ D) \circ (a,\ b,\ c,\ d) = (A a - Bb - Cc - Dd,\ A b + B a + C d - D c,\ A c + C a - B d + D b,\ A d + D a + B c - C b)$</latex>
    //
    // Which is the same as:
    //
    // <latex>$(A,\ B,\ C,\ D) \circ (a,\ b,\ c,\ d) = (A, \overrightarrow{BCD}) \circ (a, \overrightarrow{bcd}) = (A a - \overrightarrow{BCD} \cdot \overrightarrow{bcd},\ A\ \overrightarrow{bcd} + a\ \overrightarrow{BCD} + \overrightarrow{BCD} \times \overrightarrow{bcd})$</latex>
    //
    // Examples
    // q = quat(1, 1, 1, 1)
    // q * ~q // quat(4, 0, 0, 0), since the product of a quaternion and its conjugate is always equal to its norm squared
    //
    // See also
    //  quat
    //  %quat_m_s
    //  %s_m_quat
    //  %quat_a_quat
    //  %quat_s_quat
    //  %quat_5
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    A = p.real; a = q.real; V = p.imag; v = q.imag

    if %fastmode then
        B = V(1); C = V(2); D = V(3)
        b = v(1); c = v(2); d = v(3)

        r = tlist(["quat", "real", "imag"], A * a - B * b - C * c - D * d, [A * b + B * a + C * d - D * c; A * c + C * a - B * d + D * b; A * d + D * a + B * c - C * b])
    else
        r = tlist(["quat", "real", "imag"], A * a - V' * v, A * v + a * V + cross(V, v))
    end
endfunction
