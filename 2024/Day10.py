import os
import re

def findAdj(val,r,c,strt,trails):
    if val == 9:
        trails[strt].append(str(r)+","+str(c))
    nextVal = val + 1
    coords = [[r-1,c],[r+1,c],[r,c-1],[r,c+1]]
    for coord in coords:
        if coord[0] in range(0,nr) and coord[1] in range(0,nc):
            if topMap[coord[0]][coord[1]] == nextVal:
                findAdj(nextVal,coord[0],coord[1],strt,trails)
    
def findAdjPth(val,r,c,strt,pthIn,trails):
    if val == 9:
        trails[strt].append(pthIn)
    nextVal = val + 1
    coords = [[r-1,c],[r+1,c],[r,c-1],[r,c+1]]
    for coord in coords:
        if coord[0] in range(0,nr) and coord[1] in range(0,nc):
            if topMap[coord[0]][coord[1]] == nextVal:
                pthOut = pthIn + ":" + str(coord[0]) + "," + str(coord[1])
                findAdjPth(nextVal,coord[0],coord[1],strt,pthOut,trails)



topMap = []
trailhead = {}
trailheadPth = {}
with open(os.path.join(os.path.dirname(__file__),'Day10Input.txt'),'r') as data:
    for line in data:
        topMap.append([int(x) for x in re.findall(r'\d',line)])
nr = len(topMap)
nc = len(topMap[0])


for r,row in enumerate(topMap):
    for c,num in enumerate(row):
        if num == 0:
            strt = str(r)+','+str(c)
            pthIn = strt
            trailhead[strt] = []
            trailheadPth[strt] = []
            findAdj(num,r,c,strt,trailhead)
            findAdjPth(num,r,c,strt,pthIn,trailheadPth)

numTrail = 0
for trail in trailhead:
    numTrail += len(set(trailhead[trail]))

print(numTrail)

numTrail2 = 0
for trail in trailheadPth:
    numTrail2 += len(set(trailheadPth[trail]))

print(numTrail2)