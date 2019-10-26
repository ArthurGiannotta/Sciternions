// Imports the SciTernions library
exec(get_absolute_file_path("rotations.sce") + "import_sciternions.sce")

x = [1, 1, 1] // Vector to be rotated

// Display the vector before the rotation

theta = 45 // Angle in degrees
n = [1, 0, 0] // Axis of rotation
q = rotation_quaternion_degrees(theta, n) // Quaternion that represents the rotation
//q = rquatd(theta, n) // This line does the same thing as the line above

// Applies the rotation
//x = rotate()

// Display the vector after the rotation

