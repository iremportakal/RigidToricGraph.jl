module RigidToricGraph

using Oscar
using Oscar.Polymake
# Write your package code here.


function get_threefaces(HD, bad_flag)
    threefaceics = @Polymake.convert_to Array{Int} Polymake.graph.nodes_of_rank(HD, 3)
    threefaceics = Polymake.to_one_based_indexing(threefaceics)
    F = @Polymake.convert_to Array{Set{Int}} HD.FACES
    F = Polymake.to_one_based_indexing(F)
    threefaces = []
    for l in threefaceics
        tf = F[l]
        if !bad_flag &&length(tf)==3  # https://xkcd.com/927
            push!(threefaces, tf)
        elseif bad_flag && length(tf)>3
            push!(threefaces, tf)
        end
    end
    return threefaces
end

function get_twofaces(HD) 
    twofaceics = @Polymake.convert_to Array{Int} Polymake.graph.nodes_of_rank(HD, 2)
    twofaceics = Polymake.to_one_based_indexing(twofaceics)
    F = @Polymake.convert_to Array{Set{Int}} HD.FACES
    F = Polymake.to_one_based_indexing(F)
    twofaces = []
    for l in twofaceics
        tf = F[l]
        push!(twofaces, tf)
        end
    return twofaces
end


function crosscut_skeleton(Cdual, HD, Defdegree)
    skeleton = []
    good_faces = get_threefaces(HD, false)
    append!(good_faces, get_twofaces(HD))
    for gtf in good_faces
        is_good = true
        for r in gtf
            prod = dot(rays(Cdual)[r], Defdegree)
            if prod < 1
                is_good = false
                break
            end
        end
        if length(gtf) == 2
            if findfirst(s->issubset(gtf, s), skeleton) != nothing
                is_good = false
            end
        end
        if is_good
            push!(skeleton, gtf)
        end
    end
    return skeleton
end


export 
    crosscut_skeleton,
    get_threefaces,
    get_twofaces

end
