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

    // Aliases for types of variables
    %real = get_type(0)
    %complex = get_type(%i)
    %vector = get_type([0, 0])
    %matrix = get_type([0, 0 ; 0, 0])
    %hypermatrix = get_type(matrix([0, 0], 1, 1, 2))
    %quat = get_type(quat())
    %quaternion = %quat
    %list = get_type(list())
    %string = get_type("")
    %type = get_type(%real)

    // Aliases for boolean types
    %false = %f
    %true = %t

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

    // %fastmode = exists('fastmode') && fastmode // Deprecated, fastmode is implemented at compilation time

    // Adds the setup variables to the global context
    variables = strcat(setdiff(who("local"), context), ",")
    if length(variables) > 0 then
        execstr("[" + variables + "] = resume(" + variables + ")")
    end
endfunction
