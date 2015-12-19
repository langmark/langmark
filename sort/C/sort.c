#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define N (1 << 22)

int cmp(const void* a, const void* b)
{
    return *(int*)a - *(int*)b;
}

int main(int argc, char* argv[])
{
    bool print_out = false;
    if(argc >= 2)
        print_out = true;
    int* v = malloc(N * sizeof(int));
    int seed = 3;
    for(int i = 0; i < N; i++)
    {
        v[i] = seed;
        seed *= 27487;
        seed %= 30491;
    }
    qsort(v, N, sizeof(int), cmp);
    if(print_out)
        printf("%d\n", v[279121]);
    return 0;
}
