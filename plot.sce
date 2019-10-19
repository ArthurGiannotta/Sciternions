// Transforma o gráfico plotado em um gráfico de tela cheia
function make_fullscreen()
    f = get("current_figure");
    f.figure_position = [-8,-8];
    f.figure_size = [1936,1056]; 
endfunction

// Realiza a plotagem de vetores no espaço 2D ou 3D.
// Não é nada mais do que um atalho para a função 'xarrows' do SciLab.
function draw_vectors(nx, ny, nz, arsize, color)
    xarrows(nx, ny, nz, arsize, color)
endfunction
