public class Guess {
	
	// Problem 2
	// Pre-Condition: 
	//	guess1, guess2, and price are positive integers.
	// Post Conditions:
	//	It should return the closest guess lower than or equal to the price or return -1.
	public static int guessPrice1(int guess1, int guess2, int price) {
		int best;
		if (guess1 <= price && guess2 <= price) {
			best = guess1;
			if (guess2 > best)
				best = guess2;
		} 
		else
			best = -1;
		return best;
	}
	
	// Problem 3
	// Pre-Condition: 
	//	guess1, guess2, and price are positive integers.
	// Post Conditions:
	//	It should return the closest guess lower than or equal to the price or return -1.
	public static int guessPrice2(int guess1, int guess2, int price) {
		int best = guess1;
		if (guess2 > best)
			best = guess2;
		if (best <= price)
			return best;
		else
			return -1;
	}
}
