function display(varargin)
    // Displaying data.
    //
    // Syntax
    //   display(arg1, ..., argn)
    //
    // Parameters
    // argi: any, a piece of data to be displayed
    //
    // Description
    // This function is used to display data in the most straightforward way. It is used as a shortcut for a lot of other functions. Let 'x' be a variable representing a piece of data. Then the following is called depending on the type of 'x':
    //
    // Command String "3D" -> plot3d([-1, 1, 1, 1], [-1, -1, -1, 1], [-1, -1, 1, 1])
    //
    // 2D Vector -> xarrows([0; x(1)], [0; x(2)])
    //
    // 3D Vector -> xarrows([0; x(1)], [0; x(2)], [0; x(3)])
    //
    // 2-Row Matrix -> plot2d(x(1,:), x(2,:))
    //
    // 3-Row Matrix -> plot3d(x(1,:), x(2,:), x(3,:))
    //
    // 2-Column Matrix (> 3 Rows) -> plot2d(x(:,1), x(:,2))
    //
    // 3-Column Matrix (> 3 Rows) -> plot3d(x(:,1), x(:,2), x(:,3))
    //
    // Everything Else -> disp(x)
    //
    // Examples
    // display([0, 1, 2, 3, 4; 0, 1, 4, 9, 16], [4, 16])
    //
    // display([0, 0; 0, 0; 0, 0]); display([1, 1, 1], [1, 0, 0], [0, 1, 0], [0, 0, 1])
    //
    // display("This is a test", sqrt(2))
    //
    // See also
    //  disp
    //  plot
    //  xarrows
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    for x = varargin do
        ty = get_type(x)

        if ty == %string then
            if x == "3D" then
                plot3d([-1, 1, 1, 1], [-1, -1, -1, 1], [-1, -1, 1, 1])
            else
                disp(x)
            end
        elseif ty == %vector then
            select length(x)
            case 2 then
                xarrows([0; x(1)], [0; x(2)])
            case 3 then
                xarrows([0; x(1)], [0; x(2)], [0; x(3)])
            else
                disp(x)
            end
        elseif ty == %matrix then
            [m, n] = size(x)

            select m
            case 2
                plot2d(x(1,:), x(2,:))
            case 3
                plot3d(x(1,:), x(2,:), x(3,:))
            else
                select n
                case 2
                    plot2d(x(:,1), x(:,2))
                case 3
                    plot3d(x(:,1), x(:,2), x(:,3))
                else
                    disp(x)
                end
            end
        else
            disp(x)
        end
    end
endfunction
