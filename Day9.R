library(tidyverse)

input = readLines("Day9Input.txt")
#input = c("0 3 6 9 12 15",
#"1 3 6 10 15 21",
#"10 13 16 21 30 45")

make_tree = function(inStr = ""){
  sumDiff = Inf
  i = 1
  # Using matrix instead of tibble since tibbles need names
  diffTree = matrix(as.numeric(rev(str_split(inStr, " ")[[1]])))
  while(sumDiff != 0){
    diffTree = cbind(diffTree,
                     lag(diffTree[,i])-diffTree[,i])
    i = i + 1
    sumDiff = sum(diffTree[,i],na.rm=T)
  }
  diffTree
}

find_next = function(tree = matrix()){
  lasts = c()
  for(i in 1:ncol(tree)){
    lasts = append(lasts,
                   na.omit(tree[,i])[1])
  }
  sum(lasts)
}

sum_new = 0
ind = 0
for(line in input){
  ind = ind + 1
  diff_tree = make_tree(line)
  tree_next = find_next(diff_tree)
  sum_new = sum_new + tree_next
  print(paste0("Next for ",ind," is ",tree_next,
               ". New tot is ",sum_new))
}
print(paste0("Part 1: ",sum_new))
#1980766090 too high - incorrectly using max
#1974913982 too high - didn't zero out sum before running
#1974913326 too high