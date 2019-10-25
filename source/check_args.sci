function check_args(func, varargin)
    // Function argument checking.
    //
    // Syntax
    //   check_args(func, arg1, type1, ..., argn, typen)
    //
    // Parameters
    // func: string, the syntax of the function
    // argi: array, the i-th argument received by the function
    // typei: type array, the type that the i-th argument should be of
    //
    // Description
    // Checks whether the types of the arguments of a function are valid, given a type checklist. For example, if you receive the error message "add(a, b, c): Argument checking failed for argument 2", it means the second argument 'b' of the function 'add' has an invalid type.
    //
    // Examples
    // function result = add_reals(a, b)
    //     check_args("add_numbers(a, b)", a, %real, b, %real)
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
        type2 = varargin(i)

        if get_type(type2) ~= %type then
            error(func + ": Invalid checking for argument " + string(i / 2) + " (invalid type).")
        end

        if type1 ~= type2 then
            error(func + ": Argument checking failed for argument " + string(i / 2) + ". Type is " + string(type1) + ", but should be " + string(type2) + ".")
        end
    end
endfunction
