using Peridynamics
using Test
using SafeTestsets

@testset "Peridynamics" begin

    @safetestset "Discretization" begin
        include("discretization.jl")
    end

end
