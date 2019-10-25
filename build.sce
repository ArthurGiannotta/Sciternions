// This script builds the SciTernions library

script_dir = get_absolute_file_path("build.sce")

// Configuration
build_dir = script_dir + "build/"
source_dir = script_dir + "source/"
fastmode = %t

// Recreates the build directory
removedir(build_dir)
mkdir(build_dir)

// Copies the source into the build directory
copyfile(source_dir, build_dir)

// Applies SciTernions fastmode when requested
exec(script_dir + "fastmode.sce", -1)

// Generates the library
genlib("SciTernions", build_dir, %t)

// Deletes .sci files from build directory
// TBD

// Clears script variables
clear("script_dir", "build_dir", "source_dir", "fastmode", "ans")
