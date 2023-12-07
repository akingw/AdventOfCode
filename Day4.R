library(tidyverse)

input = readLines("Day4Input.txt")

# Winning | Yours
sum = 0
for(line in input){
  vals = str_split(line,":|\\|")
  win = vals[[1]][2] %>%
    str_split("\\s+")
  winning = win[[1]] %>%
    as.numeric()
  winning = winning[!is.na(winning)]
  
  you = vals[[1]][3] %>%
    str_split("\\s+")
  yours = you[[1]] %>%
    as.numeric()
  yours = yours[!is.na(yours)]
  
  match = sum(yours %in% winning)
  expVal = match - 1
  cardVal = 2^expVal
  
  sum = sum + cardVal
}
print(sum)
#23768 too high