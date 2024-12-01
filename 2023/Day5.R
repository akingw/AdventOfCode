library(tidyverse)

input = readLines("Day5Input.txt")

inp_all = paste(input,collapse = "")
words = str_match_all(inp_all,"([a-z]{1,})-to-([a-z]{1,})")[[1]]
sourceList = c(words[,2:3]) %>% unique()

mapInfo = tibble(
  source = character(),
  sourceId = numeric(),
  sourceStart = numeric(),
  sourceEnd = numeric(),
  sourceAdd = numeric(),
  destStart = numeric(),
  destEnd = numeric())

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
      sourceEnd = match[2] + match[3]-1,
      sourceAdd = match[1] - match[2],
      destStart = sourceStart + sourceAdd,
      destEnd = sourceEnd + sourceAdd
    )
    mapInfo = mapInfo %>%
      add_row(newRow)
  }
}
mapNext = function(id = 0, startIdx = 0){
  modRow = mapInfo %>%
    filter(sourceId == id,
           sourceStart <= startIdx,
           sourceEnd >= startIdx)
  if(nrow(modRow)==0){
    idxMod = 0
  } else{
    idxMod = modRow %>% 
      pull(sourceAdd)
  }
  outIdx = startIdx + idxMod
  output = c(id+1, outIdx)
#  print(paste0(sourceList[id]," at ",startIdx, ' goes to ',
#               sourceList[id+1],' at ',outIdx))
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
  sourceId = 1
}
print(paste0("Part 1: ",minLoc))

#26912583 too low

# Part 2 keeps the same mapping, just update the list of seeds to look at.
seedsLong = tibble(
  seedStart = seeds[seq(1,length(seeds),2)],
  seedNum = seeds[seq(2,length(seeds),2)]
)

print(paste0("Nope...Can't check ",sum(seedsLong$seedNum),
             " seeds, so doing something else..."))


# Function to use the map to turn a tibble of input ranges to 
# a tibble of ranges for the next level up...
mapRange = function(id = 0,
                    inpRanges = NA){
  outRanges = tibble(
    rangeStart = numeric(),
    rangeLen = numeric(),
    mapId = numeric(),
    inpId = numeric(),
    logicId = numeric()
  )
  print(paste0("Mapping from ",id," to ",id+1))
  # Get the map for this level
  map = mapInfo %>%
    filter(sourceId == id)
  # Calculate for each input range
  for(i in 1:nrow(inpRanges)){
    # start and end of range we're mapping
    rStart = inpRanges$rangeStart[i]
    rLen = inpRanges$rangeLen[i]
    rEnd = rLen + rStart
    # Check every row of the map
    for(j in 1:nrow(map)){
      mStart = map$sourceStart[j]
      mEnd = map$sourceEnd[j]
      mapAdd = map$sourceAdd[j]
      # Easiest case, inputrange resides fully in map range
      if(mStart<=rStart & mEnd >= rEnd){
        # Keeps the same range length, just modify start
        outRanges = outRanges %>% add_row(
          rangeStart = rStart + mapAdd,
          rangeLen = rLen,
          mapId = j,
          inpId = i,
          logicId = 1)
        # don't need to look at other maps for this inpRange
        break
        
      # Range starts before and ends after map
      } else if(mStart>=rStart & mEnd<=rEnd){
        outRanges = outRanges %>% add_row(
          rangeStart = mStart + mapAdd,
          rangeLen = mEnd-mStart+1,
          mapId = j,
          inpId = i,
          logicId = 4
        )
      # Range starts before, but overlaps map, starting at mStart
      } else if(mStart>=rStart & mStart<=rEnd){
        # Calculate length of new range
        newLen = rEnd - mStart + 1
        outRanges = outRanges %>% add_row(
          rangeStart = mStart + mapAdd,
          rangeLen = newLen,
          mapId = j,
          inpId = i,
          logicId = 2
        )
        
      # Range starts within, and ends after
      } else if(rStart<=mEnd & rEnd>=mEnd){
        newLen = mEnd - rStart + 1
        outRanges = outRanges %>% add_row(
          rangeStart = rStart + mapAdd,
          rangeLen = newLen,
          mapId = j,
          inpId = i,
          logicId = 3
        )
        
      } 
      # That should be all the options
    }
  }
  outRanges
}

rangesToMap = seedsLong %>%
  rename(rangeStart = seedStart,
         rangeLen = seedNum)
for(k in 1:7){
  rangesToMap = mapRange(k,rangesToMap)
}

print(paste0("Part 2: ",rangesToMap$rangeStart %>% min()))
