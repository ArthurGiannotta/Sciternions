function r = %quat_a_s(q, s)
    // Quaternion-complex and quaternion-vector addition.
    //
    // Syntax
    //   result = %quat_a_s(q, s)
    //
    // Parameters
    // result: quaternion, the sum of the operands
    // q: quaternion, the first operand
    // s: complex|vector, the second operand
    //
    // Description
    // The sum of a quaternion with a complex number or a vector is defined as the quaternion which has each component equal to the sum of the operands components.
    //
    // <latex>$(A,\ B,\ C,\ D) + (a + b\ i) = (A+a,\ B+b,\ C,\ D)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) + [b,\ c] = (A,\ B+b,\ C+c,\ D)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) + [b,\ c,\ d] = (A,\ B+b,\ C+c,\ D+d)$</latex>
    //
    // <latex>$(A,\ B,\ C,\ D) + [a,\ b,\ c,\ d] = (A+a,\ B+b,\ C+c,\ D+d)$</latex>
    //
    // Examples
    // q = quat(-1, -1, -1, -1)
    // q + 1 // quat(0, -1, -1, -1)
    // (1 + %i) + q // quat(0, 0, -1, -1)
    // [1; 1] + q // quat(-1, 0, 0, -1)
    // [1; 1; 1] + q // quat(-1, 0, 0, 0)
    // [1; 1; 1; 1] + q // quat(0, 0, 0, 0)
    //
    // See also
    //  quat
    //  %s_a_quat
    //  %quat_a_quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        ss = size(s)

        if length(ss) == 2 then
            if ss(2) ~= 1 then
                if ss(1) == 1 then
                    warning("%quat_a_s(q, s): Transposing the addend, which should not be a row vector.")
                    s = s'
                else
                    error("%quat_a_s(q, s): Argument checking failed for argument 2. Cannot add a quaternion with a matrix.")
                end
            end
        else
            error("%quat_a_s(q, s): Argument checking failed for argument 2. Cannot add a quaternion with a hypermatrix.")
        end
    end

    select length(s)
    case 1 then
        r = tlist(["quat", "real", "imag"], q.real + real(s), q.imag + [imag(s); 0; 0])
    case 2 then
        r = tlist(["quat", "real", "imag"], q.real, q.imag + [s; 0])
    case 3 then
        r = tlist(["quat", "real", "imag"], q.real, q.imag + s)
    case 4 then
        r = tlist(["quat", "real", "imag"], q.real + s(1), q.imag + s(2:4))
    else
        error("%quat_a_s(q, s): Argument checking failed for argument 2. Cannot add a quaternion with a vector with size greater than 4.")
    end
endfunction
