function q = quat(varargin)
    // Creates a quaternion.
    //
    // Syntax
    //   q = quat(a, b, c, d)
    //   q = quat(a, bcd)
    //   q = quat(abcd)
    //   q = quat(bcd)
    //   q = quat(bc)
    //   q = quat(ab)
    //   q = quat(q0)
    //   q = quat()
    //
    // Parameters
    // q: quaternion, the quaternion to be created
    // a: real, the real part
    // b: real, the first imaginary part
    // c: real, the second imaginary part
    // d: real, the third imaginary part
    // abcd: vector, the real and imaginary parts
    // bcd: vector, the imaginary part
    // bc: vector, the first and second imaginary parts
    // ab: complex, the real and first imaginary parts
    // q0: quaternion, the quaternion to copy
    //
    // Description
    // Generates an object of the quaternion class. It is basically a typed list with name "quat" and elements "real" and "imag", which contains, respectively, the real and imaginary parts of the quaternion.
    //
    // Examples
    // q = quat(0, 1, 0, 0)
    // q = quat(0, [1, 0, 0])
    // q = quat([0, 1, 0, 0])
    // q = quat([1, 0, 0])
    // q = quat([1, 0])
    // q = quat(0 + %i)
    // q = quat(q)
    // q = quat()
    //
    // See also
    //  quaternion
    //  rquat
    //
    // Authors
    //  Arthur Clemente Giannotta ;
    //
    // Bibliography
    //   HAMILTON, W. R. On a new species of imaginary quantities connected with a theory of quaternions. In: Proceedings of the Royal Irish Academy. [S.l.: s.n.], 1844. v. 2, n. 424-234, p. 4–1.

    [outputs, inputs] = argn()

    select inputs
    case 4 then // quat(a, b, c, d)
        if %fastmode then
            q = tlist(["quat", "real", "imag"], varargin(1), [varargin(2), varargin(3), varargin(4)])
        else
            a = varargin(1)
            b = varargin(2)
            c = varargin(3)
            d = varargin(4)

            check_args("quat(a, b, c, d)", a, %real, b, %real, c, %real, d, %real)

            q = tlist(["quat", "real", "imag"], a, [b, c, d])
        end
    case 2 then // quat(a, v)
        if %fastmode then
            q = tlist(["quat", "real", "imag"], varargin(1), varargin(2))
        else
            a = varargin(1)
            v = varargin(2)

            check_args("quat(a, v)", a, %real, v, %vector)
            if length(v) == 3 then
                if get_type(v(1)) ~= %real || get_type(v(2)) ~= %real || get_type(v(3)) ~= %real then
                    error("quat(a, v): Argument checking failed for argument 2. The imaginary part must have real components.")
                end
            else
                error("quat(a, v): Argument checking failed for argument 2. The imaginary part must have 3 components.")
            end

            q = tlist(["quat", "real", "imag"], a, v)
        end
    case 1 then
        in = varargin(1)
        ty = get_type(in)

        if ty == %real then // quat(a)
            q = tlist(["quat", "real", "imag"], in, [0, 0, 0])
        elseif ty == %complex then // quat(ab)
            q = tlist(["quat", "real", "imag"], real(in), [imag(in), 0, 0])
        elseif ty == %vector then
            select length(in)
            case 2 then // quat(bc)
                if ~%fastmode then
                    if get_type(in(1)) ~= %real || get_type(in(2)) ~= %real then
                        error("quat(bc): Argument checking failed for argument 1. The quaternion must have real components.")
                    end
                end

                q = tlist(["quat", "real", "imag"], 0, [in(1:2), 0])
            case 3 then // quat(bcd)
                if ~%fastmode then
                    if get_type(in(1)) ~= %real || get_type(in(2)) ~= %real || get_type(in(3)) ~= %real then
                        error("quat(bcd): Argument checking failed for argument 1. The quaternion must have real components.")
                    end
                end

                q = tlist(["quat", "real", "imag"], 0, in)
            case 4 then // quat(abcd)
                if ~%fastmode then
                    if get_type(in(1)) ~= %real || get_type(in(2)) ~= %real || get_type(in(3)) ~= %real || get_type(in(4)) ~= %real then
                        error("quat(abcd): Argument checking failed for argument 1. The quaternion must have real components.")
                    end
                end

                q = tlist(["quat", "real", "imag"], in(1), in(2:4))
            else
                error("quat(?): Argument checking failed for argument 1. A quaternion cannot have more than 4 components.")
            end
        elseif ty == %quat then // quat(q0)
            q = in
        else
            error("quat(abcd | q0): Argument checking failed for argument 1. It can only be a complex number, a vector or a quaternion.")
        end
    case 0 then // quat()
        q = tlist(["quat", "real", "imag"], 0, [0, 0, 0])
    else
        error("quat: Wrong number of input arguments: 1, 2 or 4 expected.")
    end
endfunction
