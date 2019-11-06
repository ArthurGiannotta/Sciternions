function t = time(instruction, n)
    // Instruction timing.
    //
    // Syntax
    //   t = time(instruction, n)
    //
    // Parameters
    // t: real, the CPU time taken to execute the instruction n times
    // instruction: string, the instruction to be executed
    // n: integer, the number of times to execute the instruction
    //
    // Description
    // This function evaluates the time taken by the CPU to execute an instruction a determinate number of times. The precision is at least 100 nanoseconds. CPU time is the number of processor cycles used for a computation. This is not equivalent to real-world time, but can be used to compare the time taken by two instructions.
    //
    // Examples
    // // Is it faster to execute 'sqrt(2)' or to do '2^0.5'?
    // time('sqrt(2)', 1000000) > time('2^0.5', 1000000) // Usually true, 2^0.5 should be faster
    //
    // See also
    //  timer
    //
    // Authors
    //  Arthur Clemente Giannotta ;

    check_args("time(instruction, n)", instruction, %string, n, %real)

    execstr('timer(); for i = 1:int(n) do ' + instruction + ' end; t = timer()')
endfunction
