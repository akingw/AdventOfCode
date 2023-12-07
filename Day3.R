library(tidyverse)

input = readLines("Day3Input.txt")

input2 = gsub("\\.","a",input)

markers = str_locate_all(input2,"[:punct:]")

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
        print(paste0("Adding ",num," to sum"))
        matched = T
        sum = sum + num
      }
    }
  }
}
print(sum)

#470101 too low :/
#835344 too high
#782504 too high
