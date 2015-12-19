import sys

N = 1 << 22
print_out = False
if len(sys.argv) >= 2:
    print_out = True
v = [None] * N
seed = 3
for i in range(N):
    v[i] = seed
    seed *= 27487
    seed %= 30491
v.sort()
if print_out:
    print(v[279121])
