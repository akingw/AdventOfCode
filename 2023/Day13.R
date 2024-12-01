# ash is .
# rocks are #

input = c("#.##..##.",
"..#.##.#.",
"##......#",
"##......#",
"..#.##.#.",
"..##..##.",
"#.#.##.#.",
"",
"#...##..#",
"#....#..#",
"..##..###",
"#####.##.",
"#####.##.",
"..##..###",
"#....#..#",
"")

input = readLines("Day13Input.txt")

# sum left of vertical plus 100*above horizontal

checkV1 = function(group,nOff = 0,
                   possibleC = 1:(ncol(group)-1)){
 # print(possibleC)
  nc = ncol(group)
  nr = nrow(group)
  #possibleC = 1:(nc-1)
  for(c in 1:(nc-1)){
    if(!(c %in% possibleC)){next}
    if(c-nOff < 1 | c+nOff > (nc-1)){next}
    #print(paste0("checking column ",c," with offset of ",nOff))
    for(r in 1:nr){
      if(group[r,(c-nOff)] != group[r,(c+1+nOff)]){
     #   print(paste0("Eliminating ",c," at row ",r," because ",group[r,(c-nOff)],
    #                 "!=",group[r,(c+1+nOff)]))
        possibleC = setdiff(possibleC,c)
        break
      }
    }
  }
  if(length(possibleC) != 0 & nOff <= (floor(nc/2)-1)){
    #print(possibleC)
    possibleC = checkV1(group,nOff+1,possibleC)
    #print(possibleC)
  }
  #print(paste0("I'm returning ",possibleC))
  possibleC
}

checkH1 = function(group,nOff = 0,
                   possibleR = 1:(nrow(group)-1)){
  nc = ncol(group)
  nr = nrow(group)
  #possibleR = 1:(nr-1)
  for(r in 1:(nr-1)){
    if(!(r %in% possibleR)){next}
    if(r-nOff < 1 | r+nOff > (nr-1)){next}
    #print(paste0("checking row ",r," with offset of ",nOff))
    for(c in 1:nc){
      if(group[(r-nOff),c] != group[(r+1+nOff),c]){
        possibleR = setdiff(possibleR,r)
        break
      }
    }
  }
  if(length(possibleR) != 0 & nOff <= (floor(nr/2)-1)){
    possibleR = checkH1(group,nOff+1,possibleR)
  }
  possibleR
}

checkH2 = function(group,nOff = 0,
                   possibleR = 1:(nrow(group)-1)){
  nc = ncol(group)
  nr = nrow(group)
  #possibleR = 1:(nr-1)
  for(r in 1:(nr-1)){
    if(!(r %in% possibleR)){next}
    if(r-nOff < 1 | r+nOff > (nr-1)){next}
    #print(paste0("checking row ",r," with offset of ",nOff))
    for(c in 1:nc){
      if(group[(r-nOff),c] != group[(r+1+nOff),c]){
       #print('here')
        offBy <<- offBy %>% add_row(
          "HV" = "H",
          "mirrorAt" = r,
          "nOff" = nOff)
      }
    }
  }
}

checkV2 = function(group,nOff = 0,
                   possibleC = 1:(ncol(group)-1)){
  # print(possibleC)
  nc = ncol(group)
  nr = nrow(group)
  #possibleC = 1:(nc-1)
  for(c in 1:(nc-1)){
    if(!(c %in% possibleC)){next}
    if(c-nOff < 1 | c+nOff > (nc-1)){next}
    #print(paste0("checking column ",c," with offset of ",nOff))
    for(r in 1:nr){
      if(group[r,(c-nOff)] != group[r,(c+1+nOff)]){
        offBy <<- offBy %>% add_row(
          "HV" = "V",
          "mirrorAt" = c,
          "nOff" = nOff)
      }
    }
  }
}  

ngrps = sum(grepl("^[[:blank:]]*$",input))+1
groups = vector(mode = 'list', length = ngrps)
j = 1
grp = c()
for(i in 1:length(input)){
  lineArr = str_split(input[[i]],"")[[1]]
  if(length(lineArr)>0){
    grp = rbind(grp,lineArr)
  } else {
    groups[[j]] = unname(grp)
    grp = c()
    j = j + 1
  }
  if(i == length(input)){
    groups[[j]] = unname(grp)
  }
}

ans1 = 0
for(grp in groups){
  v = checkV1(grp)
  if(length(v)>0){ans1 = ans1 + v}
  h = checkH1(grp)
  if(length(h)>0){ans1 = ans1 + 100*h}
}

print(paste0("Part 1: ",ans1))
# 33047

ans2 = 0
z = 0
for(grp in groups){
  z = z + 1
  print(paste0("Group ",z))
  offBy = tibble(
    "HV" = character(),
    "mirrorAt" = numeric(),
    "nOff" = numeric())
  for(i in 0:(nrow(grp)/2)){
    checkH2(grp,i)
  }
  for(i in 0:(ncol(grp)/2)){
    checkV2(grp,i)
  }
  smudge = offBy %>%
    group_by(HV,mirrorAt) %>% 
    mutate(n=n()) %>% 
    filter(n == 1)
  if(smudge$HV == "H"){
    ans2 = ans2 + 100 *smudge$mirrorAt
  } else{
    ans2 = ans2 + smudge$mirrorAt
  }
}

print(paste0("Part 2: ",ans2))
