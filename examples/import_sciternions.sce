if ~exists("sciternions") then
    // Loads the Sciternions library
    sciternions = lib(get_absolute_file_path("import_sciternions.sce") + "../build")

    // Setups the Sciternions library
    setup_sciternions()
    predef("all")
end
