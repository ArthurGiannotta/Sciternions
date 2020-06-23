function fullscreen(r)
    // Makes the current figure go fullscreen, respecting a given aspect ratio.
    //
    // Syntax
    //   fullscreen(ratio)
    //
    // Parameters
    // ratio = 1: optional real, the aspect ratio (width / height)
    //
    // Description
    // Changes the current figure position and size, forcing it to occupy the most space possible while maintaining a given aspect ratio. This ratio is defined to be the width divided by the height. Since the figure cannot be larger than the screen, the aspect ratio has an upper bound (screen width / screen height).
    //
    // Examples
    // fullscreen(1.5) // width = 1.5 * height
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    f = gcf()
    f.figure_position = [0, 0]

    px = get(0, "screensize_px")
    w = px(3); h = px(4)

    if exists("r", "local") then
        if ~%fastmode then
            check_args("fullscreen(ratio)", r, %real)

            if r < 0 then
                error("fullscreen(ratio): Argument checking failed for argument 1. The aspect ratio must be nonnegative.")
            else
                M = w / h

                if r > M then
                    error("fullscreen(ratio): Argument checking failed for argument 1. The aspect ratio must be smaller than or equal to " + string(M) + ".")
                end
            end
        end

        f.figure_size = [h * r, h]
    else
        f.figure_size = [w, h]
    end
endfunction
