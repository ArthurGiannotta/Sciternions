// This file contains a very detailed example of how to simulate a rotating rigid body
// While other examples are supposed to be run just to check the results
// This one has very useful information in the form of comments
// The legend, title and axis of the plotted graphs are written in Brazilian Portuguese

// Closes all windows
xdel(winsid())

// Clears the console
clc()

// Clears all variables
clear()

if ~exists("current_dir") then
    current_dir = get_absolute_file_path("spinning_top.sce") + "Top Simulation/"

    // Imports the Sciternions library
    exec(current_dir + "../import_sciternions.sce")
end

// Loads all functions defined in the same directory as this script
getd(current_dir)

// List of things to do after simulating
// "angles"   -> Displays the euler angles
// "animate"  -> Generates an animation video of the simulation
// "center"   -> Displays the center of mass coordinates
// "energy"   -> Displays the kinetic/potential/mechanical energy
// "momentum" -> Displays the angular momentum and its derivative
// "state"    -> Displays the evolution of the system state (omega and q)
// "torque"   -> Displays the torque over time
todo = ["angles", "center", "energy", "momentum", "state", "torque"]
//todo = ["angles", "animate", "center", "energy", "momentum", "state", "torque"] // Do everything

// Simulation files
sim_dir = current_dir + "simulation/"
sim_file = sim_dir + "spinning.sim"
top_file = sim_dir + "spinning.top"

// Animation files
anim_file = "anim.mp4"        // Name of the generated animation video
anim_temp = sim_dir + "temp/" // Temporary folder used to store each frame of the animation

// Animation parameters
anim_duration = 5 // Duration of the animation in seconds
anim_fps = 30     // Number of frames per second of the generated animation video

// Configures the simulation directory
mkdir(sim_dir)
chdir(sim_dir)
removedir(anim_temp)
mkdir(anim_temp)

// Spinning top properties
xmax = 60       // Maximum top radius (mm)
zmax = 100      // Maximum top height (mm)
resolution = 30 // Rotative resolution (rotations)

function d = density(x, z) // Cross section density function (kg / m^3)
    d = 750    // Holly Wood
    //d = 950  // Box Wood 1
    //d = 1200 // Box Wood 2
endfunction

// Generates the spinning top if it wasn't saved beforehand
try
    load(top_file, "spinning_top")
catch
    spinning_top = top(density, xmax * 0.001, zmax * 0.001, resolution, %true)

    // Saves the spinning top generated
    save(top_file, "spinning_top")
end

// Simulation parameters
g = 9.80665 // Gravity acceleration (m / s^2)

// Torque applied by the floor reaction force due to gravity
function T = gravity_torque(t, q, omega)
    // Center of mass after applying the current rotation quaternion
    C = rotateq3d(spinning_top.C, q)

    // Gravitational force
    G = spinning_top.M * g

    //T = cross(C, [0; 0; G])     // slow
    T = [C(2) * G; - C(1) * G; 0] // fast
endfunction

// Null torque used in torque-free systems
function T = null_torque(t, q, omega)
    T = [0; 0; 0]
endfunction

torque = null_torque // Total torque applied in the center of mass (N * m)

t0 = 0     // Initial time (s)
tf = 5     // Final time (s)
dt = 0.01  // Time step (s)

// Example: q0 = rquatd(10, %X) means 10 degrees with respect to the X axis
q0 = rquatd(0, %Y) // Initial rotation/orientation (rotation quaternion)

omega0Hz = 4 // Number of rotations per second at the initial time t = t0 (Hz)
omega0 = [0.1; 0; 2 * %pi * omega0Hz] // Rotational speed at the initial time t = t0 (rad / s)

// 0 means "always normalize", 1 means "skip 1 step, normalize, skip 1 step, ..."
normalize = 0 // Number of time steps until the rotation quaternion is renormalized

// For possible options for the solver, look at the documentation of the function 'simulate_rotation'
// Empty string means "automatically chosen"
solver = "rk4" // Differential equation solver used by the simulator

// Saves the current time before simulating
timer()
tic()

