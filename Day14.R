input = c("O....#....",
"O.OO#....#",
".....##...",
"OO.#O....O",
".O.....O#.",
"O.#..O.#.#",
"..O..#O..O",
".......O..",
"#....###..",
"#OO..#....")

input = readLines("Day14Input.txt")

rocks = matrix(NA,nrow=length(input),
               ncol = str_length(input[1]))
for(i in 1:length(input)){
  rocks[i,] = str_split(input[[i]],"")[[1]]
}

northRocks = matrix(".",
                    nrow = nrow(rocks),
                    ncol = ncol(rocks))
for(c in 1:ncol(rocks)){
  square = 0
  round = 0
  for(r in 1:nrow(rocks)){
    val = rocks[r,c]
    if(val == "O"){
      round = round + 1
    } else if (val == "#"){
      if(round > 0){
        for(i in 1:round){
          northRocks[square+i,c] = "O"
        }
      }
        northRocks[r,c] = "#"
        square = r
        round = 0
    }
    if(r == nrow(rocks)){
      if(round > 0){
        for(i in 1:round){
          northRocks[square+i,c] = "O"
        }
      }
    }
  }
}

ans1 = 0
for(r in 1:nrow(northRocks)){
  m = nrow(northRocks) - r + 1
  nround = sum(northRocks[r,]=="O")
  ans1 = ans1 + m*nround
}

# NWSE 
squares = rocks
squares[squares=="O"] = "."

north = function(rocks,squares){
  rocksOut = squares
  for(c in 1:ncol(rocks)){
  square = 0
  round = 0
  for(r in 1:nrow(rocks)){
    val = rocks[r,c]
    if(val == "O"){
      round = round + 1
    } else if (val == "#"){
      if(round > 0){
        for(i in 1:round){
          rocksOut[square+i,c] = "O"
        }
      }
#      rocksOut[r,c] = "#"
      square = r
      round = 0
    }
    if(r == nrow(rocks)){
      if(round > 0){
        for(i in 1:round){
          rocksOut[square+i,c] = "O"
        }
      }
    }
  }
  }
  rocksOut
}

south = function(rocks,squares){
  rocksOut = squares
  for(c in 1:ncol(rocks)){
    square = nrow(rocks)+1
    round = 0
    for(r in nrow(rocks):1){
      val = rocks[r,c]
      if(val == "O"){
        round = round + 1
      } else if (val == "#"){
        if(round > 0){
          for(i in 1:round){
            rocksOut[square-i,c] = "O"
          }
        }
        #      rocksOut[r,c] = "#"
        square = r
        round = 0
      }
      if(r == 1){
        if(round > 0){
          for(i in 1:round){
            rocksOut[square-i,c] = "O"
          }
        }
      }
    }
  }
  rocksOut
}

west = function(rocks,squares){
  rocksOut = squares
  for(r in 1:nrow(rocks)){
    square = 0
    round = 0
    for(c in 1:ncol(rocks)){
      val = rocks[r,c]
      if(val == "O"){
        round = round + 1
      } else if (val == "#"){
        if(round > 0){
          for(i in 1:round){
            rocksOut[r,square+i] = "O"
          }
        }
        #      rocksOut[r,c] = "#"
        square = c
        round = 0
      }
      if(c == ncol(rocks)){
        if(round > 0){
          for(i in 1:round){
            rocksOut[r,square+i] = "O"
          }
        }
      }
    }
  }
  rocksOut
}

east = function(rocks,squares){
  rocksOut = squares
  for(r in 1:nrow(rocks)){
    square = ncol(rocks)+1
    round = 0
    for(c in ncol(rocks):1){
      val = rocks[r,c]
      if(val == "O"){
        round = round + 1
      } else if (val == "#"){
        if(round > 0){
          for(i in 1:round){
            rocksOut[r,square-i] = "O"
          }
        }
        #      rocksOut[r,c] = "#"
        square = c
        round = 0
      }
      if(c == 1){
        if(round > 0){
          for(i in 1:round){
            rocksOut[r,square-i] = "O"
          }
        }
      }
    }
  }
  rocksOut
}



rocksIn = rocks
rocksEnd = NA
maps = c()
mapInd = 0

for(i in 1:1e9){
  print(i)
  n = north(rocksIn,squares)
  w = west(n,squares)
  s = south(w,squares)
  rocksIn = east(s,squares)
  map = toString(rocksIn)
  if(map %in% maps){
    mapInd = which(maps == map)
    print(paste0("Same after ",i," loops. Matches number ",mapInd))
    rocksEnd = rocksIn
    break
  }
  maps = append(maps,map)
}

loopSize = i - mapInd
remain = (1e9-mapInd) %% loopSize
e = rocksEnd

for(i in 1:remain){
  n = north(e,squares)
  w = west(n,squares)
  s = south(w,squares)
  e = east(s,squares)
}

rocksFinal = e
ans2 = 0

for(r in 1:nrow(rocksFinal)){
  m = nrow(rocksFinal) - r + 1
  nround = sum(rocksFinal[r,]=="O")
  ans2 = ans2 + m*nround
}
