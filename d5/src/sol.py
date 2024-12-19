import re
from typing import List, Dict

"""

"""
def check_page( page ):
    bef = []
    valid = 0

    for (i,n) in enumerate(page):
        aft = page[i+1:]

        if check_afters(n, aft) and check_befores( n, bef ):
            valid += 1

        bef.append(n)
    
    return valid == len(page)

"""

"""
def check_befores( n, bef ):
    ruleset = rules[n]
    
    if ruleset is None:
        return True

    a = ruleset["aft"]

    for b in bef:
        if b in a:
            return False

    return True 


"""

"""
def check_afters ( n, aft ):
    ruleset = rules[n]
    
    if ruleset is None:
        return True

    a = ruleset["bef"]

    for b in aft:
        if b in a:
            return False

    return True 


def make_valid ( page ):
    valid = 0

    print(page)
        
    lens = [] 
    for (i,n) in enumerate(page):
        bef = rules[n]["bef"]
        aft = rules[n]["aft"]
        bef = [ x for x in bef if x in page ] 
        aft = [ x for x in aft if x in page ] 
        lens.append(len(bef)) 

    res = [None] * len(page)
    i = 0
    for n in lens:
        res[n] = page[i]
        i+=1
    
    return res






f = open("../assets/input_1.txt", "r")

# lines = f.read()
lines = f.readlines()

f.close()

x = re.findall("(\d+)\|(\d+)", "\n".join(lines))

rules: List[Dict[str, List[int]]]   = [None] * 100

for (x,y) in x:
    x = int(x)
    y = int(y)
    
    if not rules[x] :
        rules[x] = { "aft": [ y ], "bef": [ ] }
    else: 
        rules[x]["aft"].append( y )

    if not rules[y] :
        rules[y] = { "aft": [ ], "bef": [x] }
    else: 
        rules[y]["bef"].append( x )

passed = False
pages = []
for l in lines:

    if not l.strip():
        passed = True
        continue

    if passed:
        pages.append( [int(x) for x in l.split(",")] )

s = 0
for p in pages:
    if not check_page(p):
        n = make_valid(p)
        s += n[ len(n) // 2 ]
print (s)