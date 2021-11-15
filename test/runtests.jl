using RigidToricGraph
using Test


@testset "RigidToricGraph.jl" begin
    # Write your tests here.
    
    using Oscar

    A = [1 0 0 0 0 0 1 0;1 0 0 0 0 0 0 1;0 1 0 0 1 0 0 0; 0 1 0 0 0 1 0 0;0 1 0 0 0 0 1 0;0 1 0 0 0 0 0 1;0 0 1 0 1 0 0 0; 0 0 1 0 0 1 0 0;0 0 1 0 0 0 1 0;0 0 1 0 0 0 0 1;0 0 0 1 1 0 0 0; 0 0 0 1 0 1 0 0;0 0 0 1 0 0 1 0;0 0 0 1 0 0 0 1]
    C = positive_hull(A)
    Cdual = polarize(C)
    HD = Cdual.pm_cone.HASSE_DIAGRAM
    @test length(get_twofaces(HD)) == 34
    @test length(get_threefaces(HD, false)) == 68

    def_degree = [1,0,1,0,-2,1,0,3]    
    cs = crosscut_skeleton(Cdual, HD, def_degree)
    @test cs == map(x->Set(x), [[2,4,7],[2,4,8],[2,4,9],[2,7,8],[2,8,9],[4,7,8],[4,8,9]])
end
