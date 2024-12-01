library(tidyverse)

input = readLines("Day9Input.txt")
#input = c("0 3 6 9 12 15",
#"1 3 6 10 15 21",
#"10 13 16 21 30 45")
dTrees = vector(mode = 'list',length= length(input))
make_tree = function(inStr = ""){
  allZero = F
  i = 1
  # Using matrix instead of tibble since tibbles need names
  # Splits input into array of values, and reverses the list
  # This lets the first non-NAs be the 'last' entry.
  diffTree = matrix(as.numeric(rev(str_split(inStr, " ")[[1]])))
  while(!allZero){
    # make a new column that is the difference
    diffTree = cbind(diffTree,
                     lag(diffTree[,i])-diffTree[,i])
    i = i + 1
    # repeat until the total difference is 0
    allZero = max(diffTree[,i],na.rm=T) == min(diffTree[,i],na.rm=T)
  }
  # Return the maxtrix
  diffTree
}

find_next = function(tree = matrix()){
  lasts = c()
  # for every column in the matrix, remove NAs, and pull out the first value
  for(i in 1:ncol(tree)){
    lasts = append(lasts,
                   na.omit(tree[,i])[1])
  }
  # Sum of all the 'next' values, that is the same as doing it one at a time
  # like the example says.
  sum(lasts)
}
find_prev = function(tree = matrix()){
  nr = nrow(tree)
  last_row = tree[nr,]
  rev_last = rev(last_row)
  val = 0
  for(elem in rev_last){
    val = elem - val
  }
  val
}
sum_new = 0
sum_2 = 0
ind = 0
for(line in input){
  ind = ind + 1
  # make the tree (matrix)
  diff_tree = make_tree(line)
  dTrees[[ind]] = diff_tree
  # Find the next value for the input
  tree_next = find_next(diff_tree)
  tree_prev = find_prev(diff_tree)
  sum_new = sum_new + tree_next
  sum_2 = sum_2 + tree_prev
  
  # Print info for spot checking
  #print(paste0("Next for ",ind," is ",tree_next,
  #             ". New tot is ",sum_new))
}

print(paste0("Part 1: ",sum_new))
#1980766090 too high - incorrectly using max
#1974913982 too high - didn't zero out sum before running
#1974913326 too high
print(paste0("Part 2: ",sum_2))
