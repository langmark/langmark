void main(string[] args)
{
    const int N = 512;
    bool print_value = false;
    if(args.length == 2)
        print_value = true;
    int seed = 42;
    int sum = 0;
    int[,,] matrix = new int[3,N,N];
    for(int i = 0; i < 2; i++)
    {
        for(int j = 0; j < N; j++)
        {
            for(int k = 0; k < N; k++)
            {
                matrix[i,j,k] = seed;
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
                matrix[2,i,j] += matrix[0,i,k] * matrix[1,k,j];
                matrix[2,i,j] &= 0xFFFF;
            }
            sum += ((i * j) & 0xFF) * matrix[2,i,j];
            sum &= 0xFFFF;
        }
    }
    if(!print_value)
        return;
    stdout.printf("%d\n", sum);
}
