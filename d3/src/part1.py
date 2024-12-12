import re

f = open("../assets/input_1.txt", "r")
co = f.readlines()
co = ",".join(co)
f.close()

x  = re.findall("mul\((\d{1,3}),(\d{1,3})\)", co)

s = 0
for (l,r) in x:
    s += (int(l) * int(r))

print(s)

# Part 1 done

segments = re.findall("mul\((\d+),(\d+)\)|(do\(\))|(don't\(\))", co)

msol = 0
en = True

for l,r,do,dont in segments:
    en = ( en and (not dont) ) or bool(do) 
    if en and l:
        print(en, l, r)
        msol += int(l) * int(r)
print(msol)



