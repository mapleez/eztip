object hello {
	def main (args : Array [String]) : Unit = {
		// println ("Hello, World!");
		val pt = new point (23, 32)
		pt.disp ()
		pt.move (32, -3)
		pt.disp ()
	}
}

