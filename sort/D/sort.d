import std.stdio;
import std.algorithm;

void main(string[] args)
{
    const int N = 1 << 22;
    int[] v = new int[N];
    int seed = 3;
    for(int i = 0; i < N; i++)
    {
        v[i] = seed;
        seed *= 27487;
        seed %= 30491;
    }
    sort(v);
    if(args.length >= 2)
        stdout.writeln(v[279121]);
}
