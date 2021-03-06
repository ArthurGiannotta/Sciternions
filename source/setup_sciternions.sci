function setup_sciternions(arguments)
    // Setups the Sciternions library.
    //
    // Syntax
    //   setup_sciternions()
    //
    // Description
    // Creates all necessary variables and makes all sorts of preparations for the Sciternions library to work. This function MUST be called before any other library function, preferably right after using the Scilab 'load' function. Calling 'predef("all")' after the setup is also desirable. But be careful, remember to check if the Sciternions library has already been loaded.
    //
    // Examples
    // clear()
    // load("Sciternions/build")
    // setup_sciternions(epsilon = 10e-6)
    // predef("all")
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    // Saves current context
    context = who("local")
    context($ + 1) = "context"

    // Overloads the function 'type'
    ptr = funptr("type")
    if ptr ~= 0 then
        newfun("_type", ptr)
        clearfun("type")
    end
    clear("ptr")

    // Aliases for boolean types
    %false = %f
    %true = %t

    // Aliases for types of variables
    %boolean = get_type(%true)
    %real = get_type(0)
    %complex = get_type(%i)
    %vector = get_type([0, 0])
    %matrix = get_type([0, 0 ; 0, 0])
    %hypermatrix = get_type(matrix([0, 0], 1, 1, 2))
    %euler = get_type(euler())
    %quat = get_type(quat())
    %quaternion = %quat
    %list = get_type(list())
    %string = get_type("")
    %type = get_type(%real)
    %function = get_type(setup_sciternions)

    // Aliases for the cartesian origin and each canonical axis
    %O = [0; 0; 0]
    %X = [1; 0; 0]
    %Y = [0; 1; 0]
    %Z = [0; 0; 1]

    // Aliases for the units associated with each imaginary part
    %1 = quat(1, [0; 0; 0])
    %I = quat(0, [1; 0; 0])
    %J = quat(0, [0; 1; 0])
    %K = quat(0, [0; 0; 1])

    // Aliases for common mathematical constants
    %2pi = 2 * %pi

    // Fastmode configuration (chosen at compilation time)
    if %fastmode then
        %fastmode = %true

        // Speedup aliases manually
        quaternion = quat
        rotation_quaternion = rquat
        rotation_quaternion_degrees = rquatd
        rotate_using_quaternion = rotateq
    else
        %fastmode = %false
    end

    // Sciternions configuration
    if exists('epsilon') then
        %epsilon = epsilon
        clear('epsilon')
    else
        %epsilon = 2 * %eps
    end

    // A very small value that still can be recognized by scilab as non-zero
    %superepsilon = %eps ** 20 * 0.0000000001

    // A very big value that still can be recognized by scilab as non-infinite
    %superomega = (1 / %eps) ** 19 * 10000000000

    // %fastmode = exists('fastmode') && fastmode // Deprecated, fastmode is implemented at compilation time

    // Adds the setup variables to the global context
    variables = strcat(setdiff(who("local"), context), ",")
    if length(variables) > 0 then
        execstr("[" + variables + "] = resume(" + variables + ")")
    end
endfunction
