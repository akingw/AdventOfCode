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
with open(os.path.join(os.path.dirname(__file__),'Day11Input.txt'),'r') as data:
    for line in data:
        stones = [int(x) for x in line.split()]


for i in range(0,25):
    stones = blink(stones)

print(len(stones))
# 193269 is correct

# Part 2...gonna try again and probably break something. It did