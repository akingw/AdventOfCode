input = readLines("Day12Input.txt")
#input = c("???.### 1,1,3",
#          ".??..??...?##. 1,1,3",
#          "?#?#?#?#?#?#?#? 1,3,1,6",
#          "????.#...#... 4,1,1",
#          "????.######..#####. 1,6,5",
#          "?###???????? 3,2,1")

# . operational
# # damaged
# ? unknown
# list of contiguous groups of damaged
# How many options in a row?
# sum of possible arrangements

# Regex patterns...
gReg = "[\\?|\\.]"
mReg = "[\\?|#]"
nPossibles = c()
for(i in 1:length(input)){
  nOps = 0
  lineDone = F
  line = input[i]
  #print(paste0("input line is ",line))
  springStr = sub(" .*","",line)
  nums = as.numeric(str_split(sub(".* ","",line),",")[[1]])
  # Number of spaces between groups, including leading and trailing
  numGaps = length(nums)+1
  # Number of springs that work
  numOk = str_length(springStr)-sum(nums)
  
  lst = vector(mode = 'list', length = numGaps)
  for(j in 1:numGaps){
    k = 1
    if(j %in% c(1,numGaps)){k = 0}
    lst[[j]] = c(k:numOk)
    }
  gapAlls = expand.grid(lst)
  gapValid = gapAlls[rowSums(gapAlls)==numOk,]
  
  for(j in 1:nrow(gapValid)){
    gaps = gapValid[j,]
    if(gaps[1]==0){
      regStr = ""
    } else {
      regStr = paste0(gReg,"{",gaps[1],"}")
    }
    for(k in 1:length(nums)){
      n = nums[k]
      g = gaps[k+1]
      # Have first gap, so start with number
      regStr = paste0(regStr,mReg,"{",n,"}")
      # Only add gap if non-zero
      if(g != 0){
        regStr = paste0(regStr,gReg,"{",g,"}")
      }
    }
    possible = grepl(regStr,springStr)
    if(possible){
      nOps = nOps + 1
    }
  }
  print(paste0("nOps for input ",i," is ",nOps))
  nPossibles = append(nPossibles,nOps)
}

print(paste0("Part 1: ",sum(nPossibles)))
