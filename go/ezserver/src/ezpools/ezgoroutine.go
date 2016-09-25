package ezpools

// import "fmt"
import "ezsrv"

type Handler struct {
	_srv *ezsrv.Ezserver
	_buffs chan []byte
}

const MaxBufferNumber := 8

func New_Handler (_buff_num int, _srv *ezsrv.Ezserver) *Handler, error
{
	if _buff_num > MaxBufferNumber || _buff_num <= 0{
		return nil, errors.New ("Buffer number must less than 8 and bigger than 0.")
	}

	var res Handler = Handler {
		_srv, make (chan [] byte, _buff_num)
	}

	return &res
}

func (this *Handler) StartHandle () {
}

