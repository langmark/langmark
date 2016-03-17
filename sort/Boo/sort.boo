v = array(int, 4194304)

seed = 3
for i in range(4194304):
    v[i] = seed
    seed *= 27487
    seed %= 30491

System.Array.Sort(v)

if len(argv) > 0:
    print(v[279121])
