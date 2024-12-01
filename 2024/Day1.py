# Read in the data
with open('Day1Input.txt','r') as data:
    c1 = []
    c2 = []
    for line in data:
        p = line.split()
        c1.append(int(p[0]))
        c2.append(int(p[1]))
# Test data
#c1 = [3,4,2,1,3,3]
#c2 = [4,3,5,3,9,3]

# Sort the lists
c1 = sorted(c1)
c2 = sorted(c2)
distTot = 0

# Calculate the distances
for ind, val in enumerate(c1):
    dist = abs(c1[ind]-c2[ind])
    distTot += dist

# Part 1 answer
print(distTot)
# 2113135

# Part 2:
similarityScore = {}
similarityTot = 0

for val in c1:
    if chr(val) not in similarityScore:
        similarityScore[chr(val)] = val * sum(c2val == val for c2val in c2)
        #print(f"{val} has score of {similarityScore[chr(val)]}")
    similarityTot += similarityScore[chr(val)]

print(similarityTot)