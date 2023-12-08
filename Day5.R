library(tidyverse)

input = readLines("Day5Input.txt")

inp_al = paste(input,collapse = "")
words = str_match_all(inp_all,"([a-z]{1,})-to-([a-z]{1,})")[[1]]
sourceList = c(words[,2:3]) %>% unique()

mapInfo = tibble(
  source = character(),
  sourceId = numeric(),
  sourceStart = numeric(),
  sourceEnd = numeric(),
  sourceAdd = numeric())

seedSplit = str_split(input[1]," ")[[1]]
seeds = as.numeric(seedSplit[2:length(seedSplit)])
source = NA
for(line in input){
  if(str_length(line)==0){
    source = NA
  }
  else if(is.na(source)){
    source = str_match(line,"(\\S+)-to")[1,2]
  } else{
    match = as.numeric(str_match(line,"(\\d+) (\\d+) (\\d+)")[1,2:4])
    newRow = tibble(
      source = source,
      sourceId = str_which(source, sourceList),
      sourceStart = match[2],
      sourceEnd = match[2] + match[3],
      sourceAdd = match[1] - match[2]
    )
    mapInfo = mapInfo %>%
      add_row(newRow)
  }
}
mapNext = function(id = 0, startIdx = 0){
  inp = mapInfo %>% filter(sourceId == id) %>%
    select(source) %>% unique()
  idxMod = mapInfo %>%
    filter(sourceId == id,
           sourceStart <= startIdx,
           sourceEnd >= startIdx) %>%
    pull(sourceAdd)
  outIdx = startIdx + idxMod
  output = c(id+1, outIdx)
  output
}

minLoc = Inf
sourceId = 1
for(seed in seeds){
  startIdx = seed
  while(sourceId <= mapInfo$sourceId %>% max()){
    output = mapNext(id = sourceId,
                     startIdx = startIdx)
    sourceId = output[1]
    startIdx = output[2]
  }
  if(startIdx < minLoc){
    minLoc = startIdx
  }
}
print(paste0("Part 1: ",minLoc))

#26912583 too low