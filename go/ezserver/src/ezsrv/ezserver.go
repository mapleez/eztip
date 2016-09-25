/*
 * Author : ez
 * Date / 2015/11/20
 *
 * This server struct is a self defined entity.
 * With some special Protocol for a number of 
 * clients. the Protocol should be defined to
 * handle the communication between server and client.
 *
 * To defined the Protocol, implement the ezproto
 * interface. Each server will start main loop with 
 * calling protocol.MainLoop (...)
*/

package ezsrv

import "net"
import "errors"

/*
 * This server is just for
 * Tcp protocol, and I'll 
 * define a little protocol
 * at Application layer,
 * for the cake, a chat in
 * local network  ;)
*/
type Ezserver struct {
  _bindsock *net.TCPListener
  _clients []Ezclient
  _proto    Iezproto_server
  _bindaddr string
}

/*
 * Constructor
*/
func New_ezserver (_addr string, _clnt_num int, _proto Iezproto_server) (*Ezserver) {
  var  this *Ezserver = new (Ezserver)
  this._proto = _proto
  this._clients = make ([]Ezclient, 0, _clnt_num)
  this._bindaddr = _addr
  return this
}

/*
 * Main loop
*/
func (this *Ezserver) StartLoop () {
  if this._proto != nil {
    this._proto.Start_server_loop (this)
  }

}

/*
 * Shutdown Reading Side and send
 * close flag to each client
*/
func (this *Ezserver) ShutdownAll () {

  this._proto.Shutdown_server (this)
  for _, client := range this._clients {
    client._sock.CloseRead ()
  }

}


/*
 * Broadcasting string
*/
func (this *Ezserver) Broadcast (_data []byte, _len int) (int, error) {
  return 0, errors.New ("Broadcast error.")
}

/*
 * Print client information registed in this server entity
*/
func (this *Ezserver) Listclient () {
  println ("None of them were registed here :(")
}

/*
 * Shutdown one client which client number equals _clnt_num
*/
func (this *Ezserver) Shutdown_one (_clnt_num int) (bool, error) {
  return false, errors.New ("I'v tried my best to shutdown !")
}

