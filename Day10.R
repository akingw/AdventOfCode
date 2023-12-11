
input = readLines("Day10Input.txt")
# Turns it into a list of arrays, should work just as well as a matrix
map = str_split(input,"")

letToDir = function(map = map){
  dirs <<- matrix(nrow = length(map),
                  ncol = length(map[[1]]))
  r = 0
  for(line in map){
    r = r + 1
    c = 0
    for(elem in line){
      c = c + 1
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
      dirs[r,c] <<- dir
      if(elem == 'S'){strtInd <<- c(r,c)}
    }
  }
}

findConnect = function(strt = strtInd){
  conns = vector(mode='list',length = 2)
  r = strt[1]
  c = strt[2]
  touches = rbind(
    # Coordinates of adjacent, and the direction that sends pipe to start.
    # 4th is the directio we'd 'hit' index from if starting at S
    c(r,c-1,"R","L"),
    c(r,c+1,"L","R"),
    c(r-1,c,"U","D"),
    c(r+1,c,"D","U"))
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
  r = as.numeric(strt[1])
  c = as.numeric(strt[2])
  pth <<- c(r,c)
  dirFrom = strt[3]
  while(!atS){
    locDirs = dirs[r,c]
    if(locDirs == "S"){break}
    nextStep = sub(dirFrom,"",locDirs)
    if(nextStep == "D"){
      r = r + 1
      dirFrom = "U"
    } else if(nextStep == "U"){
      r = r - 1
      dirFrom = "D"
    } else if(nextStep == "L"){
      c = c - 1
      dirFrom = "R"
    } else if(nextStep == "R"){
      c = c + 1
      dirFrom = "L"
    } else {
      print(paste0("Got to ",c,", ",r,". Shouldn't be here..."))
    }
    pth <<- rbind(pth,c(r,c))
  }
}

findWithin = function(pth = pth){
  inPth <<- 0
  # first remove non-path elements
  pthOnly <<- matrix(data = ".",
                   nrow = nrow(dirs),
                   ncol = ncol(dirs))
  for(i in 1:nrow(pth)){
    r = pth[i,1]
    c = pth[i,2]
    pthOnly[r,c] <<- dirs[r,c]
    if(pthOnly[r,c] == "S"){
      pthOnly[r,c] = "UD"
    }
  }
  inRow <<- matrix(data=0,nrow=140,ncol = 1)
  for(r in 1:nrow(pthOnly)){
    # Reset at start of each row, can't start inside.
    nCross = 0
    goUp = F
    goDn = F
    rowNum = 0
    line = pthOnly[r,]
    for(c in 1:length(line)){
      elem = line[c]
      if(elem == "UD"){
        nCross = nCross + 1
      } else if(grepl("U",elem)){
        if(goUp){
          goUp = F
        } else {
          goUp = T
        }
      } else if(grepl("D",elem)){
        if(goDn){
          goDn = F
        } else {
          goDn = T
        }
      }
      if(goDn & goUp){
        nCross = nCross + 1
        goDn = F
        goUp = F
      }
      if(elem == "."){
        if((nCross %% 2) == 1){
          inPth <<- inPth + 1
          rowNum = rowNum + 1
        }
      }
    }
    inRow[r,1] <<- rowNum
  }
}

# Map strings to directions and save S location to strtInd
letToDir(map)

# Find what S connects to. Saves first step as strtAt
findConnect(strtInd)

# Follow a path, and save the path taken to 'pth'
followPath(strtAt)

print(paste0("Part 1: ",nrow(pth)/2))

# Part 2.
# Scan across the whole area, and detect when we cross the path
# can tell if in or outside of path based on number of crosses.
findWithin(pth)

## Comenting out some troubleshooting I had to do
## Issue ended up being that I didn't handle "S", so offset the number of 
## times crosing.
## prntPth = matrix(data = ".",
##                 nrow = 140,
##                 ncol = 140)

## for(r in 1:nrow(pthOnly)){
  line = pthOnly[r,]
  for(c in 1:length(line)){
    elem = pthOnly[r,c]
    prnt = case_when(
      elem == "UD" ~ "|",
      elem == "UR" ~ "L",
      elem == "UL" ~ "J",
      elem == "DR" ~ "F",
      elem == "DL" ~ "7",
      elem == "LR" ~ "-",
      elem == "S" ~ "S",
      T ~ ".")
    prntPth[r,c] = prnt
  }
}
## l2 = ""
## for(i in 1:nrow(prntPth)){
  l1 = paste0(prntPth[i,],collapse="")
  l2 = paste0(l2,"\n",l1,": ",inRow[i,1])
}
## writeLines(l2,"Day10Within.txt")

print(paste0("Part 2: ",inPth))

#589 Too high
#1787 too