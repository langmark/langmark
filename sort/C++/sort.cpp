#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

#define N (1 << 22)

int main(int argc, char* argv[])
{
    bool print_out = false;
    if(argc >= 2)
        print_out = true;
    vector<int> v(N);
    int seed = 3;
    for(int i = 0; i < N; i++)
    {
        v[i] = seed;
        seed *= 27487;
        seed %= 30491;
    }
    sort(v.begin(), v.end());
    if(print_out)
        cout << v[279121] << endl;
    return 0;
}
