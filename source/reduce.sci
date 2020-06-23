function r = reduce(q)
    // Quaternion reduction.
    //
    // Syntax
    //   result = reduce(q)
    //
    // Parameters
    // result: complex|vector|quaternion, the reduced form of the quaternion
    // q: quaternion, the quaternion to reduce
    //
    // Description
    // Quaternion reduction is an operation that converts a quaternion into either a complex number or a vector, which can carry less data and so can be more memory efficient.
    //
    // <latex>$(a,\ b,\ 0,\ 0) = a + b\ i$</latex>
    //
    // <latex>$(0,\ b,\ c,\ 0) = [b, c]$</latex>
    //
    // <latex>$(0,\ b,\ c,\ d) = [b,\ c,\ d]$</latex>
    //
    // <latex>$(a,\ b,\ c,\ d) = [a,\ b,\ c,\ d]$</latex>
    //
    // Examples
    // reduce(quat(1, 0, 0, 0)) // 1
    // reduce(quat(1, 1, 0, 0)) // 1 + %i
    // reduce(quat(0, 1, 1, 0)) // [1; 1]
    // reduce(quat(0, 1, 1, 1)) // [1; 1; 1]
    // reduce(quat(1, 1, 1, 1)) // [1; 1; 1; 1]
    //
    // See also
    //  quat
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    if ~%fastmode then
        check_args("reduce(q)", q, %quat)
    end

    a = q.real; v = q.imag

    if abs(a) <= %epsilon then // (0; ?; ?; ?)
        if abs(v(3)) <= %epsilon then // (0; ?; ?; 0)
            if abs(v(2)) <= %epsilon then // (0; ?; 0; 0) = b * %i
                r = v(1) * %i
            else // (0; ?; c; 0) = [b; c]
                r = v(1:2)
            end
        else // (0; ?; ?; d) = [b; c; d]
            r = v
        end
    else // (a; ?; ?; ?)
        if abs(v(3)) <= %epsilon then // (a; ?; ?; 0)
            if abs(v(2)) <= %epsilon then // (a; ?; 0; 0) = a + b * %i
                r = a + v(1) * %i
            else // (a; ?; c; 0) = [a; b; c; d]
                r = [a; v]
            end
        else // (a; ?; ?; d) = [a; b; c; d]
            r = [a; v]
        end
    end
endfunction
