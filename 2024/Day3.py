import re

def flatten(xss):
    return [x for xs in xss for x in xs]

def list_to_dict(lst, default=None):
    return {key: default for key in lst}

# Read in the data
with open('Day3Input.txt','r') as data:
    day3_in = []
    for line in data:
        day3_in.append(line)

mult_nums = []
part1_answer = 0
for day3_line in day3_in:
    part1_matches = re.findall(r"mul\(\d{1,3},\d{1,3}\)",day3_line)
    mult_nums.append(part1_matches)

part1_mults = flatten(mult_nums)

for mult in part1_mults:
    nums = re.findall(r"\d{1,3}",mult)
    part1_answer += (int(nums[0]) * int(nums[1]))

print(f"Part 1: {part1_answer}")
# 174103751 correct

# Part 2
part2_input = "".join(day3_in)
#part2_input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
dos = [m.start() for m in re.finditer(r"do\(\)",part2_input)]
donts = [m.start() for m in re.finditer(r"don\'t\(\)",part2_input)]

do_dict = list_to_dict(dos,"Do")
dont_dict = list_to_dict(donts,"Dont")

do_donts = do_dict | dont_dict
inds_use = []
inds_cur = [0]
enabled = True
for key,val in dict(sorted(do_donts.items())).items():
    if enabled and val == 'Dont':
        inds_cur.append(key)
        enabled = False
    elif not enabled and val == "Do":
        inds_cur.append(key)
        enabled = True
    if len(inds_cur) == 2:
        inds_use.append(inds_cur)
        inds_cur = []

# If there isn't an ending 'dont' continue until the end of the line.
if len(inds_cur) != 0:
    inds_cur.append(-1)
    inds_use.append(inds_cur)

part2_input_arr = []
for ind_range in inds_use:
    part2_input_arr.append(part2_input[ind_range[0]:ind_range[1]])

part2_input_use = "".join(part2_input_arr)

mult_nums2 = re.findall(r"mul\(\d{1,3},\d{1,3}\)",part2_input_use)

part2_answer = 0
for mult in mult_nums2:
    nums = re.findall(r"\d{1,3}",mult)
    part2_answer += (int(nums[0]) * int(nums[1]))

print(f"Part 2: {part2_answer}")
# 31273975 is too low
# 77486731 is too low
# 55287509 will also be too low
# 99970025 is also too low...
# 100411201 is correct