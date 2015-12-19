import java.util.ArrayList;
import java.util.Collections;

public class sort
{
    public static final int N = 1 << 22;
    public static void main(String[] args)
    {
        boolean print_out = false;
        if(args.length >= 1)
            print_out = true;
        ArrayList<Integer> v = new ArrayList<Integer>();
        int seed = 3;
        for(int i = 0; i < N; i++)
        {
            v.add(seed);
            seed *= 27487;
            seed %= 30491;
        }
        Collections.sort(v);
        if(print_out)
            System.out.println(v.get(279121));
    }
}
