using Graphs
using KrylovKit
using SparseArrays
using LinearAlgebra
using JLD2
using StatsBase

function comptSD(name)
    g = loadgraph(string(name, ".lgz"))
    n = nv(g)
    A = adjacency_matrix(g)
    d = outdegree(g)
    P = spdiagm(1 ./ d) * A
    _, ϕ, _ = eigsolve(P', 1, :LM; maxiter=1000)
    ϕ = ϕ[1]
    ϕ = normalize(real(ϕ))
    if ϕ[1] < 0
        ϕ = -ϕ
    end
    jldsave(string(fileName, "SD.jld2"); ϕ)
end

function generateRandomQuery(name)
    g = loadgraph(string(name, ".lgz"))
    ϕ = load_object(string(name, "SD.jld2"))
    p = Tuple{Int64, Int64}[]
    m = ne(g)
    for i = 1:1000
        node_pair = samplepair(nv(g))
        push!(p, node_pair)
    end
    jldsave(string(name, "Pair.jld2"); p)
end
