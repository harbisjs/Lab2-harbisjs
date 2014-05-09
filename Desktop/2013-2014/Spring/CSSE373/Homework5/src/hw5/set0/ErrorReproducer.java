package hw5.set0;

public class ErrorReproducer {
	public static void main(String[] args) {
		// TODO: Reproduce the error reported by Alloy here
		Point p = new Point(1,1);
		boolean result = p.equals(null);
		
		System.out.println("Expected: False, Actual: "+ result);
	}
}