// Simulates the spinning top dynamics
sim = top_simulation(spinning_top, torque, t0:dt:tf, g, q0, omega0, normalize, solver)

// Displays the time spent simulating
disp("Simulation executed in " + string(timer()) + " CPU seconds.")
disp("Simulation executed in " + string(toc()) + " seconds.")

// Saves the simulation data
save(sim_file, "sim")

if find(todo == "angles") ~= [] then// this is not verified
    // BLAH BLAH BLAH ultiplication by 180 ; pi to convert from rad to degr
    scf(); plot2d(sim.t, 180 / %pi * [sim.Phi; sim.Theta]')

    legend(["$\phi$", "$\theta$"])

    beautify()

    // BLAH BLAH BLAH ultiplication by 180 ; pi to convert from rad to degr
    scf(); plot2d(sim.t, 180 / %pi * sim.Psi)

    title("$\psi$")

    beautify()
end

if find(todo == "animate") ~= [] then
    // Saves the current time before animating
    timer()
    tic()

    // Animates the generated simulation
    animate_top(spinning_top, anim_file, sim, anim_duration, anim_fps)

    // Displays the time spent animating
    disp("Animation executed in " + string(timer()) + " CPU cycles.")
    disp("Animation executed in " + string(toc()) + " seconds.")
end

if find(todo == "center") ~= [] then
    // Multiplication by 1000 to convert from m to mm
    scf(); plot2d(sim.t, 1000 * sim.C')

    title("Evolução Temporal do Centro de Massa")
    ylabel("$Posição\ (mm)$")
    xlabel("$Tempo\ (s)$")
    legend(["$C_x$", "$C_y$", "$C_z$"], -6)

    beautify()
end

if find(todo == "energy") ~= [] then
    if torque == null_torque then
        // Multiplication by 1000 to convert from J to mJ
        scf(); plot2d(sim.t, 1000 * sim.K)

        // Fixes the problem of almost constant graphs
        delta = 1e-4; replot([t0, 1000 * min(sim.K) - delta, tf, 1000 * max(sim.K) + delta])

        title("Evolução Temporal da Energia Cinética")
        ylabel("$Energia\ (mJ)$")
        xlabel("$Tempo\ (s)$")

        beautify()
    else
        // Multiplication by 1000 to convert from J to mJ
        scf(); plot2d(sim.t, 1000 * [sim.K; sim.U; sim.E]')

        title("Evolução Temporal da Energia")
        ylabel("$Energia\ (mJ)$")
        xlabel("$Tempo\ (s)$")
        legend(["$Energia\ Cinética$", "$Energia\ Potencial$", "$Energia\ Mecânica$"], -6)

        beautify()
    end
end

if find(todo == "momentum") ~= [] then
    scf(); plot2d(sim.t, 1000 * sim.H')

    title("Evolução Temporal do Momento Angular")
    ylabel("$Momento\ Angular\ (N \cdot mm \cdot s)$")
    xlabel("$Tempo\ (s)$")
    legend(["$H_x$", "$H_y$", "$H_z$"], -6)

    beautify()

    scf(); plot2d(sim.t, 1000 * sim.dH')

    title("Evolução Temporal da Derivada do Momento Angular")
    ylabel("$Derivada\ do\ Momento\ Angular\ (N \cdot mm)$")
    xlabel("$Tempo\ (s)$")
    legend(["$dH_x$", "$dH_y$", "$dH_z$"], -6)

    beautify()
end

if find(todo == "state") ~= [] then
    scf(); plot2d(sim.t, sim.Omega')

    beautify()

    scf(); plot2d(sim.t, sim.Q')

    beautify()
end

if find(todo == "torque") ~= [] then
    // Multiplication by 1000 to convert from N m to N mm
    scf(); plot2d(sim.t, 1000 * sim.T')

    title("Evolução Temporal do Torque")
    ylabel("$Torque\ (N \cdot mm)$")
    xlabel("$Tempo\ (s)$")
    legend(["$T_x$", "$T_y$", "$T_z$"], -6)

    beautify()
end
