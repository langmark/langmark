# Matrix Multiplication

This benchmark is about square matrices multiplication. 

The program should generate the 2 matrices according to the following pseudo-code
```
matrix[2][512][512]
seed = 42
for i in [0; 2)
    for j in [0; 512)
        for k in [0; 512)
            matrix[i][j][k] = seed
            seed = seed * 25189
            seed = seed % 32749
        end for
    end for
end for
```

Then execute the common `O(n³)` matrices multiplication algorithm.

If the program received at least one command line argument then it should print the following information
```
result_matrix[512][512]
... # Matrices multiplication algorithm
sum = 0
for i in [0; 512)
    for j in [0; 512)
        sum = sum + (((i * j) % 256) * result_matrix[i][j])
        sum = sum % 65536
    end for
end for
print(sum)
```
