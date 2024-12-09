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

def get_resonance(a1,a2,nodes):
    pos = True
    inRange = True
    rd = a2[0] - a1[0]
    cd = a2[1] - a1[1]
    node = [a2[0],a2[1]]
    while inRange:
        node = [node[0] + rd, node[1] + cd]
        if node[0] in range(0,nr) and node[1] in range(0,nc):
            nodes.append(node)
        elif pos:
            rd = rd * -1
            cd = cd * -1
            pos = False
        else:
            inRange = False
    

#part 2...
antiNodes2 = []
for let in ants:
    for i,ant1 in enumerate(ants[let]):
        for j in range(i+1,len(ants[let])):
            ant2 = ants[let][j]
            antiNodes2.append(ant1)
            antiNodes2.append(ant2)
            get_resonance(ant1,ant2,antiNodes2)

part2_nodes = [list(x) for x in set(tuple(x) for x in antiNodes2)]

print(f"Part 2: {len(part2_nodes)}")
# 955 is correct