function fullscreen()
    // Makes the current figure go fullscreen.
    //
    // Syntax
    //   fullscreen()
    //
    // Description
    // Changes the current figure position and size to make it go fullscreen.
    //
    // Examples
    // scf()
    // fullscreen()
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    f = gcf()
    f.figure_position = [-8,-8]
    f.figure_size = [1936,1056]
endfunction
