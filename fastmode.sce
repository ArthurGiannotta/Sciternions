// This script applies the Sciternions fastmode when compiling the library
// Fastmode eliminates argument checking and make optimization changes

if ~exists("build_dir") || ~exists("source_dir") || ~exists("fastmode") then
    error("The file ""fastmode.sce"" cannot be executed manually. Please run ""build.sce"" to compile the Sciternions library.")
end

scripts = listfiles(source_dir)'

for script = build_dir + scripts do
    script_file = mopen(script, "r")
    content = mgetl(script_file)'
    fast_content = []

    tabulation = []
    for i = 1:prod(size(content)) do
        line = content(i)

        if tabulation then
            if line == slower then
                if expr1 then
                    should_write = ~fastmode
                else
                    should_write = fastmode
                end
            elseif line == ender then
                tabulation = []
            elseif should_write then
                fast_content($+1) = part(line, 5:$)
            end
        else
            expr1 = strindex(line, "if %fastmode")
            expr2 = strindex(line, "if ~%fastmode")
            
            tabulation = [expr1, expr2]
            if tabulation then
                if tabulation > 1 then
                    tab = strcat(repmat(" ", tabulation - 1, 1))
                else
                    tab = ""
                end

                slower = tab + "else"
                ender = tab + "end"

                if expr1 then
                    should_write = fastmode
                else
                    should_write = ~fastmode
                end
            else
                fast_content($+1) = line
            end
        end
    end

    mclose(script_file)

    deletefile(script)
    write(script, fast_content)
end

clear("scripts", "script", "script_file", "content", "fast_content", "expr1", "expr2", "tabulation", "i", "line", "tab", "slower", "ender", "should_write")
