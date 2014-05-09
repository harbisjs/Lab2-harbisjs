module LinearSolver

one sig x,y in Int{}

pred solve[] {
	// TODO: Specify your constraints here
	x.plus[y.mul[2]] = 7
	x.mul[2].minus[y]=4
}
	
run solve for 8 Int
