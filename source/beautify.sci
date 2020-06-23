function beautify(fig, axes_size, datatip_size, datatip_style, fullscreen_ratio, grid_color, label_size, legend_size, thickness)
    // Attempts to make a graphic figure beautiful by changing some of the plot parameters

    // Checks if the arguments have the correct types
    if ~%fastmode then
        // check if all arguments are integers, some of them are positive only
    end

    // Default argument "fig = gcf()"
    if ~exists("fig", "local") then
        fig = gcf()
    end

    // Default argument "axes_size = 3"
    if ~exists("axes_size", "local") then
        axes_size = 3
    end

    // Default argument "datatip_size = 3"
    if ~exists("datatip_size", "local") then
        datatip_size = 3
    end

    // Default argument "datatip_style = 9"
    if ~exists("datatip_style", "local") then
        datatip_style = 9
    end

    // Default argument "grid_color = color('dimgrey')"
    if ~exists("grid_color", "local") then
        grid_color = color("dimgrey")
    end

    // Default argument "label_size = 4"
    if ~exists("label_size", "local") then
        label_size = 4
    end

    // Default argument "legend_size = 3"
    if ~exists("legend_size", "local") then
        legend_size = 3
    end

    // Default argument "thickness = 2"
    if ~exists("thickness", "local") then
        thickness = 2
    end

    // Modifies a handle and its children trying to improve its appearance
    function beautiful(handle)
        try
            select handle.type
            case "Axes"
                handle.font_size = axes_size
                handle.grid = [grid_color, grid_color, grid_color]

                beautiful(handle.title)
                beautiful(handle.x_label)
                beautiful(handle.y_label)
                beautiful(handle.z_label)
            case "Datatip"
                handle.font_size = datatip_size
                handle.mark_style = datatip_style
            case "Figure"
                if exists("fullscreen_ratio", "local") then
                    fullscreen(fullscreen_ratio)
                else
                    fullscreen()
                end
            case "Label"
                handle.font_size = label_size
            case "Legend"
                handle.font_size = legend_size
            case "Polyline"
                handle.thickness = thickness

                // Datatips beautification
                datatips = handle.datatips
                for i = 1:length(datatips) do
                    beautiful(datatips(i))
                end
            end

            // Recursive children beautification
            children = handle.children
            for i = 1:length(children) do
                beautiful(children(i))
            end
        end
    endfunction

    // Starts with the figure handle as the root and recursively beautify its children
    beautiful(fig)
endfunction
