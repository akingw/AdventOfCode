library(tidyverse)

input = readLines("Day3Input.txt")

input2 = gsub("\\.","a",input)

# [:punct:] doesn't match "=", despite the documentation for stringr 
# saying otherwise...
## str_locate("=test!","[:punct:]")
## str_locate("=test!","[:punct:]|=")

# Make a list of the symbols used:
## arr = gsub("\\d+","",gsub("\\.","",input)) %>% paste0(collapse="") %>%
##   str_split(pattern="")
## used = arr[[1]] %>% unique()

#markers = str_locate_all(input2,"[:punct:]")
#markers = str_locate_all(input2,"[:punct:]|=")
#markers = str_locate_all(input2,"[:punct:]|=|\\$|\\^")
markers = str_locate_all(input2,"@|&|\\*|\\$|-|#|=|%|\\+|\\/")

i = 0
adjacent = tibble(x=numeric(),
                  y=numeric())
for(line in markers){
  i = i + 1
  if(nrow(line)==0){next}
  for(j in 1:nrow(line)){
    k = line[j,1]
    xs = rep(c(k-1,k,k+1),3)
    ys = c(i-1,i-1,i-1,i,i,i,i+1,i+1,i+1)
    tib = tibble(x=xs,y=ys)
    adjacent = rbind(adjacent,tib)
  }
}

i = 0
sum = 0
## added = tibble(val  =numeric(),
##                row = numeric())
numbers = str_locate_all(input2,"\\d+")
for(line in numbers){
  i = i + 1
  if(nrow(line)==0){next}
  for(j in 1:nrow(line)){
    begin = line[j,1]
    end = line[j,2]
    matched = F
    num = as.numeric(str_sub(input2[i],begin,end))
    for(k in c(begin:end)){
      if(matched){next}
      x_val = k
      y_val = i
      nr = adjacent %>%
        filter(x==x_val,
               y==y_val) %>%
        nrow()
      if(nr > 0){
        # Added to spot check after running
        ## added = added %>% add_row(val = num, row = i)
        matched = T
        sum = sum + num
      }
    }
  }
}
print(sum)

#508074 wrong
#512512 wrong
#493609 wrong
#470101 too low :/
#835344 too high
#782504 too high

# Part 2

i = 0
numbers = str_locate_all(input,"\\d+")
numberSpots = tibble(xRange = numeric(),
                     yRange = numeric(),
                     val = numeric())
for(line in numbers){
  i = i + 1
  if(nrow(line)==0){next}
  for(j in 1:nrow(line)){
    # This is the number that a ring will be created around.
    num = as.numeric(str_sub(
      input[i], line[j,1], line[j,2]))
    xRange = c((line[j,1]-1):(line[j,2]+1))
    yRange = c((i-1):(i+1))
    ranges = expand_grid(xRange,yRange) %>%
      mutate(val = num)
    # builds out coordinates that a gear can be in that
    # are adjacent to a number
    numberSpots = numberSpots %>%
      add_row(ranges)
  }
}

gears = str_locate_all(input,"\\*")
sumPower = 0
i = 0
for(line in gears){
  i = i + 1
  if(nrow(line)==0){next}
  for(j in 1:nrow(line)){
    gearX = line[j,1]
    gearY = i
    adjacentNums = numberSpots %>%
      filter(xRange == gearX,
             yRange == gearY)
    if(nrow(adjacentNums)==2){
      power = prod(adjacentNums$val)
      sumPower = sumPower + power
    }
  }
}
print(sumPower)
