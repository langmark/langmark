#include <cstdlib>
#include <iostream>

#define N 512

using namespace std;

int matrix[3][N][N];

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
                matrix[2][i][j] += matrix[0][i][k] * matrix[1][k][j];
                matrix[2][i][j] &= 0xFFFF;
            }
            sum += ((i * j) & 0xFF) * matrix[2][i][j];
            sum &= 0xFFFF;
        }
    }
    if(!print_value)
        return EXIT_SUCCESS;
    cout << sum << endl;
    return EXIT_SUCCESS;
}
