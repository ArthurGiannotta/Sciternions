function e = euler(varargin)
    //Phi// Yaw angle
    //Theta// Pitch angle
    //Psi // Roll angle
    //Documentate that "e = euler(rquatd(90, %Y))" yields close to gimbal lock
    // Missing Documentation

    [outputs, inputs] = argn()

    select inputs
    case 3 then // euler(phi, theta, psi)
        if %fastmode then
            e = tlist(["euler", "phi", "theta", "psi"], varargin(1), varargin(2), varargin(3))
        else
            [phi, theta, psi] = (varargin(1), varargin(2), varargin(3))

            check_args("euler(phi, theta, psi)", phi, %real, theta, %real, psi, %real)

            e = tlist(["euler", "phi", "theta", "psi"], phi, theta, psi)
        end
    case 1 then
        in = varargin(1)
        ty = get_type(in)

        if ty == %vector then // euler(angles)
            if length(in) == 3 then
                if ~%fastmode then
                    if get_type(in(1)) ~= %real || get_type(in(2)) ~= %real || get_type(in(3)) ~= %real then
                        error("euler(angles): Argument checking failed for argument 1. A vector of euler angles must have real components.")
                    end
                end

                e = tlist(["euler", "phi", "theta", "psi"], in(1), in(2), in(3))
            else
                error("euler(angles): Argument checking failed for argument 1. A vector of euler angles must have 3 components.")
            end
        elseif ty == %quat then // euler(q)
            [q0, q1, q2, q3] = (in.real, in.imag(1), in.imag(2), in.imag(3))

            if ~%fastmode then
                t0 = 2 * (q0 * q1 + q2 * q3)
                t1 = 1 - 2 * (q1 * q1 + q2 * q2)
                t2 = 2 *(q0 * q2 - q1 * q3)
                t3 = 2 * (q0 * q3 + q1 * q2)
                t4 = 1 - 2 * (q2 * q2 + q3 * q3)

                if t2 > 1 then
                    error("euler(q): Invalid rotation quaternion. The pitch calculation yields an imaginary number.")
                elseif equal(abs(t2), 1) then
                    warning("euler(q): Gimbal lock.")
                end

                e = tlist(["euler", "phi", "theta", "psi"], atan(t0, t1), asin(t2), atan(t3, t4))
            else
                e = tlist(["euler", "phi", "theta", "psi"], atan(q0 * q1 + q2 * q3, 0.5 - q1 * q1 - q2 * q2), asin(2 *(q0 * q2 - q1 * q3)), atan(q0 * q3 + q1 * q2, 0.5 - q2 * q2 - q3 * q3))
            end
        else
            error("euler(angles | q): Argument checking failed for argument 1. It can only be a vector or a quaternion.")
        end
    case 0 then // euler()
        e = tlist(["euler", "phi", "theta", "psi"], 0, 0, 0)
    else
        error("euler: Wrong number of input arguments: 0, 1 or 3 expected.")
    end
endfunction
