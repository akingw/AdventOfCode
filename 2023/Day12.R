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
  line = "????.#...#... 4,1,1"
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
  # doesn't work in part 2
  gapAlls = expand.grid(lst)

  gapValid = gapAlls[rowSums(gapAlls)==numOk,]
  
  # Part2?
  #regStr = ""
  base_gaps = c(0,rep(1,numGaps-2),0)
  gapAdds = t(restrictedparts(numOk-sum(base_gaps),
                              length(base_gaps)))
  gapAlls = gapAdds
  for(j in 1:(ncol(gapAdds)-1)){
    gapAlls = rbind(gapAlls,cbind(
      gapAdds[,(j+1):ncol(gapAdds)],
      gapAdds[,1:j]))
  }
  gapValid = gapAlls
#  for(l in 1:length(nums)){
#    n = nums[l]
#    regStr = paste0(regStr,mReg,"{",n,"}",gReg,"{1,}") 
#  }
  print(paste0("line ",i,' has ',nrow(gapValid)," regex's to do"))
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


expand = function(strs = c(),regStrOr = ""){
  strsOut = c()
  for(j in 1:length(strs)){
    dot = sub("\\?",".",strs[j])
    hsh = sub("\\?","#",strs[j])
    if(grepl(regStrOr,dot)){
      strsOut = append(strsOut,dot)
    }
    if(grepl(regStrOr,hsh)){
      strsOut = append(strsOut,hsh)
    }
  }
  strsOut
}
# Part 2...

input = c("???.### 1,1,3",
          ".??..??...?##. 1,1,3",
          "?#?#?#?#?#?#?#? 1,3,1,6",
          "????.#...#... 4,1,1",
          "????.######..#####. 1,6,5",
          "?###???????? 3,2,1")

input = readLines("Day12Input.txt")

num_tot = 0
for(i in 1:length(input)){
  nOps = 0
  lineDone = F
  line = input[i]
 ## line = "????.#...#... 4,1,1"
  #print(paste0("input line is ",line))
  springStr = sub(" .*","",line)
  #  # For part 2
  springStr = paste0(rep(springStr,5),collapse="?")
  
  nums = as.numeric(str_split(sub(".* ","",line),",")[[1]])
  #  # For part 2
  nums = rep(nums,5)
  
  regStr = ""
  regStrOr = ""
  for(j in 1:length(nums)){
    n = nums[j]
    regStr = paste0(regStr,"[#]{",n,"}")
    regStrOr = paste0(regStrOr,"[\\?|#]{",n,"}")
    if(j < length(nums)){
      regStr = paste0(regStr,"[\\.]{1,}")
      regStrOr = paste0(regStrOr,"[\\.|\\?]{1,}")
    }
  }
  
  numBroke = sum(nums)
  numOk = str_length(springStr)-numBroke
  
  hasQs = T
  strings = (springStr)
  print(paste0("Looking at line ",i))
  while(hasQs){
    print(paste0("strings is ",length(strings)))
    strings = expand(strings,regStrOr)
    hasQs = any(grepl("\\?",strings))
  }
  #print(paste0("has ",length(strings)," options"))
  for(str in strings){
    if(grepl(regStr,str)){num_tot = num_tot + 1}
  }
}

