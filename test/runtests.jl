# Copyright 2015, 2016, 2017, 2018 Martin Holters
# See accompanying license file.

include("checklic.jl")

using ACME
using Compat: argmin, range
import Compat.Test
using Compat.Test: @test, @test_broken, @test_throws, @test_warn, @testset
using ProgressMeter
using Compat.SparseArrays: sparse, spzeros

@testset "topomat" begin
    tv, ti = ACME.topomat(sparse([1 -1 1; -1 1 -1]))
    @test tv*ti'==spzeros(2,1)

    # Pathological cases for topomat:
    # two nodes, one loop branch (short-circuited) -> voltage==0, current arbitrary
    @test ACME.topomat(spzeros(Int, 2, 1)) == (hcat([1]), spzeros(0, 1))
    # two nodes, one branch between them -> voltage arbitrary, current==0
    @test ACME.topomat(sparse([1,2], [1,1], [1,-1])) == (spzeros(0, 1), hcat([1]))
end
