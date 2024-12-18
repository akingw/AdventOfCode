import re

directions = ['up','right','down','left']
guard_path = []

def find_box(strt,dir_ind):
    end_path = False
    dir = directions[dir_ind % len(directions)]
    if dir == "up":
        boxes_path = [box for box in boxes if box['Row'] < strt[0] and box['Col'] == strt[1]]
        if(len(boxes_path) == 0):
            end_path = True
            row_steps = [x for x in range(strt[0],-1,-1)]
            col_steps = [strt[1]] * len(row_steps)
        else:
            box_hit = max(boxes_path, key=lambda x:x['Row'])
            row_steps = [x for x in range(strt[0],box_hit['Row'],-1)]
            col_steps = [strt[1]] * len(row_steps)
        for ind,row in enumerate(row_steps):
            guard_path.append(f"{row},{col_steps[ind]}")
    if dir == "down":
        boxes_path = [box for box in boxes if box['Row'] > strt[0] and box['Col'] == strt[1]]
        if (len(boxes_path) == 0):
            end_path = True
            row_steps = [x for x in range(strt[0],nrow+1)]
            col_steps = [strt[1]] * len(row_steps)
        else:
            box_hit = min(boxes_path, key=lambda x: x['Row'])
            row_steps = [x for x in range(strt[0],box_hit['Row'])]
            col_steps = [strt[1]] * len(row_steps)
        for ind,row in enumerate(row_steps):
            guard_path.append(f"{row},{col_steps[ind]}")
    if dir == "right":
        boxes_path = [box for box in boxes if box['Row'] == strt[0] and box['Col'] > strt[1]]
        if (len(boxes_path) == 0):
            end_path = True
            col_steps = [x for x in range(strt[1],ncol+1)]
            row_steps = [strt[0]] * len(col_steps)
        else:
            box_hit = min(boxes_path, key=lambda x: x['Col'])
            col_steps = [x for x in range(strt[1],box_hit['Col'])]
            row_steps = [strt[0]] * len(col_steps)
        for ind,col in enumerate(col_steps):
            guard_path.append(f"{row_steps[ind]},{col}")
    if dir == "left":
        boxes_path = [box for box in boxes if box['Row'] == strt[0] and box['Col'] < strt[1]]
        if (len(boxes_path) == 0):
            end_path = True
            col_steps = [x for x in range(strt[1],-1,-1)]
            row_steps = [strt[0]] * len(col_steps)
        else:
            box_hit = max(boxes_path, key=lambda x: x['Col'])
            col_steps = [x for x in range(strt[1],box_hit['Col'],-1)]
            row_steps = [strt[0]] * len(col_steps)
        for ind,col in enumerate(col_steps):
            guard_path.append(f"{row_steps[ind]},{col}")
    new_dir = dir_ind + 1
    if not end_path:
        find_box([int(x) for x in guard_path[-1].split(",")],new_dir)

guard_path2 = []
def find_box2(strt,dir_ind):
    end_path = False
    dir = directions[dir_ind % len(directions)]
    dirNext = directions[(dir_ind+1) % len(directions)]
    if dir == "up":
        boxes_path = [box for box in boxes if box['Row'] < strt[0] and box['Col'] == strt[1]]
        if(len(boxes_path) == 0):
            end_path = True
            row_steps = [x for x in range(strt[0],-1,-1)]
            col_steps = [strt[1]] * len(row_steps)
        else:
            box_hit = max(boxes_path, key=lambda x:x['Row'])
            row_steps = [x for x in range(strt[0]-1,box_hit['Row'],-1)]
            col_steps = [strt[1]] * len(row_steps)
        for ind,row in enumerate(row_steps):
            guard_path2.append({'Row':row, 'Col':col_steps[ind],'Dir':dir,
                                'DirNext':dirNext})
    if dir == "down":
        boxes_path = [box for box in boxes if box['Row'] > strt[0] and box['Col'] == strt[1]]
        if (len(boxes_path) == 0):
            end_path = True
            row_steps = [x for x in range(strt[0],nrow+1)]
            col_steps = [strt[1]] * len(row_steps)
        else:
            box_hit = min(boxes_path, key=lambda x: x['Row'])
            row_steps = [x for x in range(strt[0]+1,box_hit['Row'])]
            col_steps = [strt[1]] * len(row_steps)
        for ind,row in enumerate(row_steps):
            guard_path2.append({'Row':row, 'Col':col_steps[ind],'Dir':dir,
                                'DirNext':dirNext})
    if dir == "right":
        boxes_path = [box for box in boxes if box['Row'] == strt[0] and box['Col'] > strt[1]]
        if (len(boxes_path) == 0):
            end_path = True
            col_steps = [x for x in range(strt[1],ncol+1)]
            row_steps = [strt[0]] * len(col_steps)
        else:
            box_hit = min(boxes_path, key=lambda x: x['Col'])
            col_steps = [x for x in range(strt[1]+1,box_hit['Col'])]
            row_steps = [strt[0]] * len(col_steps)
        for ind,col in enumerate(col_steps):
            guard_path2.append({'Row':row_steps[ind], 'Col':col,'Dir':dir,
                                'DirNext':dirNext})
    if dir == "left":
        boxes_path = [box for box in boxes if box['Row'] == strt[0] and box['Col'] < strt[1]]
        if (len(boxes_path) == 0):
            end_path = True
            col_steps = [x for x in range(strt[1],-1,-1)]
            row_steps = [strt[0]] * len(col_steps)
        else:
            box_hit = max(boxes_path, key=lambda x: x['Col'])
            col_steps = [x for x in range(strt[1]-1,box_hit['Col'],-1)]
            row_steps = [strt[0]] * len(col_steps)
        for ind,col in enumerate(col_steps):
            guard_path2.append({'Row':row_steps[ind], 'Col':col,'Dir':dir,
                                'DirNext':dirNext})
    new_dir = dir_ind + 1
    if not end_path:
        find_box2([guard_path2[-1]['Row'],guard_path2[-1]['Col']],new_dir)


with open('Day6Input.txt','r') as data:
    boxes = []
    start_pos = []
    nrow = -1
    for r,line in enumerate(data):
        nrow += 1
        ncol = len(re.findall(r'\S', line))
        for c,col in enumerate(re.findall(r'\S',line)):
            if col == "#":
                boxes.append({'Row':r,'Col':c})
            elif col == "^":
                start_pos = [r,c]

find_box(start_pos,0)

print(f"Part 1: {len(set(guard_path))}")
# 4665 correct

find_box2(start_pos,0)

numRepeat = 0
for ind,path in enumerate(guard_path2):
    for pathPrev in guard_path2[0:(ind-1)]:
        if path['Row'] == pathPrev['Row'] and path['Col'] == pathPrev['Col'] and path['DirNext'] == pathPrev['Dir']:
            numRepeat += 1

print(f"Part 2: {numRepeat}")
# Doesn't work, since it assumes you'll cross your path...but that isn't the case...
