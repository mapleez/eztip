package main
import "ezsrv"

func main () {

  var chatproto ezsrv.Iezproto = new (ezsrv.Ezchatproto)
  var ezclient *ezsrv.Ezclient = ezsrv.New_ezclient ("127.0.0.1:5959", chatproto)
  ezclient.Start ()
  ezclient.End ()
  println ("Hie :)")

}
