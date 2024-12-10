import os
import re
import sys

def inToLong(strIn,fId):
    newStr = ""
    for i,val in enumerate(re.findall(r'\S',strIn)):
        newLen = int(val)
        if i % 2 == 0:
            newVal = str(fId)
            fId += 1
        else:
            newVal = "."
        newStr += newVal * newLen
    return newStr

def flatten(xss):
    return [x for xs in xss for x in xs]

def inToDict(strIn,fId):
    newDict = {}
    indStrt = 0
    dictName = None
    for i,val in enumerate(re.findall(r'\S',strIn)):
        datLen = int(val)
        indEnd = indStrt + datLen
        if i % 2 == 0:
            dictName = fId
            fId += 1
        else:
            dictName = 'free'
        if dictName in newDict:
            for x in range(indStrt,indEnd):
                newDict[dictName].append(x)
        else:
            newDict[dictName] = [x for x in range(indStrt,indEnd)]
        indStrt = indEnd 
    return newDict

def inToDict2(strIn,fId):
    newDict = {}
    indStrt = 0
    dictName = None
    newDict['free'] = []
    for i,val in enumerate(re.findall(r'\S',strIn)):
        datLen = int(val)
        indEnd = indStrt + datLen
        if i % 2 == 0:
            dictName = fId
            fId += 1
        else:
            dictName = 'free'
        if dictName == 'free':
            if dictName in newDict:
                newDict[dictName].append([x for x in range(indStrt,indEnd)])
            else:
                newDict[dictName] = [x for x in range(indStrt,indEnd)]
        else:
            newDict[dictName] = [x for x in range(indStrt,indEnd)]
        indStrt = indEnd 
    return newDict


def rightToLeft(longStr):
    outArr = []
    longArr = re.findall(r"\S",longStr)
    num_space = len(re.findall(r"\.",longStr))
    num_to_move = len(re.findall(r"\.",longStr[0:-num_space]))
    moving_nums = re.findall(r"\d",longStr)[-num_to_move:]
    for val in longArr[0:-num_space]:
        if val == ".":
            outArr.append(moving_nums.pop())
        else:
            outArr.append(val)
    return outArr

def checkSum(inArr):
    chkSum = 0
    for ind,val in enumerate(inArr):
        chkSum += ind * int(val)
    return chkSum

strIn = None
with open(os.path.join(os.path.dirname(__file__),'Day9Input.txt'),'r') as data:
    for line in data:
        strIn = line

#longStr = inToLong(strIn, 0)
#print(longStr)
#sortArr = rightToLeft(longStr)
#print(sortArr)
#part1Ans = checkSum(sortArr)

#print(f"Part 1: {part1Ans}")
# 90542694500 is too low...but it worked on the example...
# The issue must be from when the ID is longer than one digit... the 10th file gets '10'
# placed in the string, but it really should just be a '0'...then how to keep track of
# that after sorting...?

# I'll keep the old way in there, just because
def moveLeft(lngDict,usedInd,freeV):
    for ind,val in reversed(list(enumerate(lngDict[usedInd]))):
        wasFree = freeV.pop(0)
        if val > wasFree:
            lngDict[usedInd][ind] = wasFree
        else:
            print(f"in break val:{val}, wasFree:{wasFree}, usedInd:{usedInd}")
            return False
    return True

def moveLeft2(lngDict,usedInd):
    lenMove = len(lngDict[usedInd])
    strtInd = lngDict[usedInd][0]
    for freeVals in lngDict['free']:
        #print(f"free Vals is {freeVals}, comparing {lenMove} to {len(freeVals)}")
        if len(freeVals) == 0:
            continue
        if freeVals[0] > lngDict[usedInd][0]:
            return
        if len(freeVals) >= lenMove:
            lngDict[usedInd] = freeVals[0:lenMove]
            for _ in range(0,lenMove):
                freeVals.pop(0)
            break

longDict = inToDict(strIn,0)

freeVals = longDict['free']
strtInd = len(longDict)-2

for inds in range(strtInd,0,-1):
    if not moveLeft(longDict,inds,freeVals):
        break

chkSum = 0
for key in longDict:
    if key == 'free':
        continue
    sumVals = [i * key for i in longDict[key]]
    chkSum += sum(sumVals)

print(chkSum)
# 7707957862811 is too high...
# 6367087064415 is correct (was adding 1 to the end index in toDict)

longDict2 = inToDict2(strIn,0)

for inds in range(strtInd,0,-1):
    moveLeft2(longDict2,inds)

chkSum2 = 0
for key in longDict:
    if key == "free":
        continue
    sumVals = [i * key for i in longDict2[key]]
    chkSum2 += sum(sumVals)

print(chkSum2)