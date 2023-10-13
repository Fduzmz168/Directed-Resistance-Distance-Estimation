# Directed-Resistance-Distance-Estimation
This is the code for the paper "Fast Algorithm for Resistance Distances in Directed Graphs."
* realDataHelper.jl: The file contains functions `readRealData` and `createLgzFromOriginFile`, which are designed to read data to construct a directed graph and to extract the largest strongly connected component from the directed graph.
* utils.jl: The file includes the functions `comptSD` and `generateRandomQuery`, which are tasked with computing the stationary distribution of a strongly connected graph and generating random pairs of nodes, respectively.
* algErEst.jl: The file contains the function `ErEstDi`, which implements the algorithm **EREST**.
* experiment.jl: This file conducts experiments on the data file specified by "name", obtaining both error and algorithm runtime.
