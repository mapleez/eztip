package dt.ez.struct

import dt.ez.traits.similarity

class point (xi: Int, yi: Int) extends similarity {
	var x: Int = xi
	var y: Int = yi

	def + (alphaX: Int, alphaY: Int) = {
	 	this.x += alphaX;
	 	this.y += alphaY;
	}

	def move (alphaX: Int, alphaY: Int) {
		this.x += alphaX;
		this.y += alphaY;
	}

	def getX () = this.x
	def getY () = this.y

  override def toString () : String = 
		"(" + x + "," + y + ")"

	def == (p: point) : Boolean = isSimilar (p)

	def isSimilar (x: Any): Boolean = {
		var simi = x.isInstanceOf [point];
		val obj = x.asInstanceOf [point];
		simi &&= (obj.x == this.x && 
			obj.y == this.y)
		simi
	}
}

object point {
	def main (args: Array [String]) : Unit = {
		val pt = new point (1, 2);
		val pt1 = new point (24, 45);
		println (pt);
		pt.move (23, 43);
		println (pt);
		println (pt.isSimilar (pt1));
	}
}

