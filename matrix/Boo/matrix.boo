m = matrix(int, 3, 512, 512)
seed = 42
for i in range(2):
    for j in range(512):
        for k in range(512):
            m[i, j, k] = seed
            seed *= 25189
            seed %= 32749

sum = 0
for i in range(512):
    for j in range(512):
        for k in range(512):
            m[2, i, j] = m[2, i, j] + m[0, i, k] * m[1, k, j]
            m[2, i, j] = m[2, i, j] % 65536
        sum += ((i * j) % 256) * m[2, i, j]
        sum %= 65536
if len(argv) > 0:
    print(sum)
