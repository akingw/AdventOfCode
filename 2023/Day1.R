library(tidyverse)
input = readLines("Day1Part1Input.txt")

searches = c("\\d")

searches = c('one','two','three','four','five',
             'six','seven','eight','nine','ten',
             "\\d")
sum = 0
for(str in input){
  indices = tibble(begin = numeric(),
                   last = numeric())
  for(pattern in searches){
    matches = str_locate_all(str,pattern)
    indices = indices %>%
      add_row(
        begin = matches[[1]][,1],
        last = matches[[1]][,2]
    )
  }
  
  # Could save these to rows in a new tibble instead, but this works
  firstIndex = indices %>%
    filter(begin == min(begin))
  lastIndex = indices %>%
    filter(begin == max(begin))
  if(firstIndex$begin == firstIndex$last){
    dig1 = as.numeric(str_sub(str,firstIndex$begin,firstIndex$last))
  } else{
    dig1 = str_which(searches,str_sub(str,
                                     firstIndex$begin,
                                     firstIndex$last))
  }
  if(lastIndex$begin == lastIndex$last){
    dig2 = as.numeric(str_sub(str,lastIndex$begin,lastIndex$last))
  } else{
    dig2 = str_which(searches,str_sub(str,
                                     lastIndex$begin,
                                     lastIndex$last))
  }
  sum = sum +
    as.numeric(paste0(dig1,dig2))
}

print(sum)