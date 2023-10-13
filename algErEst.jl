using LinearAlgebra
using Graphs

function ErEstDi(G::SimpleDiGraph, s::Int, t::Int, p::Int, len::Int, ϕ::Vector)
    res::Float64 = 0
    for i = 0 : len - 1
        xs = 0; xt = 0; ys = 0; yt = 0
        for j = 1 : p
            xx = s
            yy = t
            for ll = 1 : i
                nx = rand(outneighbors(G, xx))
                xx = nx 
            end
            for ll = 1 : i
                ny = rand(outneighbors(G, yy))
                yy = ny 
            end
            xs = xs + (xx==s)
            xt = xt + (xx==t)
            ys = ys + (yy==s)
            yt = yt + (yy==t)
        end
        res = res + (xs/ϕ[s] - xt/ϕ[t] - ys/ϕ[s] + yt/ϕ[t])/p
    end
    return res
end

            
