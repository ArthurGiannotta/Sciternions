// DONE BUT MISSING DOCUMENTATION:
// numerical_integration.sci
// beautify.sci
// top_simulation.sci
// euler.sci
// simulate_rotation.sci
// numerical_derivation.sci
// continuous_angle.sci

// DONE BUT MISSING ARGUMENT CHECKING:
// beautify.sci
// simulate_rotation.sci
// top_simulation.sci
// numerical_derivation.sci
// continuous_angle.sci

// NOT DONE MISSING EVERYTHING, JUST TEMPORARILY DONE:
// compose.sci
// combine.sci
// %quat_norm.sci
// draw_top.sci
// draw_top_cross_section.sci
// top_style.sci
// point_in_polygon.sci
// is_integer.sci

// "quat" function can also receive a euler angle object as argument (test if quat(euler(q)) == q and if euler(quat(e)) == e)
// "time" function has a parameter to use tic() toc() instead, or maybe return both tic toc and timer outputs
// Make function fullscreen receive fig as a parameter, just as in beautify. Also when beautify calls fullscreen pass the parameter fig
// The message thrown by check_args is Type is [1 1] but should be [1 2]. Change [1 1] to "complex" and [1 2] to "real"
// Overload imag and real
// quat_f_quat for column list of quaternions
// Macros for %I = quat(0, 1, 0, 0), %1 = quat(1, 0, 0, 0) %J and %K and %0 = quat(0, 0, 0, 0)
// create quat4, quat2, quat1 that accelerate quaternion creation by skipping varargin checks
// use quat4, quat2 and quat1 in quat (maybe not?)
// quat stringification
// overload quat * 2 and 2 * quat and (1 + %i) * quat and quat * (1 + %i) and [1,2] * quat and quat * [1,2]
// make quaternion inverse -quat = -a, -b, -c, -d
// create class for Euler Angles
// function angle, angled, axis to get angle/axis from quaternion (these functions also ge angle and axis from non-rotation quaternions), possibly overload cos(quat) to get cos of the angle and sin(quat)/tan(quat)/sec/cosse
// function that tries to convert a quaternion to a rotation quaternion (make sure multiplication does not remove the properties "axis" and "angle")
// quaternion division by real number only (remember to use the faster quat(1,2,3,4) / x = (1 / x) * quat(1,2,3,4))
// overload operator ~=
// make operator == ~= with real, complex, vectors
// Deletes .sci files from build directory after build.sce
// operator .* %quat_x_quat and ./  %quat_d_quat
// overload cross function for cross product for quaternions (check if real part of quaternion must be 0)
// overload %quat_abs function abs(quat(-1, -2, 3, -4) => quat(1,2,3,4))
// make %l_f_type, %type_c_l and %type_f_l (I was lazy)
// %quat_c_s, %quat_f_s, %s_f_quat, %s_c_quat, %c_c_quat, %c_f_quat, %quat_f_c, %quat_c_c
// %s_c_l, l_f_s, s_f_l, l_c_c, l_f_c, c_c_l, c_f_l, quat_f_l, quat_c_l, l_c_quat, l_f_quat
// Say in the rquat and rquatd documentation that the generated rotation quaternion has the elements axis and angle
// make file in examples folder "operations.sce" which will make sum product, etc. between vectors and quaternions
// Make a better README.md
// Functions rotate_top and translate_top which are referenced in the "top" function
// Implement midpoint, heun and rk2 and euler implicit

// THIS CODE IS FOR THE SINGULARITIES
public final void rotate(matrix  m) {
    // Assuming the angles are in radians.
	if (m.m10 > 0.998) { // singularity at north pole
		heading = Math.atan2(m.m02,m.m22);
		attitude = Math.PI/2;
		bank = 0;
		return;
	}
	if (m.m10 < -0.998) { // singularity at south pole
		heading = Math.atan2(m.m02,m.m22);
		attitude = -Math.PI/2;
		bank = 0;
		return;
	}
	heading = Math.atan2(-m.m20,m.m00);
	bank = Math.atan2(-m.m12,m.m11);
	attitude = Math.asin(m.m10);
}

/* Approximates the integrals of m variables using a numerical approximation method and a function representing m differential equations.
 * Y0     = n x m matrix of initial values. n is the number of derivatives to approximate.
 * t0     = Initial time.
 * T      = Matrix of times in which the derivatives should be approximated.
 * f      = External function representing all m differential equations. Should receive the current time and a m x n matrix with current values for all the derivatives being approximated and should also return a m x n matrix with the values of the next derivates for the respective variable.
 * Method = Numerical approximation method ("euler_exp1", ""euler_imp", euler_exp2", "heun", "runge-kutta2" or "runge-kutta4"). Default method is "runge-kutta4".
 * ShouldDebug = Boolean representing wheter or not to output debug information.
 * D      = m x (n x N) matrix of derivatives values, with N being the number of steps executed.
 * time   = time taken to execute the approximation method.
 */

