function check_args(func, varargin)
    // Function argument checking.
    //
    // Syntax
    //   check_args(func, arg1, type1, ..., argn, typen)
    //
    // Parameters
    // func: string, the syntax of the function
    // argi: array, the i-th argument received by the function
    // typei: type array, the possible types of the i-th argument
    //
    // Description
    // Checks whether the types of the arguments of a function are valid, given a type checklist. For example, if you receive the error message "add(a, b, c): Argument checking failed for argument 2", it means the second argument 'b' of the function 'add' has an invalid type.
    //
    // Examples
    // function result = add_numbers(a, b)
    //     check_args("add_numbers(a, b)", a, [%real, %complex], b, [%real, %complex])
    //
    //     result = a + b
    // endfunction
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    n = length(varargin)
    if modulo(n, 2) ~= 0 then
        error(func + ": Invalid argument checking (missing an argument or a type).")
    end

    for i = 2:2:n do
        type1 = get_type(varargin(i - 1))
        types2 = varargin(i)

        if get_type(types2) ~= %list then
            types2 = list(types2)
        end

        failed = %t
        for type2 = types2 do
            if get_type(type2) ~= %type then
                error(func + ": Invalid type checking for argument " + string(i / 2) + " (invalid type).")
            end

            if type1 == type2 then
                failed = %f

                break
            end
        end

        if failed then
            try
                arg = strcat(strcat(string(varargin(i - 1)), ", ", "c"), "; ")
            catch
                if type1 == %function then
                    arg = "function"
                else
                    error(func + ": Invalid argument checking (unimplemented stringification for type " + string(type1) + ").")
                end
            end

            types = ""
            for ty = types2 do
                types = types + string(ty) + " or "
            end

            error(func + ": Argument checking failed for argument " + string(i / 2) + " -> [" + arg + "]. Type is " + string(type1) + ", but can be " + part(types, 1:$-4) + ".")
        end
    end
endfunction
