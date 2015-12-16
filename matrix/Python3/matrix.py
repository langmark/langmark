import sys

N = 512
print_value = False
if len(sys.argv) >= 2:
    print_value = True
seed = 42
sum = 0
matrix = [[[0 for i in range(N)] for i in range(N)] for i in range(3)]
for i in range(2):
    for j in range(N):
        for k in range(N):
            matrix[i][j][k] = seed
            seed *= 25189
            seed %= 32749
matrix.append([[0 for i in range(N)] for i in range(N)])
for i in range(N):
    for j in range(N):
        for k in range(N):
            matrix[2][i][j] += matrix[0][i][k] * matrix[1][k][j]
            matrix[2][i][j] &= 0xFFFF
        sum += ((i * j) & 0xFF) * matrix[2][i][j]
        sum &= 0xFFFF
if print_value:
    print(sum)

