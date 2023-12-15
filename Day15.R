input = readLines("Day15Input.txt")
#input = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"

vals = str_split(input,",")[[1]]

hashTot = 0
for(val in vals){
  hashVal = 0
  lets = str_split(val,"")[[1]]
  for(let in lets){
    ascVal = as.numeric(charToRaw(let))
    hashVal = hashVal + ascVal
    hashVal = hashVal * 17
    hashVal = hashVal %% 256
  }
  hashTot = hashVal + hashTot
}
print(hashTot)

# Part 2

boxes = vector(mode = 'list',length = 256)

for(val in vals){
  focL = NA
  match = str_match(val,"(.*)(-|=)(.*)")
  if(str_length(match[1,4])!=0){focL = match[1,4]}
  box = 0
  boxLab = match[1,2]
  func = match[1,3]
  for(let in str_split(boxLab,"")[[1]]){
    ascVal = as.numeric(charToRaw(let))
    box = box + ascVal
    box = box * 17
    box = box %% 256
  }
  if(!is.na(focL)){
    if(is_null(boxes[[box+1]])){
     # print(paste0("Creating Box ",box+1,' with ',boxLab))
      boxes[[box+1]] = tibble(
        'lab' = boxLab,
        'foc' = match[1,4]
      )
    } else {
      if(nrow(boxes[[box+1]] %>% filter(lab == boxLab))>0){
       # print(paste0("Changing ",boxLab," in Box ",box+1," to ",match[1,4]))
        boxes[[box+1]] = boxes[[box+1]] %>%
          mutate(foc = case_when(
            lab == boxLab ~ match[1,4],
            T ~ foc))
      } else {
       # print(paste0("Adding ",boxLab," to box ",box+1))
        boxes[[box+1]] = boxes[[box+1]] %>%
          add_row('lab' = boxLab, 'foc' = match[1,4])
      }
    }
  } else {
    if(!is_null(boxes[[box+1]])){ 
      #print(paste0("Removing ",boxLab," from box ",box+1))
      boxes[[box+1]] = boxes[[box+1]] %>%
        filter(lab != boxLab)
    }
  }
}
focusPower = 0
for(i in 1:length(boxes)){
  if(is_null(boxes[[i]])){next}
  nr = nrow(boxes[[i]])
  if(nr==0){next}
#  print(paste0("Box: ",i))
  for(j in 1:nr){
    lensPower = i * j * as.numeric(boxes[[i]]$foc[j])
#    print(lensPower)
    focusPower = focusPower + lensPower
  }
}
print(focusPower)
