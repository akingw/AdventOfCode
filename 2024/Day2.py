# Read in the data
with open('Day2Input.txt','r') as data:
    reports = []
    for line in data:
        levels = list(map(int,line.split()))
        reports.append(levels)

# Lets make a function
def check_report(report):
    safe = True
    # Is the first transition going up?
    incr = report[0] < report[1]
    for ind, level in enumerate(report):
        if ind+1 == len(report):
            break
        levelNext = report[ind + 1]
        incrAll = level < levelNext
        dif = abs(level - levelNext)
        if (incr != incrAll) or (dif > 3 or dif == 0):
            # print(f"Report is {report}, and issue at ind {ind}. {incr}, {incrAll},{dif}, {level}, {levelNext}")
            safe = False
    return safe

# Read each report and determine if it is safe or not
safeReports = []
badReports = []
for report in reports:
    if check_report(report):
        safeReports.append(report)
    else:
        badReports.append(report)

# Part 1 answer:
print(f"Part 1: {len(safeReports)}")

partTwoSafe = []
for repInd, report in enumerate(badReports):
    for ind in range(0,len(report)):
        drop1 = report.copy()
        #print(f"Going to remove index {ind} from {drop1}")
        drop1.pop(ind)
        if check_report(drop1):
            #print(f"Safe to drop ind {ind} from bad report number {repInd}: {report}")
            partTwoSafe.append(report)
            break

# 301 is too high
print(f"Part 2: {len(safeReports)+len(partTwoSafe)}")