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
    // Command String ".3D" -> plot3d([-1, 1, 1, 1], [-1, -1, -1, 1], [-1, -1, 1, 1])
    //
    // Command [".3Dl", xlim, ylim, zlim] -> plot3d(xlim * [-1, 1, 1, 1], ylim * [-1, -1, -1, 1], zlim * [-1, -1, 1, 1])
    //
    // Command [".3Dse", [xstart, xend], [ystart, yend], [zstart, zend]] -> plot3d([xstart, xend, xend, xend], ylim * [ystart, ystart, ystart, yend], zlim * [zstart, zstart, zend, zend])
    //
    // String -> xstringb(0, 0, x, 1, 1)
    //
    // Imaginary -> xarrows([0; imag(x)], [0; 0])
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
            if part(x, 1) == "." then
                cmd = part(x, 2:$)

                select cmd
                case "3D" then
                    plot3d([-1, 1, 1, 1], [-1, -1, -1, 1], [-1, -1, 1, 1])
                else
                    error("display(""." + cmd + """): Unrecognized command string.")
                end
            else
                xstringb(0, 0, x, 1, 1)
            end
        elseif ty == %list then
            n = length(x)

            if n > 0 && get_type(x(1)) == %string && part(x(1), 1) == "." then
                cmd = part(x(1), 2:$)

                select cmd
                case "3Dl" then
                    if n > 4 then
                        error("display(["".3Dl"", xlim, ylim, zlim]): Command has more than 3 arguments.")
                    elseif n < 4 then
                        error("display(["".3Dl"", xlim, ylim, zlim]): Command has less than 3 arguments.")
                    else
                        plot3d(x(2) * [-1, 1, 1, 1], x(3) * [-1, -1, -1, 1], x(4) * [-1, -1, 1, 1])
                    end
                case "3Dse" then
                    if n > 4 then
                        error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): Command has more than 3 arguments.")
                    elseif n < 4 then
                        error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): Command has less than 3 arguments.")
                    else
                        X = x(2); Y = x(3); Z = x(4)

                        if get_type(X) ~= %vector || length(X) ~= 2 then
                            error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The first argument must be a 2D vector [xstart, xend].")
                        elseif get_type(Y) ~= %vector || length(Y) ~= 2 then
                            error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The second argument must be a 2D vector [ystart, yend].")
                        elseif get_type(Z) ~= %vector || length(Z) ~= 2 then
                            error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The third argument must be a 2D vector [zstart, zend].")
                        else
                            xs = X(1); xe = X(2)
                            ys = Y(1); ye = Y(2)
                            zs = Z(1); ze = Z(2)

                            if get_type(xs) ~= %real || get_type(xe) ~= %real then
                                error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The first argument [xstart, xend] must have real components.")
                            elseif get_type(ys) ~= %real || get_type(ye) ~= %real then
                                error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The second argument [ystart, yend] must have real components.")
                            elseif get_type(zs) ~= %real || get_type(ze) ~= %real then
                                error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The third argument [zstart, zend] must have real components.")
                            elseif xs >= xe then
                                error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The first argument [xstart, xend] must have xstart < xend.")
                            elseif ys >= ye then
                                error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The second argument [ystart, yend] must have ystart < yend.")
                            elseif zs >= ze then
                                error("display(["".3Dse"", [xstart, xend], [ystart, yend], [zstart, zend]]): The third argument [zstart, zend] must have zstart < zend.")
                            else
                                plot3d([xs, xe, xe, xe], [ys, ys, ys, ye], [zs, zs, ze, ze])
                            end
                        end
                    end
                else
                    error("display([""." + cmd + """]): Unrecognized command.")
                end
            else
                disp(x)
            end
        elseif ty == %complex then
            if abs(real(x)) <= %epsilon then
                xarrows([0; imag(x)], [0; 0])
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
