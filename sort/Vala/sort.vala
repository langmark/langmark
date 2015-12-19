using Posix;

void main(string[] args)
{
    const int N = 1 << 22;
    bool print_out = false;
    if(args.length >= 2)
        print_out = true;
    int[] v = new int[N];
    int seed = 3;
    for(int i = 0; i < N; i++)
    {
        v[i] = seed;
        seed *= 27487;
        seed %= 30491;
    }
    Posix.qsort(v, v.length, sizeof(int), (a, b) => { return *(int*)a - *(int*)b; } );
    if(print_out)
        GLib.stdout.printf("%d\n", v[279121]);
}
