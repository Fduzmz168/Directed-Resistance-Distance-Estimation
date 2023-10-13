using Graphs

function readRealData(fileName)
    Label = Dict{Int32, Int32}()
    Origin = Dict{Int32, Int32}()
    n = 0
    getID(x :: Int) = haskey(Label, x) ? Label[x] : Label[x] = n += 1
    g = SimpleDiGraph(0)
    filetype = split(fileName, '.')
    splitChar = '\t'
    if filetype[end] == "csv"
        splitChar = ','
    end
    open(fileName) do io
        str = readline(io)
        while !eof(io)
            str = readline(io)
            str = split(str, splitChar)
            x = parse(Int, str[1])
            y = parse(Int, str[2])
            if x!=y
                u = getID(x)
                v = getID(y)
                count = max(u, v)
                if (count > nv(g))
                    add_vertices!(g, count - nv(g))
                end
                if (!add_edge!(g, u, v) && !has_edge(g, u, v)) 
                    println("Error: add edge (", u, ",", v, ") failed")
                end
            end
        end
    end
    components = strongly_connected_components(g)
    lcc_v = components[argmax([length(c) for c in components])]
    lcc, _ = induced_subgraph(g, lcc_v)
    return lcc
end

function createLgzFromOriginFile(fileName)
    g = read_real_data(fileName)
    savegraph(string(fileName, ".lgz"), g)
end


