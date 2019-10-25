if ~exists("sciternions") then
    // Loads the SciTernions library
    sciternions = lib(get_absolute_file_path("rotations.sce") + "../build")

    // Setups the SciTernions library
    setup_sciternions()
    predef("all")
end

// Makes a vector to rotate and a rotation quaternion
x = [1, 0, 0]

// Applies the rotation
