using Distances
using Random

"""
Représente une distance entre deux données identifiées par leur id
"""
mutable struct Distance

    distance::Float64
    ids::Vector{Int}

    function Distance()
        return new()
    end
end 

"""
Constructeur d'une distance

Entrées :
- id1 : id de la première donnée
- id2 : id de la seconde donnée
- x   : caractéristique des données d'entraînement
"""
function Distance(id1::Int, id2::Int, x::Matrix{Float64})

    d = Distance()
    d.distance = euclidean(x[id1, :], x[id2, :])
    d.ids = [id1, id2]

    return d
    
end


##### Norme 1

# function Distance(id1::Int, id2::Int, x::Matrix{Float64})

#     d = Distance()
#     d.distance = sum(abs(x[id1,i] -x[id2,i]) for i in 1:size(x)[2])
#     d.ids = [id1,id2]

#     return d

# end

##### Norme infinie

# function Distance(id1::Int, id2::Int, x::Matrix{Float64})

#     d = Distance()
#     d.distance = max(abs(x[id1,i] -x[id2,i]) for i in 1:size(x)[2])
#     d.ids = [id1,id2]

#     return d

# end

##### Pseudo-norme min

# function Distance(id1::Int, id2::Int, x::Matrix{Float64})

#     d = Distance()
#     d.distance = min(abs(x[id1,i] -x[id2,i]) for i in 1:size(x)[2])
#     d.ids = [id1,id2]

#     return d

# end

##### Norme 2 perturbée

# function Distance(id1::Int, id2::Int, x::Matrix{Float64})

#     d = Distance()
#     acc = euclidean(x[id1, :], x[id2, :])
#     d.distance = acc * (0.6 + 0.4*rand())
#     d.ids = [id1,id2]

#     return d

# end