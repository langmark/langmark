use std::env;

fn main() {
	const N: usize = 512;
	let mut matrix = [[[0; N]; N]; 3];
    let mut seed = 42;
    let mut sum = 0;
	for i in 0..2 {
		for j in 0..N {
			for k in 0..N {
				matrix[i][j][k] = seed;
                seed *= 25189;
                seed %= 32749;
			}
		}
	}
	for i in 0..N {
		for j in 0..N {
			for k in 0..N {
				matrix[2][i][j] += matrix[0][i][k] * matrix[1][k][j];
                matrix[2][i][j] &= 0xFFFF;
			}
			sum += ((i * j) & 0xFF) * matrix[2][i][j];
            sum &= 0xFFFF;
		}
	}
	let args: Vec<_> = env::args().collect();
	if args.len() > 1 {
		println!("{}", sum);
	}
}
