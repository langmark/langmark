using System;
using System.Collections.Generic;

public class sort
{
    public const int N = 1 << 22;
    public static void Main(string[] args)
    {
        bool print_out = false;
        if(args.Length >= 1)
            print_out = true;
        List<int> v = new List<int>();
        int seed = 3;
        for(int i = 0; i < N; i++)
        {
            v.Add(seed);
            seed *= 27487;
            seed %= 30491;
        }
        v.Sort();
        if(print_out)
            Console.WriteLine(v[279121]);
    }
}
