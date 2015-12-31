var seed: Int = 3
var v_size: Int = 1 << 22
var v: [Int] = []
for i in 0..<v_size
{
    v.append(seed)
    seed *= 27487
    seed %= 30491
}
v.sortInPlace()
if Process.arguments.count >= 2
{
    print(v[279121])
}
