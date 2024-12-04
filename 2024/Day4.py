import re
# Read in the data
def check_xmas(coords):
    for coord in coords:
        for val in coord:
            if val < 0:
                #print(f"Negative: {val}")
                return False
    try:
        if day4_input[coords[0][0]][coords[0][1]] != "X":
            return False
        elif day4_input[coords[1][0]][coords[1][1]] != "M":
            return False
        elif day4_input[coords[2][0]][coords[2][1]] != "A":
            return False
        elif day4_input[coords[3][0]][coords[3][1]] != "S":
            return False
        return True
    except:
        #print(f'out of range at {r},{c}')
        return False


def check_8Dir(r,c):
    numFound = 0
    for i in [-1,0,1]:
        for j in [-1,0,1]:
            if check_xmas([[r,c],[r+i,c+j],[r+2*i,c+2*j],[r+3*i,c+3*j]]):
                numFound += 1
    return numFound

with open('Day4Input.txt','r') as data:
    day4_input = []
    for line in data:
        day4_input.append(re.findall(r'\S',line))

numRow = len(day4_input)
numCol = len(day4_input[0])

numXMAS = 0
for r,row in enumerate(day4_input):
    for c,letter in enumerate(row):
        numXMAS += check_8Dir(r,c)

print(f"Part 1: {numXMAS}")

# 2668 is too high
# 2660 also too high
# 2654 Correct

# part 2
def check_cross(r,c):
    coords = [[r-1,c-1],
              [r-1,c+1],
              [r+1,c-1],
              [r+1,c+1]]
    letArr = []
    try:
        for coord in coords:
            if coord[0] < 0 or coord[1] < 0:
                return 0
            letArr.append(day4_input[coord[0]][coord[1]])
        letStr = "".join(letArr)
        ms = re.findall(r'[MS]',letStr)
        if len(ms) < 4:
            return 0
        elif ms[0] == ms[3] or ms[1] == ms[2]:
            return 0
        elif len(re.findall(r'M',letStr)) != len(re.findall(r'S',letStr)):
            return 0
        return 1
    except:
        return 0


numCross = 0
for r,row in enumerate(day4_input):
    for c,letter in enumerate(row):
        if day4_input[r][c] == "A":
            numCross += check_cross(r,c)

print(numCross)