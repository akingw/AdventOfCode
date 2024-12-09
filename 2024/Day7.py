import os
print(os.path.dirname(__file__))
def add_mult(ans,num1,nums, ind, eqn_match):
    if num1 > ans:
        return
    elif len(nums) == 0:
        if num1 == ans:
            eqn_match.append({ind: ans})
        return
    add_mult(ans,num1 * nums[0], nums[1:], ind, eqn_match)
    add_mult(ans,num1 + nums[0], nums[1:], ind, eqn_match)

def add_mult_cat(ans,num1,nums, ind, eqn_match2):
    if num1 > ans:
        return
    elif len(nums) == 0:
        if num1 == ans:
            eqn_match2.append({ind: ans})
        return
    add_mult_cat(ans,num1 * nums[0], nums[1:], ind, eqn_match2)
    add_mult_cat(ans,num1 + nums[0], nums[1:], ind, eqn_match2)
    add_mult_cat(ans,int(str(num1) + str(nums[0])), nums[1:], ind, eqn_match2)

equations = []
with open(os.path.join(os.path.dirname(__file__),'Day6Input.txt'),'r') as data:
    for line in data:
        equations.append(line)

eqn_match = []
eqn_match2 = []
for ind,eqn in enumerate(equations):
    ans, numStr = eqn.split(":")
    ans = int(ans)
    nums = [int(x) for x in numStr.split()]
    add_mult(ans,nums[0],nums[1:],ind,eqn_match)
    add_mult_cat(ans,nums[0],nums[1:],ind,eqn_match2)

part1_ans = 0
part1 = [dict(t) for t in {tuple(d.items()) for d in eqn_match}]
for eqn in part1:
    for ind in eqn:
        part1_ans += eqn[ind]

print(part1_ans)
# 945512582195 is correct

part2_ans = 0
part2 = [dict(t) for t in {tuple(d.items()) for d in eqn_match2}]
for eqn2 in part2:
    for ind2 in eqn2:
        part2_ans += eqn2[ind2]

print(part2_ans)
# 271691107779347 is correct