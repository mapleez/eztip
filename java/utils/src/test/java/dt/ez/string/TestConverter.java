package dt.ez.string;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import java.io.StringReader;
import java.io.Reader;


/**
 * Unit test for string.Converter
 */
public class TestConverter 
    extends TestCase {
    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public TestConverter ( String testName ) {
        super ( testName );
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite () {
        return new TestSuite (TestConverter.class);
    }

    /**
     * Rigourous Test :-)
     */
    public void test_hex2i () {
			int c = -1;
			String buff = "abcednkjafeanl48713eq321";
			StringReader reader = new StringReader (buff);
			try {
				while ((c = reader.read ()) != -1) {
					System.out.printf ("%c = %d\n", (char) c, 
						Converter.hex2i ((char) c));
				}
			} catch (Exception ex) {
				ex.printStackTrace ();
			}
    }
}
