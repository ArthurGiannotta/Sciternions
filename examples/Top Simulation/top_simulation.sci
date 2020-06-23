function sim = top_simulation(S, torque, t, g, q0, omega0, normalize, solver)
    // Missing documentation

    // Renames some of the spinning top properties
    C0 = S.C    // Coordinates of the unrotated center of mass
    J  = S.J    // Inertia matrix
    M  = S.M    // Total mass
    h0 = S.O(3) // Reference height of the potential energy

    // Simulates the rotation of the spinning top
    [Q, Omega] = simulate_rotation(torque, t, J, q0, omega0, normalize, solver)

    // Preallocates memory
    n     = length(t)
    C     = zeros(3, n) // Center of mass coordinates
    Phi   = zeros(1, n) // Yaw angle
    Theta = zeros(1, n) // Pitch angle
    Psi   = zeros(1, n) // Roll angle
    T     = zeros(3, n) // Torque
    H     = zeros(3, n) // Angular momentum
    K     = zeros(1, n) // Kinetic energy
    U     = zeros(1, n) // Potential energy
    E     = zeros(1, n) // Mechanical energy

    // Time loop to calculate some properties of the simulated rigid body
    for i = 1:n do
        [q, omega] = (quat(Q(:, i)), Omega(:, i))
        e = euler(q)

        // Calculates the coordinates of the center of mass
        C(:, i) = rotateq3d(C0, q)

        // Calculates the euler angles
        [Phi(i), Theta(i), Psi(i)] = (e.phi, e.theta, e.psi)

        // Calculates the torque
        T(:, i) = torque(t(i), q, omega)

        // Calculates the angular momentum
        H(:, i) = J * omega

        // Calculates the kinetic energy
        K(i) = omega' * H(:, i) * 0.5

        // Calculates the potential energy
        U(i) = M * g * (C(3, i) - h0)

        // Calculates the mechanical energy
        E(i) = K(i) + U(i)
    end

    dH = numerical_derivation(t, H) // Derivative of the angular momentum

    // Creates the simulation object
    sim = tlist(["simulation", "J", "t", "Q", "Omega", "C", "Phi", "Theta", "Psi", "T", "H", "dH", "K", "U", "E"], J, t, Q, Omega, C, Phi, Theta, Psi, T, H, dH, K, U, E)
endfunction
