using Random

function parse_instance_haberman(MyFileName::String)
  path = "../data/" * MyFileName
  # Si le fichier path existe
  if isfile(path)
    # L’ouvrir
    myFile = open(path)
    n = 306
    X = Array{Float64,2}(zeros(n,3))
    Y = Array{Int64,1}(zeros(n))
    for i in 1:n
      line =  split(readline(myFile), ",")
      Y[i] = parse(Int64,line[4])
      for j in 1:3
        X[i,j] = parse(Float64,line[j])
      end
    end
    # normalisation de X
    for i in 1:3
      X[:,i] .-= minimum(X[:,i])
      X[:,i] ./= maximum(X[:,i])
    end

    # ecriture du fichier correct
    fout = open("../data/haberman.txt", "w")
    println(fout, "X = ")
    println(fout, X)
    println(fout, "Y = ")
    println(fout, Y)
    close(fout)

  end

end

parse_instance_haberman("haberman.data")

function parse_instance_banknote(MyFileName::String)
  path = "../data/" * MyFileName
  # Si le fichier path existe
  if isfile(path)
    # L’ouvrir
    myFile = open(path)
    n = 1372
    X = Array{Float64,2}(zeros(n,4))
    Y = Array{Int64,1}(zeros(n))
    for i in 1:n
      line =  split(readline(myFile), ",")
      Y[i] = parse(Int64,line[5]) + 1
      for j in 1:4
        X[i,j] = parse(Float64,line[j])
      end
    end
    # normalisation de X
    for i in 1:4
      X[:,i] .-= minimum(X[:,i])
      X[:,i] ./= maximum(X[:,i])
    end

    # ecriture du fichier correct
    fout = open("../data/banknote.txt", "w")
    println(fout, "X = ")
    println(fout, X)
    println(fout, "Y = ")
    println(fout, Y)
    close(fout)
  end
end

parse_instance_banknote("data_banknote_authentication.txt")
