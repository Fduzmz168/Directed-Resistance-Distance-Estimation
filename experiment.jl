include("algErEst.jl")
include("realDataHelper.jl")
include("utils.jl")

name::String
p::Int
length::Int

createLgzFromOriginFile(name)
comptSD(name)
generateRandomQuery(name)

G = loadgraph(string(name, ".lgz"))
ϕ = load_object(string(name, "SD.jld2"))
pairs = load_object(string(name, "Pair.jld2"))

d = outdegree(G)
A = adjacency_matrix(G)
Dinv = spdiagm(1 ./ d)
P = Dinv*A
Φ = spdiagm(ϕ)
L = Φ * (sparse(I,n,n) - P)

t1 = time()
Lpinv = pinv(Matrix(L))
t2 = time()
println("Running time of Exact on", name, ": ", t2 - t1)

e = zeros(nv(G))
runtime = Float64[]
error = Float64[]
for (i, k) in enumerate(pairs)
    e[k[1]]=1; e[k[2]]=-1
    r_acu = e' * Lpinv * e;
    t1 = time()
    r_est = ErEstDi(G, k[1], k[2], p, length, ϕ)
    t2 = time()
    append!(runtime, t2-t1)
    append!(error, abs(r_acu-r_est)/abs(r_acu))
    e[k[1]] = 0; e[k[2]] = 0
end

jldsave(string(name, "Time.jld2"); runtime)
jldsave(string(name, "Error.jld2"); error)

println("Complete.")
