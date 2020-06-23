function d = numerical_derivation(x, y)
    // x must be a vector
    // each line of y is equal to fi(x)
    // d has size d = zeros(y)
    // forward difference for first point, backward for last point, central for the intermediate points
    // Missing documentation

    //check x is vector y is line vector or matrix

    [m, n] = size(y)

    // check if length(x) == n

    // Preallocates memory for the derivative
    d = zeros(m, n)

    // Forward difference for the first point
    d(:, 1) = (y(:, 2) - y(:, 1)) / (x(2) - x(1))

    // Central difference for the intermediate points
    d(:, 2:$-1) = (y(:, 3:$) - y(:, 1:$-2)) ./ repmat(x(3:$) - x(1:$-2), m, 1)

    // Backward difference for the last point
    d(:, $) = (y(:, $) - y(:, $-1)) / (x($) - x($-1))
endfunction
