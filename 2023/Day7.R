library(tidyverse)

#7 Five of a kind, 
#6 Four of a kind, 
#5 Full house, 
#4 Three of a kind,
#3 Two pair,
#2 One pair,
#1 High card,

cardOrder = c("A"=13,"K"=12,"Q"=11,"J"=10,"T"=9,"9"=8,
              "8"=7,"7"=6,"6"=5,"5"=4,"4"=3,"3"=2,"2"=1)

cardOrder2 = c("A"=13,"K"=12,"Q"=11,"J"=1,"T"=10,"9"=9,
              "8"=8,"7"=7,"6"=6,"5"=5,"4"=4,"3"=3,"2"=2)
input = readLines("Day7Input.txt")
numHands = length(input)
handsTib = tibble(
  handT = character(),
  bet = numeric(),
  type = numeric())
for(line in input){
  handsTib = handsTib %>% add_row(
    handT = sub(" .*","",line),
    bet = as.numeric(sub(".* ","",line)),
    type = 0
  )
}
handsTib = handsTib %>%
  mutate(c1 = cardOrder[str_sub(handT,1,1)],
         c2 = cardOrder[str_sub(handT,2,2)],
         c3 = cardOrder[str_sub(handT,3,3)],
         c4 = cardOrder[str_sub(handT,4,4)],
         c5 = cardOrder[str_sub(handT,5,5)])

hands = handsTib %>% pull(handT)
for(hand in hands){
  cards = str_split(hand,"")[[1]]
  numCards = str_count(hand,cards)
  numCardsU = numCards %>% unique()
  handType = case_when(
    max(numCards) == 5 ~ 7,
    max(numCards) == 4 ~ 6,
    max(numCards) == 3 ~ case_when(
      sum(numCardsU) == 5 ~ 5,
      T ~ 4),
    max(numCards) == 2 ~ case_when(
      sum(numCards) == 9 ~ 3,
      T ~ 2),
    T ~ 1)
  handsTib = handsTib %>%
    mutate(type = case_when(
      handT == hand ~ handType,
      T ~ type
    ))
}
handsTib = handsTib %>%
  arrange(-type,-c1,-c2,-c3,-c4,-c5) %>%
  mutate(rank = nrow(handsTib)-row_number()+1,
         winnings = rank * bet)

print(paste0("Part 1: ",handsTib$winnings %>% sum()))

# Part 2 tie breaking method still works. Need new logic for type assignment


hands = handsTib %>% pull(handT)

for(hand in hands){
  handOld = hand
  hand = gsub("J","",hand)
  if(str_length(hand) == 0){
    handType = 7
  } else {
    nj = str_length(handOld)-str_length(hand)
    cards = str_split(hand,"")[[1]]
    numCards = str_count(hand,cards)
    numCardsU = numCards %>% unique()
    handType = case_when(
      # if no Jokers, same as before
      nj == 0 ~ case_when(
        max(numCards) == 5 ~ 7,
        max(numCards) == 4 ~ 6,
        max(numCards) == 3 ~ case_when(
          sum(numCardsU) == 5 ~ 5,
          T ~ 4),
        max(numCards) == 2 ~ case_when(
          sum(numCards) == 9 ~ 3,
          T ~ 2),
        T ~ 1),
      nj == 1 ~ case_when(
        max(numCards) == 1 ~ 2,
        max(numCards) == 2 ~ case_when(
          sum(numCards) == 8 ~ 5,
          T ~ 4),
        max(numCards) == 3 ~ 6,
        T ~ 7),
      nj == 2 ~ case_when(
        max(numCards) == 1 ~ 4,
        max(numCards) == 2 ~ 6,
        T ~ 7),
      nj == 3 ~ case_when(
        max(numCards) == 1 ~ 6,
        T ~ 7),
      # 4 or 5 get 5x
      T ~ 7) 
  }
  handsTib = handsTib %>%
    mutate(type = case_when(
      handT == handOld ~ handType,
      T ~ type
    ))
}
handsTib = handsTib %>%
  mutate(c1 = cardOrder2[str_sub(handT,1,1)],
         c2 = cardOrder2[str_sub(handT,2,2)],
         c3 = cardOrder2[str_sub(handT,3,3)],
         c4 = cardOrder2[str_sub(handT,4,4)],
         c5 = cardOrder2[str_sub(handT,5,5)])
handsTib = handsTib %>%
  arrange(-type,-c1,-c2,-c3,-c4,-c5) %>%
  mutate(rank = nrow(handsTib)-row_number()+1,
         winnings = rank * bet)

print(paste0("Part 2: ",handsTib$winnings %>% sum()))
