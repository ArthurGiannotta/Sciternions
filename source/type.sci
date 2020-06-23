function [ty, subty] = type(variable)
    // Overloaded version of the Scilab 'type' function.
    //
    // Syntax
    //   [ty, subty] = type(variable)
    //
    // Parameters
    // ty: integer, the type of the variable
    // subty: integer, the subtype of the variable
    // variable: any, the variable to have its type and subtype evaluated
    //
    // Description
    // This function is used to also get the subtype of a given type. For example, a variable which has its original 'type' evaluated to 1 can either be of the subtype 0(real), 1(complex), 2(vector), 3(matrix) or 4(hypermatrix). Any typed list will have its subtype equal to the type name.
    //
    // Examples
    // ty = type(1) // ty = 1
    // [ty, subty] = type(1) // ty = 1, subty = 0
    // [ty, subty] = type(1 + %i) // ty = 1, subty = 1
    // [ty, subty] = type([1, 0]]) // ty = 1, subty = 2
    // [ty, subty] = type([1; 0]]) // ty = 1, subty = 2
    // [ty, subty] = type([1, 0; 0, 1]]) // ty = 1, subty = 3
    //
    // See also
    //  type
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    ty = _type(variable)

    select ty
    case _type(0) then
        if length(variable) == 1 then
            if imag(variable) == 0 then
                subty = 0 // real
            else
                subty = 1 // complex
            end
        else
            s = size(variable)

            if length(s) == 2 then
                if s(1) == 1 || s(2) == 1 then
                    subty = 2 // vector
                else
                    subty = 3 // matrix
                end
            else
                subty = 4 // hypermatrix
            end
        end
    case _type(tlist([""])) then
        subty = typeof(variable)
    else
        subty = 0
    end
endfunction
