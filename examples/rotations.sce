// Imports the Sciternions library
exec(get_absolute_file_path("rotations.sce") + "import_sciternions.sce")

x = [1, 1, 1] // Vector to be rotated
theta = 45 // Angle in degrees
n = [1, 0, 0] // Axis of rotation

// Prepares a 3D plot to show the vectors
display("3D")

// Displays the vector before the rotation
display(x)

// Creates the quaternion that represents the rotation
q = rotation_quaternion_degrees(theta, n)

// Applies the rotation
y = rotate_using_quaternion(x, q)

// Displays the vector after the rotation
display(y)

// Creates a rotation of half the angle of before in the opposite direction
q = rquatd(-theta/2, n) // rquatd = rotation_quaternion_degrees

// Composes/combines two rotations
q = compose(q, q)

// Applies the rotation
y = rotateq3d(y, q) // rotateq3d = rotate_using_quaternion (for 3D vectors)

// Checks if the rotations made the vector return to the initial position
if equal(x, y) then // Obs: x == y will be false because of the numerical errors (floating point precision)
    display("It worked!!! A composition of two rotations of half the angle in the opposite direction cancel out with the initial rotation!")
end
