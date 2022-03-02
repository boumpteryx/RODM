include("building_tree.jl")
include("utilities.jl")
using LinearAlgebra

function fusion_points(X, Y, proportion)
  n = length(Y)
  m = n*proportion
  m ÷= 1
  for i in 1:m
    # trouver points d'indice a et b les plus proches de meme classe
    distance = 1
    a, b = 0, 0
    for k in 1:size(X, 1)
      for l in 1:size(X, 1)
        if Y[k] == Y[l] && k != l
          distance_provisoire = norm(X[k,:] - X[l,:]) # distance euclidienne
          if distance_provisoire < distance && distance_provisoire > 0
            distance = distance_provisoire
            a = k
            b = l
          end
        end
      end
    end
    # les fusionner dans X et dans Y
    X[a,:] = 0.5*(X[a,:] + X[b,:])
    # supprimer X[b] et Y[b]
    X = X[1:end .!= b,:]
    splice!(Y, b)
  end
  return X,Y
end

function main()

    # Pour chaque jeu de données
    for dataSetName in ["iris", "seeds", "wine", "haberman", "banknote"]

        print("=== Dataset ", dataSetName)

        # Préparation des données
        include("../data/" * dataSetName * ".txt")
        train, test = train_test_indexes(length(Y))
        X_train = X[train, :] # modifier X_train pour fusionner gamma pourcent des points de meme classe
        Y_train = Y[train] # idem sur Y_train
        X_train, Y_train = fusion_points(X_train, Y_train, 0.2)
        X_test = X[test, :] # mais pas sur les donnees de test !
        Y_test = Y[test]

        println(" (train size ", size(X_train, 1), ", test size ", size(X_test, 1), ", ", size(X_train, 2), ", features count: ", size(X_train, 2), ")")

        # Temps limite de la méthode de résolution en secondes
        time_limit = 30

        # Pour chaque profondeur considérée
        for D in 2:4

            println("  D = ", D)

            ## 1 - Univarié (séparation sur une seule variable à la fois)
            # Création de l'arbre
            print("    Univarié...  \t")
            T, obj, resolution_time, gap = build_tree(X_train, Y_train, D,  multivariate = false, time_limit = time_limit)

            # Test de la performance de l'arbre
            print(round(resolution_time, digits = 1), "s\t")
            print("gap ", round(gap, digits = 1), "%\t")
            if T != nothing
                print("Erreurs train/test ", prediction_errors(T,X_train,Y_train))
                print("/", prediction_errors(T,X_test,Y_test), "\t")
            end
            println()

            ## 2 - Multivarié
            print("    Multivarié...\t")
            T, obj, resolution_time, gap = build_tree(X_train, Y_train, D, multivariate = true, time_limit = time_limit)
            print(round(resolution_time, digits = 1), "s\t")
            print("gap ", round(gap, digits = 1), "%\t")
            if T != nothing
                print("Erreurs train/test ", prediction_errors(T,X_train,Y_train))
                print("/", prediction_errors(T,X_test,Y_test), "\t")
            end
            println("\n")
        end
    end
end
