// Imports the Sciternions library
exec(get_absolute_file_path("rotations.sce") + "import_sciternions.sce")

x = [1; 0; 0] // Vector to be rotated
theta = 45 // Angle in degrees (positive = clockwise, negative = counterclockwise)
n = [0; 1; 0] // Axis of rotation

// Prepares a fullscreen 3D plot to show the vectors
display(".3D")
fullscreen()

// Displays the vector before the rotation
display(x)

// Creates the quaternion that represents the rotation
q = rotation_quaternion_degrees(theta, n)

// Applies the 3D rotation
y = rotate_using_quaternion(x, q)

// Displays the vector after the rotation
display(y)

// Creates a rotation of half the angle of before, but in the opposite direction
q = rquatd(-theta/2, n) // rquatd = rotation_quaternion_degrees

// Composes/combines two rotations
q = compose(q, q)

// Applies the 3D rotation
y = rotateq3d(y, q) // rotateq3d = rotate_using_quaternion (for 3D vectors)

// Checks if the rotations made the vector return to the initial position
if equal(x, y) then // Obs: x == y will be false because of the numerical errors (floating point precision)
    display("A composition of two rotations of half the angle in the opposite direction cancel out with the initial rotation!")
end
