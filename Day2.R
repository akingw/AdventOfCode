library(tidyverse)

input = readLines("Day2Input.txt")

count = 0
colors = tibble(
  color = c('red',
            'green',
            'blue'),
  limit = c(12, 13, 14)
)

for(game in input){
  possible = T
  gameNum = as.numeric(str_extract(game,"\\d+"))
  for(i in 1:nrow(colors)){
    col = colors$color[i]
    lim = colors$limit[i]
    cubes = str_extract_all(game,paste0("\\d+ ",col))[[1]]
    for(j in cubes){
      n = as.numeric(str_extract(j,"\\d+"))
      if(n>lim){
        possible = F
      }
    }
  }
  if(possible){
    count = count + gameNum
  }
}

print(count)