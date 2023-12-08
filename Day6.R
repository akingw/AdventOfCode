library(tidyverse)

input = readLines("Day6Input.txt")
# initial thought: 'Time...ew...'
# starting speed of 0, for each hold, speed increases by 1
# secondary though: "That is a very very small input...worried about part2"

times = as.numeric(str_extract_all(input[1],"\\d+")[[1]])
dists = as.numeric(str_extract_all(input[2],"\\d+")[[1]])
ways = c()

for(i in 1:length(times)){
  num_way = 0
  time = times[i]
  dist = dists[i]
  for(j in 1:time){
    dist_trav = j * (time - j)
    if(dist_trav > dist){
      num_way = num_way + 1 
    }
  }
  ways = append(ways,num_way)
}
print(paste0("Part 1: ", prod(ways)))
