// This script builds the Sciternions library

script_dir = get_absolute_file_path("build.sce")

// Configuration
build_dir = script_dir + "build/"
source_dir = script_dir + "source/"
fastmode = %f
library_name = "Sciternions"

// Recreates the build directory
removedir(build_dir)
mkdir(build_dir)

// Copies the source into the build directory
copyfile(source_dir, build_dir)

// Applies Sciternions fastmode when requested
exec(script_dir + "fastmode.sce", -1)

// Generates the library
genlib(library_name, build_dir, %t)

// Deletes .sci files from build directory
// TBD

// Clears script variables
clear("script_dir", "build_dir", "source_dir", "fastmode", "library_name", "ans")