function [D, time] = approximate(Y0, t0, T, f, Method, ShouldDebug)
    D = [];
    
    if ~mtlb_exist("ShouldDebug") then
        ShouldDebug = (1 == 0);
    end
    
    if ~mtlb_exist("Method") then
        Method = "runge-kutta4";
    end
    
    n = size(Y0)(1); // number of derivatives to approximate
    m = size(Y0)(2); // number of variables
    
    if ShouldDebug then
        if m > 1 && n > 1 then
            printf("\nTrying to approximate %d derivatives of %d variables.\n\n", n, m);
        elseif n > 1 then
            printf("\nTrying to approximate %d derivatives of 1 variable.\n\n", n);
        elseif m > 1 then
            printf("\nTrying to approximate 1 derivative of %d variables.\n\n", m);
        else
            printf("\nTrying to approximate 1 derivative of 1 variable.\n\n");
        end
        
        printf("Current Time = %f\n", t0);
    end
    
    for i = 1:m
        for j = 1:n
            D(j, 1, i) = [Y0(j, i)];
            
            if ShouldDebug then printf("Y(%d variable)(%d derivative) = %f\n", i, j, Y0(j, i)); end
        end
    end
    
    if ShouldDebug then printf("\n"); end
    
    tic();
    
    Y = Y0;
    
    for t_ = 2:size(T)(2)
        t = t0 + T(t_);
        Step = T(t_) - T(t_ - 1);
        
        if ShouldDebug then printf("Current Time = %f (Step = %f)\n", t, Step); end
        
        for i = 1:m
            if Method == "euler_exp1" then // Euler's Explicit Method
                DY = f(t, Y);
                
                for j = 1:n
                    Y(j, i) = Y(j, i) + Step * DY(j, i);
                    
                    D(j, t_, i) = [Y(j, i)];
                    
                    if ShouldDebug then printf("Y(%d variable)(%d derivative) = %f\n", i, j, Y(j, i)); end
                end
            elseif Method == "euler_imp" then // Euler's Implicit Method
                DY = f(t, Y);
                
                Error = 1;
                Tolerance = 1e-10;
                Iteration = 0;
                MaxIteration = 10; // Avoids infinite steps of approximation
                
                YOld = Y + Step * DY;
                
                while Error > Tolerance
                    if Iteration > MaxIteration then
                        break;
                    end
                    
                    DYOld = f(t + Step, YOld);
                    
                    YNew = YOld - (YOld - (Y(j, i) + Step * DYOld(1,:))) / (1 - Step * DYOld(2,:)); // Newton's Method
                    Error = abs(YNew - YOld);
                    YOld = YNew;
                    
                    Iteration = Iteration + 1;
                end
                
                Y1 = YNew;
                
                for j = 1:n
                    DY1 = f(t + Step, Y1);
                    
                    Y(j, i) = Y(j, i) + Step * DY1(j, i);
                    
                    D(j, t_, i) = [Y(j, i)];
                    
                    if ShouldDebug then printf("Y(%d variable)(%d derivative) = %f\n", i, j, Y(j, i)); end
                end
            elseif Method == "euler_exp2" then // Euler's Explicit Midpoint Method
                DY = f(t, Y);
                
                for j = 1:n
                    Y1(j, i) = Y(j, i) + (Step / 2) * DY(j, i);
                end
                
                for j = 1:n
                    DY1 = f(t + Step / 2, Y1);
                    
                    Y(j, i) = Y(j, i) + Step * DY1(j, i);
                    
                    D(j, t_, i) = [Y(j, i)];
                    
                    if ShouldDebug then printf("Y(%d variable)(%d derivative) = %f\n", i, j, Y(j, i)); end
                end
            elseif Method == "heun" then // Heun's Method
                DY = f(t, Y);
                
                for j = 1:n
                    Y1(j, i) = Y(j, i) + Step * DY(j, i);
                end
                
                for j = 1:n
                    DY1 = f(t, Y1);
                    
                    Y(j, i) = Y(j, i) + (Step / 2) * (DY(j, i) + DY1(j, i));
                    
                    D(j, t_, i) = [Y(j, i)];
                    
                    if ShouldDebug then printf("Y(%d variable)(%d derivative) = %f\n", i, j, Y(j, i)); end
                end
            elseif Method == "runge-kutta2" then // Runge-Kutta's 2nd Order Method
                Alpha = 1 / 4;
                
                DY = f(t, Y);
                
                for j = 1:n
                    Y1(j, i) = Y(j, i) + Alpha * Step * DY(j, i);
                end
                
                for j = 1:n
                    DY1 = f(t + Alpha * Step, Y1);
                    
                    Y(j, i) = Y(j, i) + Step * ((1 - 1 / (2*Alpha)) * DY(j, i) + DY1(j, i) / (2*Alpha));
                    
                    D(j, t_, i) = [Y(j, i)];
                    
                    if ShouldDebug then printf("Y(%d variable)(%d derivative) = %f\n", i, j, Y(j, i)); end
                end
            elseif Method == "runge-kutta4" then // Runge-Kutta's 4th Order Method
                K1 = f(t, Y);
                K2 = f(t + Step / 2, Y + (Step / 2) * K1);
                K3 = f(t + Step / 2, Y + (Step / 2) * K2);
                K4 = f(t + Step, Y + Step * K3);
                
                for j = 1:n
                    Y(j, i) = Y(j, i) + (Step / 6) * (K1(j, i) + 2*K2(j, i) + 2*K3(j, i) + K4(j, i));
                    
                    D(j, t_, i) = [Y(j, i)];
                    
                    if ShouldDebug then printf("Y(%d variable)(%d derivative) = %f\n", i, j, Y(j, i)); end
                end
            else // Undefined Method
                printf("Undefined approximation method.\n\n");
                
                time = toc();
                
                return;
            end
        end

        
        if ShouldDebug then printf("\n"); end
    end
    
    time = toc();
endfunction

