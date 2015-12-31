import std.stdio;

void main(string[] args) {
    int[3][512][512] matrix;
    int seed = 42;
    int sum = 0;

    for (int i = 0; i < 2; i++) 
        for (int j = 0; j < 512; j++)
            for (int k = 0; k < 512; k++) {
                matrix[j][k][i] = seed;
                seed = seed * 25189;
                seed = seed % 32749;
            }
    for(int i = 0; i < 512; i++) {
        for(int j = 0; j < 512; j++) {
            for(int k = 0; k < 512; k++) {
                matrix[i][j][2] += matrix[i][k][0] * matrix[k][j][1];
                matrix[i][j][2] &= 0xFFFF;
            }
            sum += ((i * j) & 0xFF) * matrix[i][j][2];
            sum &= 0xFFFF;
        }
    }
    if(args.length >= 2)
        stdout.writeln(sum);
}
