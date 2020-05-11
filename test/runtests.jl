using Peridynamics
using Test

@testset "Peridynamics" begin

    @testset "Discretization" begin
        include("discretization.jl")
    end

end
