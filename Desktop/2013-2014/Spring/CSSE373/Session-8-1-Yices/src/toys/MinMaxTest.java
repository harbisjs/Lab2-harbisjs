package toys;

public class MinMaxTest {
	// See the modeling of this method in modules/min1.ys 
	// Pre-Condition: a and b are integers
	// Post-Condition: rv <= a and rv <= b
	public static int min(int a, int b) {
		int min = a;
		if(min < b)
			min = b;
		return min;
	}

	// Q3: Verify the correctness of this method
	public static int max(int a, int b) {
		if(a > b)
			return a;
		return b;
	}
	
	// Q4: Verify the correctness of this method
	public static int min(int a, int b, int c) {
		if(a < b && b < c)
			return a;
		if(b < a && a < c)
			return b;
		return c;
	}
	
	
	// Q5: Verify the correctness of this method
	public static int max(int a, int b, int c) {
		int max = a;
		if(b > max)
			max = b;
		if(c > max)
			max = c;
		return max;
	}
}
