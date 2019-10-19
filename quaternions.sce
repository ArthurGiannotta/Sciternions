// Generates an object of the quaternion class
function [q] = quat(q0, q1, q2, q3)
    q = tlist(["quaternion", "q0", "q1", "q2", "q3"])

    q.q0 = q0
    q.q1 = q1
    q.q2 = q2
    q.q3 = q3
endfunction

// Alias for the function quat
function [q] = quat(q0, q1, q2, q3)
    q = quat(q0, q1, q2, q3)
endfunction

// Add two quaternions
function [result] = add(p, q)
    result = quat(p.q0 + q.q0, p.q1 + q.q1, p.q2 + q.q2, p.q3 + q.q3)
endfunction

// Subtract two quaternions
function [result] = subtract(p, q)
    result = quat(p.q0 - q.q0, p.q1 - q.q1, p.q2 - q.q2, p.q3 - q.q3)
endfunction

// Multiply two quaternions
function [result] = multiply(p, q)
    q0 = p.q0 * q.q0 - p.q1 * q.q1 - p.q2 * q.q2 - p.q3 * q.q3
    q1 = p.q0 * q.q1 + p.q1 * q.q0 + p.q2 * q.q2 - p.q3 * q.q2
    q2 = p.q0 * q.q2 - p.q1 * q.q3 + p.q2 * q.q0 + p.q3 * q.q1
    q3 = p.q0 * q.q3 + p.q1 * q.q2 - p.q2 - q.q1 + p.q3 * q.q0

    result = quat(q0, q1, q2, q3)
endfunction

// Check if two quaternions are equal
function [result] = equal(p, q)
    result = p.q0 == q.q0 && p.q1 == q.q1 && p.q2 == q.q2 && p.q3 == q.q3
endfunction

// Calculates the conjugate of a quaternion
function [result] = conjugate(q)
    result = quat(0.0, 0.0, 0.0, 0.0)
endfunction

// Overloads the + operator for quaternions
function [result] = %quaternion_a(p, q)
    result = add(p, q)
endfunction

// Overloads the - operator for quaternions
function [result] = %quaternion_s(p, q)
    result = add(p, q)
endfunction

// Overloads the * operator for quaternions
function [result] = %quaternion_m(p, q)
    result = multiply(p, q)
endfunction

// Overloads the == operator for quaternions
function [result] = %quaternion_o(p, q)
    result = equal(p, q)
endfunction

// OVerloads the ~ operator for quaternions
function [result] = %quaternion_5(p)
    result = conjugate(p)
endfunction

// Overloads the abs function to allow the calculation of norms of quaternions
function [result] = %quaternion_abs(q)
    result = sqrt(q.q0 + q.q1 + q.q2 + q.q3)
endfunction

// Rotate a vector along an axis of rotation and an angle
// To be done

// Rotate a vector using a quaternion
function [result] = rot(x, q)
    result = conjugate(q) * quat(0, x(1), x(2), x(3)) * q
endfunction
