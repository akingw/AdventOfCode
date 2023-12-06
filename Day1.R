library(tidyverse)
input = readLines("Day1Part1Input.txt")

sum = 0

for(str in input){
  revStr = str_split(str,"")[[1]] %>%
    rev() %>% paste0(collapse="")
  dig1 = str_extract(str,"\\d")
  dig2 = str_extract(revStr,"\\d")
  num = as.numeric(paste0(dig1,dig2))
  sum = sum + num
}

print(sum)

nums = c('one','two','three','four','five',
         'six','seven','eight','nine','ten')

##for(str in input){
##  indices = tibble(begin = numeric(),
##                  last = numeric())
##  revStr = str_split(str,"")[[1]] %>%
##    rev() %>% paste0(collapse="")
##  dig1 = str_extract(str,"\\d")
##  indices = indices %>%
##    add_row(begin = str_locate(str,dig1)[,1],
##            last = begin)
##  dig2 = str_extract(revStr,"\\d")
##  indices = indices %>%
##    add_row(begin = (str_length(str) - str_locate(revStr,dig2)[,1] + 1),
##            last = begin)
##  words = nums[sapply(nums,grepl,str)]
##  for(word in words){
##    location = str_locate(str,word)
##    indices = indices %>%
##      add_row(begin = location[,1],
##              last = location[,2])
##  }
##  firstIndex = indices %>% 
##    slice(which(begin == min(begin)))
##  lastIndex = indices %>% 
##    slice(which(begin == max(begin)))
  # Here I realized this won't work if there are multiple of the
  # same number word. So starting over, with a much better plan
##}

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