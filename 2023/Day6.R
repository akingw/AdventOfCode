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

time2 = as.numeric(paste0(times,collapse=""))
dist2 = as.numeric(paste0(dists,collapse=""))

# This turns into doing math, more than coding it out
# Distance = Hold * (maxT - Hold)
# D = H * (T-H)
# D = H*T - H^2
# 0 = H*T -H^2 - D
# 0 = -H^2 + H*T - D
# 0 = a*x^2 + b*x + c

# x = (-b +/- sqrt(b^2 -4ac))/2a 
## to the tune of Smedley singing Iron Man ##
a = -1
b = time2
c = -dist2
x1 = floor((-b + sqrt(b^2 - 4*a*c))/(2*a))
x2 = ceiling((-b - sqrt(b^2 - 4*a*c))/(2*a))

# from wolfram alpha: 
# minus 1 since need to beat the distance, not match it
print(paste0("Part 2: ",(x2-x1)-1))

