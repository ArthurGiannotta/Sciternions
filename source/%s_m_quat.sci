function r = %s_m_quat(s, q)
    // Complex-quaternion and vector-quaternion multiplication.
    //
    // Syntax
    //   result = %s_m_quat(s, q)
    //
    // Parameters
    // result: quaternion, the product of the operands
    // s: complex|vector, the first operand
    // q: quaternion, the second operand
    //
    // Description
    // The product of a complex number or a vector with a quaternion is defined as follows:
    //
    // <latex>$(A + B\ i) \circ (a,\ b,\ c,\ d) = (A,\ B,\ 0,\ 0) \circ (a,\ b,\ c,\ d)$</latex>
    //
    // <latex>$[B,\ C] \circ (a,\ b,\ c,\ d) = (0,\ B,\ C,\ 0) \circ (a,\ b,\ c,\ d)$</latex>
    //
    // <latex>$[B,\ C,\ D] \circ (a,\ b,\ c,\ d) = (0,\ B,\ C,\ D) \circ (a,\ b,\ c,\ d)$</latex>
    //
    // <latex>$[A,\ B,\ C,\ D] \circ (a,\ b,\ c,\ d) = (A,\ B,\ C,\ D) \circ (a,\ b,\ c,\ d)$</latex>
    //
    // Examples
    // q = quat(1, 1, 1, 1)
    // 1 * q // quat(1, 1, 1, 1)
    // (1 + %i) * q // quat(0, 2, 0, 2)
    // [1; 1] * q // quat(-2, 2, 0, 0)
    // [1; 1; 1] * q // quat(-3, 1, 1, 1)
    // [1; 1; 1; 1] * q // quat(-2, 2, 2, 2)
    //
    // See also
    //  quat
    //  %quat_m_s
    //  %quat_m_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        ss = size(s)

        if length(ss) == 2 then
            if ss(2) ~= 1 then
                if ss(1) == 1 then
                    warning("%s_m_quat(s, q): Transposing the multiplicand, which should not be a row vector.")
                    s = s'
                else
                    error("%s_m_quat(s, q): Argument checking failed for argument 1. Cannot multiply a matrix with a quaternion.")
                end
            end
        else
            error("%s_m_quat(s, q): Argument checking failed for argument 1. Cannot multiply a hypermatrix with a quaternion.")
        end
    end

    a = q.real; v = q.imag

    select length(s)
    case 1 then
        if imag(s) == 0 then
            A = real(s)

            r = tlist(["quat", "real", "imag"], A * a, A * v)
        else
            if %fastmode then
                A = real(s); B = imag(s)
                b = v(1); c = v(2); d = v(3)

                r = tlist(["quat", "real", "imag"], A * a - B * b, [A * b + B * a; A * c - B * d; A * d + B * c])
            else
                A = real(s); V = [imag(s); 0; 0]

                r = tlist(["quat", "real", "imag"], A * a - V' * v, A * v + a * V + cross(V, v))
            end
        end
    case 2 then
        if %fastmode then
            B = s(1); C = s(2)
            b = v(1); c = v(2); d = v(3)

            r = tlist(["quat", "real", "imag"], - B * b - C * c, [B * a + C * d; C * a - B * d; B * c - C * b])
        else
            V = [s(1:2); 0]

            r = tlist(["quat", "real", "imag"], - V' * v, a * V + cross(V, v))
        end
    case 3 then
        if %fastmode then
            B = s(1); C = s(2); D = s(3)
            b = v(1); c = v(2); d = v(3)

            r = tlist(["quat", "real", "imag"], - B * b - C * c - D * d, [B * a + C * d - D * c; C * a - B * d + D * b; D * a + B * c - C * b])
        else
            r = tlist(["quat", "real", "imag"], - s' * v, a * s + cross(s, v))
        end
    case 4 then
        if %fastmode then
            A = s(1); B = s(2); C = s(3); D = s(4)
            b = v(1); c = v(2); d = v(3)

            r = tlist(["quat", "real", "imag"], A * a - B * b - C * c - D * d, [A * b + B * a + C * d - D * c; A * c + C * a - B * d + D * b; A * d + D * a + B * c - C * b])
        else
            A = s(1); V = s(2:4)

            r = tlist(["quat", "real", "imag"], A * a - V' * v, A * v + a * V + cross(V, v))
        end
    else
        error("%s_m_quat(s, q): Argument checking failed for argument 1. Cannot multiply a vector with size greater than 4 with a quaternion.")
    end
endfunction
