import java.lang.NullPointerException;

public class eztuple <K extends java.lang.Object, V> {

	private K key;
	private V value;

	public eztuple () {}

	public eztuple (K key, V value) {
		this.key = key;
		this.value = value;
	}

	public int cmp (K key) 
		throws NullPointerException {
		if (this.key != null)
			return this.key.compareTo (key); // error!
		else 
			throw new NullPointerException ();
	}

	public void disp () {
		System.out.println ((key != null ? key.toString () : "null") + 
			" -> " + (value != null ? value.toString () : "null"));
	}

	public static void main (String[] args) {
		eztuple tuple = new eztuple <Float, Integer> 
			(Float.parseFloat ("0.32"), Integer.parseInt ("32324"));
		tuple.disp ();
	}

}
