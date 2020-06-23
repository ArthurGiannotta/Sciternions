function Y = numerical_integration(y0, t, dy, update, solver)
    // update is a function that updates the solution after every iteration (can be used to normalize the solution after each time step)
    // Y is always (length(y0) x length(t))
    // Missing Documentation ("euler", "midpoint", "implicit", "heun", "rk2" or "rk4")

    // Default argument "deff('y = update(i, y)', '')"
    if ~exists("update", "local") then
        deff("y = update(i, y)", "")
    end

    // Default argument "solver = 'rk4'"
    if ~exists("solver", "local") || isempty(solver) then
        solver = "rk4"
    end

    // Checks if the arguments have the correct types
    if ~%fastmode then
        check_args("numerical_integration(y0, t, dy, update, solver)", y0, %vector, t, %vector, dy, %function, update, %function, solver, %string)
    end

    if solver == "euler" then // Forward Euler Method / Explicit Euler Method
        function y = algorithm(y, h, f, t)
            // $y_{n + 1} = y_n + h f(t_n, y_n)$
            y = y + h * f(t, y)
        endfunction
    elseif solver == "implicit" then // Backward Euler Method / Implicit Euler Method
    elseif solver == "midpoint" then // Midpoint Method
    elseif solver == "heun" then // Heun's Method
    elseif solver == "rk2" then // 2nd Order Runge-Kutta Method
    elseif solver == "rk4" then // 4th Order Runge-Kutta Method
        // Precalculates constants that appear in the algorithm
        sixth = 1 / 6

        function y = algorithm(y, h, f, t)
            // Precalculates half the time step
            h2 = 0.5 * h

            // $k_1 = f(t_n, y_n)$
            k1 = f(t, y)

            // $k_2 = f(t_n + \frac{h}{2}, y_n + \frac{h}{2} k_1)$
            k2 = f(t + h2, update(0, y + h2 * k1))

            // $k_3 = f(t_n + \frac{h}{2}, y_n + \frac{h}{2} k_2)$
            k3 = f(t + h2, update(0, y + h2 * k2))

            // $k_4 = f(t_n + h, y_n + h k_3)$
            k4 = f(t + h, update(0, y + h * k3))

            // $y_{n + 1} = y_n + \frac{h}{6}(k_1 + 2 k_2 + 2 k_3 + k_4)$
            y = y + sixth * h * (k1 + 2 * k2 + 2 * k3 + k4)
        endfunction
    else
        error("numerical_integration(y0, t, dy, update, solver): Invalid solver algorithm """ + solver + """. A list of possible solvers can be found in the documentation.")
    end

    n = length(t) // Number of points of the solution
    t0 = t(1)     // Current time

    // Preallocates memory for the result
    Y = zeros(length(y0), n)
    Y(:, 1) = y0

    // Time loop
    for i = 2:n do
        t1 = t(i)    // Next time
        dt = t1 - t0 // Time step

        // Applies the solver algorithm and updates the next point of the solution
        Y(:, i) = update(i - 1, algorithm(Y(:, i - 1), dt, dy, t0))

        // Updates the current time
        t0 = t1
    end
endfunction
