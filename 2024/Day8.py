import os
import re

ants = {}
nr = 0
nc = 0
with open(os.path.join(os.path.dirname(__file__),'Day8Input.txt'),'r') as data:
    for r, line in enumerate(data):
        nr += 1
        nc = len(re.findall(r'\S',line))
        for c,val in enumerate(re.findall(r'\S',line)):
            if val != '.':
                if val not in ants:
                    ants[val] = [[r,c]]
                else:
                    ants[val].append([r,c])
antiNodes = []
for antLet in ants:
    for i,ant1 in enumerate (ants[antLet]):
        for j in range(i+1,len(ants[antLet])):
            ant2 = ants[antLet][j]
            r1 = ant1[0]
            r2 = ant2[0]
            c1 = ant1[1]
            c2 = ant2[1]
            ar1, ar2, ac1, ac2 = 0, 0, 0, 0
            if r1 < r2 :
                ar1 = r1 - abs(r2 - r1)
                ar2 = r2 + abs(r2 - r1)
            else:
                ar1 = r1 + abs(r2 - r1)
                ar2 = r2 - abs(r2 - r1)
            if c1 < c2:
                ac1 = c1 - abs(c2 - c1)
                ac2 = c2 + abs(c2 - c1)
            else:
                ac1 = c1 + abs(c2 - c1)
                ac2 = c2 - abs(c2 - c1)
            antiNodes.append([ar1,ac1])
            antiNodes.append([ar2,ac2])
antiNodes1 = [list(x) for x in set(tuple(x) for x in antiNodes)]
antiNodes1Ans = []
for node in antiNodes1:
    if node[0] >= 0 and node[0] < nr and node[1] >= 0 and node[1] < nc:
        antiNodes1Ans.append(node)

print(len(antiNodes1Ans))
# 240 is correct

#part 2...