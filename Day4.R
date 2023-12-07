library(tidyverse)

input = readLines("Day4Input.txt")
#input = c("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
#"Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
#"Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
#"Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
#"Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
#"Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11")
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
  if(match == 0){next}
  expVal = match - 1
  cardVal = 2^expVal
  
  sum = sum + cardVal
}
print(sum)
#23768 too high