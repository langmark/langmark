#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define N 512

int matrix[2][N][N];

int main(int argc, char* argv[])
{
    bool print_value = false;
    if(argc == 2)
        print_value = true;
    int seed = 42;
    int sum = 0;
    for(int i = 0; i < 2; i++)
    {
        for(int j = 0; j < N; j++)
        {
            for(int k = 0; k < N; k++)
            {
                matrix[i][j][k] = seed;
                seed *= 25189;
                seed %= 32749;
            }
        }
    }
    for(int i = 0; i < N; i++)
    {
        for(int j = 0; j < N; j++)
        {
            for(int k = 0; k < N; k++)
            {
                sum += matrix[0][i][k] * matrix[1][k][j];
                sum &= 0x0000FFFF;
            }
        }
    }
    if(!print_value)
        return EXIT_SUCCESS;
    printf("%d\n", sum);
    return EXIT_SUCCESS;
}
