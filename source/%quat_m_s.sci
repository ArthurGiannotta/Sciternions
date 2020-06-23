function r = %quat_m_s(q, s)
    // Quaternion-complex and quaternion-vector multiplication.
    //
    // Syntax
    //   result = %quat_m_s(q, s)
    //
    // Parameters
    // result: quaternion, the product of the operands
    // q: quaternion, the first operand
    // s: complex|vector, the second operand
    //
    // Description
    // The product of a quaternion with a complex number or a vector is defined as follows:
    //
    // <latex>$(A,\ B,\ C,\ D) \circ (a + b\ i) = (A,\ B,\ C,\ D) \circ (a,\ b,\ 0,\ 0)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) \circ [b,\ c] = (A,\ B,\ C,\ D) \circ (0,\ b,\ c,\ 0)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) \circ [b,\ c,\ d] = (A,\ B,\ C,\ D) \circ (0,\ b,\ c,\ d)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) \circ [a,\ b,\ c,\ d] = (A,\ B,\ C,\ D) \circ (a,\ b,\ c,\ d)$</latex>
    //
    // Examples
    // q = quat(1, 1, 1, 1)
    // q * 1 // quat(1, 1, 1, 1)
    // q * (1 + %i) // quat(0, 2, 2, 0)
    // q * [1; 1] // quat(-2, 0, 2, 0)
    // q * [1; 1; 1] // quat(-3, 1, 1, 1)
    // q * [1; 1; 1; 1] // quat(-2, 2, 2, 2)
    //
    // See also
    //  quat
    //  %s_m_quat
    //  %quat_m_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        ss = size(s)

        if length(ss) == 2 then
            if ss(2) ~= 1 then
                if ss(1) == 1 then
                    warning("%quat_m_s(q, s): Transposing the multiplier, which should not be a row vector.")
                    s = s'
                else
                    error("%quat_m_s(q, s): Argument checking failed for argument 2. Cannot multiply a quaternion with a matrix.")
                end
            end
        else
            error("%quat_m_s(q, s): Argument checking failed for argument 2. Cannot multiply a quaternion with a hypermatrix.")
        end
    end

    A = q.real; V = q.imag

    select length(s)
    case 1 then
        if imag(s) == 0 then
            a = s

            r = tlist(["quat", "real", "imag"], A * a, V * a)
        else
            if %fastmode then
                B = V(1); C = V(2); D = V(3)
                a = real(s); b = imag(s)

                r = tlist(["quat", "real", "imag"], A * a - B * b, [A * b + B * a; C * a + D * b; D * a - C * b])
            else
                a = real(s); v = [imag(s); 0; 0]

                r = tlist(["quat", "real", "imag"], A * a - V' * v, A * v + a * V + cross(V, v))
            end
        end
    case 2 then
        if %fastmode then
            B = V(1); C = V(2); D = V(3)
            b = s(1); c = s(2)

            r = tlist(["quat", "real", "imag"], - B * b - C * c, [A * b - D * c; A * c + D * b; B * c - C * b])
        else
            v = [s(1:2); 0]

            r = tlist(["quat", "real", "imag"], - V' * v, A * v + cross(V, v))
        end
    case 3 then
        if %fastmode then
            B = V(1); C = V(2); D = V(3)
            b = s(1); c = s(2); d = s(3)

            r = tlist(["quat", "real", "imag"], - B * b - C * c - D * d, [A * b + C * d - D * c; A * c - B * d + D * b; A * d + B * c - C * b])
        else
            r = tlist(["quat", "real", "imag"], - V' * s, A * s + cross(V, s))
        end
    case 4 then
        if %fastmode then
            B = V(1); C = V(2); D = V(3)
            a = s(1); b = s(2); c = s(3); d = s(4)

            r = tlist(["quat", "real", "imag"], A * a - B * b - C * c - D * d, [A * b + B * a + C * d - D * c; A * c + C * a - B * d + D * b; A * d + D * a + B * c - C * b])
        else
            a = s(1); v = s(2:4)

            r = tlist(["quat", "real", "imag"], A * a - V' * v, A * v + a * V + cross(V, v))
        end
    else
        error("%quat_m_s(q, s): Argument checking failed for argument 2. Cannot multiply a quaternion with a vector with size greater than 4.")
    end
endfunction
