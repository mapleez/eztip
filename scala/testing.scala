object testing {

	def test_point () {
		val pt = new point (23, 32)
		pt.disp ()
		pt.move (32, -3)
		pt.disp ()
	}

	def test_function () {
		println (new function ().addInt (32,7891))
	}

	def test_hello () {
	}

	def main (args : Array [String]) : Unit = {
		test_function ()
	}
}

