use std::env;

fn main() {
	let mut seed = 3;
	let mut vec = Vec::with_capacity(4194304);
	
	for n in 0..4194304 {
		vec.push(seed);
		seed = seed * 27487;
		seed = seed % 30491;
	}
	
	vec.sort();
	
	let args: Vec<_> = env::args().collect();
	if args.len() > 1 {
		println!("{}", vec[279121]);
	}
}
