# Read in the data
with open('Day5Input.txt','r') as data:
    order_rules = []
    print_orders = []
    for line in data:
        if "|" in line:
            order_rules.append([int(x) for x in line.split("|")])
        elif "," in line:
            print_orders.append([int(x) for x in line.split(",")])

bad_runs = []
for print_run in print_orders:
    for rule in order_rules:
        if rule[0] in print_run and rule[1] in print_run:
            if print_run.index(rule[0]) > print_run.index(rule[1]):
                bad_runs.append(print_run)

tot_mid = 0
good_runs = [x for x in print_orders if x not in bad_runs]
for good_run in good_runs:
    tot_mid += good_run[int(len(good_run)/2)]

print(tot_mid)
#148688 too high
#1260854

# part 2
rule_first = []
rule_second = []
for ord_rule in order_rules:
    rule_first.append(ord_rule[0])
    rule_second.append(ord_rule[1])

bad_runs2 = [list(x) for x in set(tuple(x) for x in bad_runs)]
fixed_runs = []
for bad_run in bad_runs2:
    rules_use = []
    for rule in order_rules:
        if rule[0] in bad_run and rule[1] in bad_run:
            rules_use.append(rule)
    rule_second = []
    for rule in rules_use:
        rule_second.append(rule[1])
    fixed_ord = [None] * len(bad_run)
    for page in bad_run:
        num_second = sum(x == page for x in rule_second)
        fixed_ord[num_second] = page
    fixed_runs.append(fixed_ord)

tot_mid2 = 0
for good_run in fixed_runs:
    tot_mid2 += good_run[int(len(good_run)/2)]

print(tot_mid2)
# 406223 is too high