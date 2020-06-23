function animate_top(S, anim, sim, duration, fps, view)
    // references -> simulate_rotation, top, draw_top
    // Generates a sequence of images that together will compose an animation

    // Default argument "view = []"
    if ~exists("view", "local") then
        L = max(max(S.crossX), max(S.crossZ))
        view = [-L, -L, 0, L, L, 2*L]
    end

    for t = sim.t
        drawlater();

        clf();

        q = spinning_top.rot
        r = rotateq([0,0,1], q).imag'
        //T = m * g * r

        spinning_top.rot = q

        draw_top(spinning_top)
        //disp()
        //display(r)

        xlabel("X", "fontsize", 5)
        ylabel("Y", "fontsize", 5)
        zlabel("Z", "fontsize", 5)
        gca().font_size = 4
        replot(View)
        //gca().rotation_angles(2) = gca().rotation_angles(2) + 180

        drawnow();

        xs2png(gcf(), msprintf(anim_temp + "img%04d.png", i))

        // Deprecated usage of ImageMagick to generate the animation
        //xs2gif(gcf(), msprintf(anim_temp + "img%04d.gif", i));
    end

    // Converts the sequence of images of the animation into a video
    ffmpeg = ""
    if unix(ffmpeg) == 1 then // No error

    else
        if getos() == 'Windows' then
        //ffmpeg -r 1/5 -i img%03d.png -c:v libx264 -vf "fps=25,format=yuv420p" out.mp4
        // "e:\ffmpeg\ffmpeg.exe" -r 1/5 -start_number 0 -i "E:\images\01\padlock%3d.png" -c:v libx264 -vf "fps=25,format=yuv420p" e:\out.mp4

        // Deprecated usage of ImageMagick to generate the animation
        //delay = 0 // Time delay between the animation frames in 1/100th of a second
        //unix("./magick convert -delay " + string(delay) + " -loop 0 " + anim_temp + "img*.gif " + anim_file + ".gif")
        else
            error("animeatotop: sudo apt install ffmpeg")
        end
    end

    close()
endfunction
