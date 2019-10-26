if ~exists("sciternions") then
    // Loads the SciTernions library
    sciternions = lib(get_absolute_file_path("import_sciternions.sce") + "../build")

    // Setups the SciTernions library
    setup_sciternions()
    predef("all")
end
