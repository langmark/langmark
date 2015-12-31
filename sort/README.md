# Sort

This benchmark tests the native `sort` function for every programming language. 

The program should generate the a vector according to the following pseudo-code
```
vector[4194304]
seed = 3
for i in [0; 4194304)
    vector[i] = seed
    seed = seed * 27487
    seed = seed % 30491
end for
```

Then execute the native `sort` algorithm.

If the program received at least one command line argument then it should print the following information
```
print(vector[279121])
```
