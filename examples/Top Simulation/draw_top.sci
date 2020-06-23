function draw_top(S)
    //  Arthur Clemente Giannotta ;

    // Generates the spinning top surface from the polygonal base

    [X, Y, Z] = (S.X, S.Y, S.Z)
    s = size(S.X)
    //

    for i = 1:s(1)
        for j = 1:s(2) do
            vec = rotateq3d([X(i, j); Y(i, j); Z(i, j)] + S.O, S.q)
            [X(i, j), Y(i, j), Z(i, j)] = (vec(1), vec(2), vec(3))
        end
    end

    surf(X, Y, Z, 0 * X + color("red"))
endfunction
