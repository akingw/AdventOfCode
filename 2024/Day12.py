import os
import re

plants = {}
with open(os.path.join(os.path.dirname(__file__),'Day12InputEx.txt'),'r') as data:
    for r,line in enumerate(data):
        for c,plant in enumerate(re.findall(r'\S',line)):
            if plant not in plants:
                plants[plant] = []
            plants[plant].append([r,c])

plantStats = {}
for plant in plants:
    # Can't do this, there are non-adjacent sections :/
    plantStats[plant] = {'Area': len(plants[plant])}