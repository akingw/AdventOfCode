library(tidyverse)
library(numbers)

input = readLines("Day8Input.txt")

path1 = str_split(input[[1]],"")[[1]]

build_coords1 = function(){
coords <<- tibble(
  node = character(),
  L = character(),
  R = character())

for(i in 3:length(input)){
  inp = str_match(input[i],"(\\S+) = \\(([A-Z]{3}), ([A-Z]{3})")
  coords <<- coords %>% add_row(
    node = inp[1,2],
    L = inp[1,3],
    R = inp[1,4]
  )
}
}

step_through = function(path = c()){
  at_ZZZ = F
  steps = 0
  path_i = 0
  node_now = "AAA"
  while(!at_ZZZ){
    steps = steps + 1
    path_i = path_i + 1
    if(path_i > length(path)){path_i = 1}
    node_now = coords %>%
      filter(node == node_now) %>%
      select(path[path_i]) %>% 
      pull()
    if(node_now == 'ZZZ'){at_ZZZ = T}
    print(paste0("Step ",steps," now at ",node_now))
  }
  steps
}

step_through2 = function(strt = "",
                         path = c()){
  at_ZZZ = F
  steps = 0
  path_i = 0
  node_now = strt
  while(!at_ZZZ){
    steps = steps + 1
    path_i = path_i + 1
    if(path_i > length(path)){path_i = 1}
    node_now = coords %>%
      filter(node == node_now) %>%
      select(path[path_i]) %>% 
      pull()
   
    if(grepl("Z$",node_now)){
      at_ZZZ = T
      }
  }
  steps
}

build_coords1()
end_steps = step_through(path = path1)
print(paste0("Part 1: ",end_steps))

build_coords1()
ghost_starts = coords %>%
  filter(grepl("A$",node)) %>%
  pull(node)
each_step = c()
for(strt in ghost_starts){
  print(paste0("starting at ",strt))
  each_step =
    append(each_step,step_through2(
      strt = strt, path = path1))
  print(paste0("Ghost starting at ",strt," go to end in ",each_step[length(each_step)]))
}

print(paste0("Part 2: ",mLCM(each_step)))
