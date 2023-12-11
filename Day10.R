
input = readLines("Day10Input.txt")
# Turns it into a list of arrays, should work just as well as a matrix
map = str_split(input,"")

letToDir = function(map = map){
  dirs <<- matrix(nrow = length(map),
                  ncol = length(map[[1]]))
  y = 0
  for(line in map){
    y = y + 1
    x = 0
    for(elem in line){
      x = x + 1
      dir = case_when(
        elem == '|' ~ "UD",
        elem == '-' ~ "LR",
        elem == 'L' ~ "UR",
        elem == 'J' ~ "UL",
        elem == '7' ~ "DL",
        elem == 'F' ~ "DR",
        elem == 'S' ~ "S",
        T ~ '.'
      )
      dirs[x,y] <<- dir
      if(elem == 'S'){strtInd <<- c(x,y)}
    }
  }
}

findConnect = function(strt = strtInd){
  conns = vector(mode='list',length = 2)
  x = strt[1]
  y = strt[2]
  touches = rbind(
    # Coordinates of adjacent, and the direction that sends pipe to start.
    # 4th is the directio we'd 'hit' index from if starting at S
    c(x-1,y,"R","L"),
    c(x+1,y,"L","R"),
    c(x,y-1,"U","D"),
    c(x,y+1,"D","U"))
  for(i in nrow(touches)){
    touch = touches[i,]
    if(grepl(touch[3],
             dirs[as.numeric(touch[1]),
                  as.numeric(touch[2])])){
      strtAt <<- c(touch[1],touch[2],touch[4])
      break
    }
  }
}

followPath = function(strt = strt){
  atS = F
  x = as.numeric(strt[1])
  y = as.numeric(strt[2])
  pth <<- c(x,y)
  dirFrom = strt[3]
  while(!atS){
    locDirs = dirs[x,y]
    if(locDirs == "S"){break}
    nextStep = sub(dirFrom,"",locDirs)
    if(nextStep == "D"){
      y = y + 1
      dirFrom = "U"
    } else if(nextStep == "U"){
      y = y - 1
      dirFrom = "D"
    } else if(nextStep == "L"){
      x = x - 1
      dirFrom = "R"
    } else if(nextStep == "R"){
      x = x + 1
      dirFrom = "L"
    } else {
      print("Got to ",x,", ",y,". Shouldn't be here...")
    }
    pth <<- rbind(pth,c(x,y))
  }
}

# Map strings to directions and save S location to strtInd
letToDir(map)

# Find what S connects to. Saves first step as strtAt
findConnect(strtInd)

# Follow a path, and save the path taken to 'pth'
followPath(strtAt)

print(paste0("Part 1: ",nrow(pth)/2))
