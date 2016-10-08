class point (xi: Int, yi: Int) {
	private var x: Int = xi
	private var y: Int = yi

	def disp () {
		println ("(" + this.x + "," + this.y + ")");
	}

	def move (alphaX: Int, alphaY: Int) {
		this.x += alphaX;
		this.y += alphaY;
	}

	def getX () = this.x
	def getY () = this.y
}
