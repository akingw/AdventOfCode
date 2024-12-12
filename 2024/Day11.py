import os

def blink(stones):
    stonesOut = []
    for stone in stones:
        if stone == 0:
            stonesOut.append(1)
        elif len(str(stone)) % 2 == 0:
            stonesOut.append(int(str(stone)[:int(len(str(stone))/2)]))
            stonesOut.append(int(str(stone)[int(len(str(stone))/2):]))
        else:
            stonesOut.append(stone * 2024)
    return stonesOut

stones = []
stonesIn = []
with open(os.path.join(os.path.dirname(__file__),'Day11Input.txt'),'r') as data:
    for line in data:
        stones = [int(x) for x in line.split()]
        stonesIn = [int(x) for x in line.split()]


for i in range(0,25):
    stones = blink(stones)

print(len(stones))
# 193269 is correct

# Part 2...gonna try again and probably break something. It did

def blink_once():
    stoneLoop = dict(stones2)
    for stone, count in stoneLoop.items():
        if count == 0: continue
        if stone == 0:
            if 1 not in stones2:
                stones2[1] = 0
            stones2[1] += count
            stones2[0] -= count
        elif len(str(stone)) % 2 == 0:
            stoneL = (int(str(stone)[:int(len(str(stone))/2)]))
            stoneR = (int(str(stone)[int(len(str(stone))/2):]))
            if stoneL not in stones2:
                stones2[stoneL] = 0
            if stoneR not in stones2:
                stones2[stoneR] = 0
            stones2[stoneL] += count
            stones2[stoneR] += count
            stones2[stone] -= count
        else:
            if stone*2024 not in stones2:
                stones2[stone*2024] = 0
            stones2[stone*2024] += count
            stones2[stone] -= count

stones2 = {}
for stone in stonesIn:
    stones2[stone] = 1


for i in range(75):
    print(i)
    blink_once()

print(f"Part2: {sum(stones2.values())}")
# 34591044484411514321654767235878473059767942795856392752839408011652032 is probably waaay too big...
# 228449040027793