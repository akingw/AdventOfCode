input = readLines("Day11Input.txt")

#input = c("...#......",
#          ".......#..",
#          "#.........",
#          "..........",
#          "......#...",
#          ".#........",
#          ".........#",
#          "..........",
#          ".......#..",
#          "#...#.....")

nr = length(input)
nc = str_length(input[[1]])
colGalCount = rep(0,nc)
emptyRows = c()

img = matrix(data = "",
             nrow = nr,
             ncol = nc)

for(r in 1:nr){
  line = input[r]
  emptyRow = T
  for(c in 1:nc){
    pixel = str_split(line,"")[[1]][c]
    img[r,c] = pixel
    if(pixel == "#"){
      colGalCount[c] = colGalCount[c] + 1
      emptyRow = F
    }
  }
  if(emptyRow){
    emptyRows = append(emptyRows,r)
  }
}
emptyCols = which(colGalCount == 0)


galaxies = c()
for(r in 1:nrow(img)){
  for(c in 1:ncol(img)){
    pixel = img[r,c]
    if(pixel == "#"){
      galaxies = rbind(galaxies,
                       c(r,c))
    }
  }
}

totalDist = 0
totalDist2 = 0
for(r in 1:(nrow(galaxies)-1)){
  origin = galaxies[r,]
  for(r2 in (r+1):nrow(galaxies)){
    dest = galaxies[r2,]
    row_path = c(origin[1]:dest[1])
    rowAdd = sum(emptyRows %in% row_path)
    col_path = c(origin[2]:dest[2])
    colAdd = sum(emptyCols %in% col_path)
    dist = length(col_path) + length(row_path) + rowAdd + colAdd - 2
    dist2 = length(col_path) + length(row_path) + 
      rowAdd*1000000 + colAdd*1000000 - 2 - rowAdd - colAdd
    totalDist = totalDist + dist
    totalDist2 = totalDist2 + dist2
  }
}

print(paste0("Part 1: ",totalDist))
print(paste0("Part 2: ",totalDist2))

# 746962844814 Too high...
