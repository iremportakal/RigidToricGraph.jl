module RigidToricGraph

# Write your package code here.


function get_threefaces(HD, bad_flag)
    threefaceics = @Polymake.convert_to Array{Int} Polymake.graph.nodes_of_rank(HD, 3)
    threefaceics = Polymake.to_one_based_indexing(threefaceics)
    F = @Polymake.convert_to Array{Set{Int}} HD.FACES
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
    twofaces = []
    for l in twofaceics
        tf = F[l]
        push!(twofaces, tf)
        end
    return twofaces
end


export get_threefaces,
    get_twofaces

end
