import os
import algorithm

const v_size: int = 4194304
var v: array[v_size, int]
var seed: int = 3
var i: int = 0
while i < v_size:
    v[i] = seed
    seed = seed * 27487
    seed = seed mod 30491
    i = i + 1
algorithm.sort(v, system.cmp[int])
if paramCount() > 0:
    echo v[279121]
