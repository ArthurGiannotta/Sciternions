// This script generates the Scilab documentation for the Sciternions library

script_dir = get_absolute_file_path("help.sce")

// Configuration
help_dir = script_dir + "help"
source_dir = script_dir + "source"
library_name = "Sciternions"

// Recreates the documentation directory
removedir(help_dir)
mkdir(help_dir)

// Generates the XML help files
help_from_sci(source_dir, help_dir)

// Adds a new entry for the library to the help list
del_help_chapter(library_name)
add_help_chapter(library_name, help_dir)

// Builds the master document
xmltojar()

// Opens the help window
help(library_name)

// Clears script variables
clear("script_dir", "help_dir", "source_dir", "library_name", "ans")
