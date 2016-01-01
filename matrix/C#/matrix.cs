using System;

public class matrix
{
    public static void Main(string[] args)
    {
        bool print_out = false;
        if(args.Length >= 1)
            print_out = true;
        int[,,] matrix = new int[3,512,512];
        int sum = 0;
        int seed = 42;

        for(int i = 0; i < 2; i++)
        {
            for(int j = 0; j < 512; j++)
            {
                for(int k = 0; k < 512; k++)
                {
                    matrix[i,j,k] = seed;
                    seed *= 25189;
                    seed %= 32749;
                }
            }
        }
        for(int i = 0; i < 512; i++)
        {
            for(int j = 0; j < 512; j++)
            {
                for(int k = 0; k < 512; k++)
                {
                    matrix[2,i,j] += matrix[0,i,k] * matrix[1,k,j];
                    matrix[2,i,j] &= 0xFFFF;
                }
                sum += ((i * j) & 0xFF) * matrix[2,i,j];
                sum &= 0xFFFF;
            }
        }
        if(print_out)
            Console.WriteLine(sum);
    }
}
