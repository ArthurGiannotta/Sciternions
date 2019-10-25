// This script generates the SciLab documentation for the SciTernions library

script_dir = get_absolute_file_path("help.sce")
help_dir = script_dir + "help"
source_dir = script_dir + "source"

// Recreates the documentation directory
removedir(help_dir)
mkdir(help_dir)

// Generates the XML help files
help_from_sci(source_dir, help_dir)

// Adds a new entry for the library to the help list
del_help_chapter("SciTernions")
add_help_chapter("SciTernions", help_dir)

// Builds the master document
xmltojar()

// Opens the help window
help("SciTernions")

// Clears script variables
clear("script_dir", "help_dir", "source_dir", "ans")
