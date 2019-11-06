function r = rotateq3d(x, q)
    // <latex>$\overrightarrow{Rot}(\vec{x}, q) \triangleq \overrightarrow{Im}(\bar{q} \circ (0, \vec{x}) \circ q)$</latex>

    r = rotate_using_quaternion(x, q)
endfunction
