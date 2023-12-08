library(tidyverse)

input = readLines("Day4Input.txt")

# Winning | Yours

counted = 0
countCards = function(indices = c(1:length(input)),
                      part = 'part1'){
print(paste0("Have a list of ",length(indices)," to work through"))
nextRun = c()
for(i in indices){
  counted <<- counted + 1
  line = input[i]
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
  if(part == 'part1'){
    expVal = match - 1
    cardVal = 2^expVal
    sum <<- sum + cardVal
  } else {
    cardsWon = c((i+1):(i+match))
    nextRun = append(nextRun,cardsWon)
  }
}
 if(part != 'part1'){
   countCards(indices = nextRun,
            part = 'part2')}
 #sum
 #nextRun
}

indices = c(1:length(input))
sum = 0
countCards()
print(sum)

#23768 too high 

counted = 0
# Will leave function, because it was interesting, but dont run this
#countCards(part='part2')


# Part 2 attempt 2
cardData = tibble(
  cardId = c(1:length(input)),
  cardWins = 0
)
i = 0
for(line in input){
  i = i + 1
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
  cardData = cardData %>%
    mutate(cardWins = case_when(
      cardId == i ~ match,
      T ~ cardWins))
}

cardData = cardData %>%
  mutate(cardAdds = 0)

for(i in rev(c(1:length(input)))){
  newAdds = 1
  winList = c()
  wins = cardData %>%
    filter(cardId == i) %>%
    pull(cardWins)
  if(wins > 0){
    winList = c((i+1):(i+wins))
  }
  for(newCard in winList){
    newAdds = cardData %>%
      filter(cardId == newCard) %>%
      pull(cardAdds) +
      newAdds
  }
  cardData = cardData %>%
    mutate(cardAdds = case_when(
      cardId == i ~ newAdds,
      T ~ cardAdds))
}

print(sum(cardData$cardAdds))
