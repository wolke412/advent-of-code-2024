file = open( "../assets/input_1.txt", "r" )

l = file.readlines()

# Grid definition
grid = l
file.close()

h = len(grid)
w = len(grid[0]) - 1

directions = [(0, -1), (1, 0), (0, 1), (-1, 0)]  # u, r, d, l

start_pos = (0,0)
start_dir = 0  

for r in range(h):
    for c in range(w):
        if grid[r][c] == '^':
            start_pos = (r, c)


print(h, w)
print(start_pos)
print(start_dir)

def simulate_with_obstacle(r, c):

    visited = set()  
    x, y = start_pos
    dir_idx = start_dir

    while True:
        
        if (x, y, dir_idx) in visited:
            return True  

        visited.add( (x,y,dir_idx ) ) 
        
        dx, dy = directions[dir_idx]
        x2 = x + dx
        y2 = y + dy
        
        if (x2 < 0 or y2 < 0) or (x2 >= w or y2 >= h ):
            break

        if grid[y2][x2] == "#" or x2==c and y2==r:
            dir_idx = (dir_idx + 1) % 4  
        else:
            x = x2
            y = y2

    return False  

loop_positions = []
for r in range(h):
    for c in range(w):
        if simulate_with_obstacle(r, c):
            loop_positions.append((r, c))

for pos in loop_positions:
    print(pos)

print("Total pos: " , len(loop_positions))