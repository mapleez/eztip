package ezsrv

import "net"

// stands for a client endpoint entity.
type Ezclient struct {

  _num int
  _sock *net.TCPConn
  _remote_addr string
  _wbuff []byte
  _rbuff []byte
  _proto Iezproto_client
  _trans int

}


/*
 * Constructor
*/
func New_ezclient (_remote_addr string, _proto Iezproto_client) *Ezclient {

  var this *Ezclient = new (Ezclient)
  this._remote_addr = _remote_addr
  this._proto = _proto
  this._num = -1 // this client has not registed at server.
  return this

}

/*
 * Start the client and connect server
*/
func (this *Ezclient) Start () {

  if this._proto != nil {
    this._proto.Start_client_loop (this)
  }

}

/*
 * End the client and log out from server
*/
func (this *Ezclient) End () {
  if this._proto != nil {
    this._proto.End_client_loop (this)
  }
}

