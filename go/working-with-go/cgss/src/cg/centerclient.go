package cg

import (
    "errors"
    "encoding/json"
    "ipc"
)

type CenterClient struct {
  *ipc.IpcClient
}

func (this* CenterClient) AddPlayer (player *Player) error {
  b, err := json.Marshal (*player)
  if err != nil {
    return err
  }

  resp, err := this.Call ("addplayer", string (b))
  if err == nil && resp.Code == "200" {
    return nil
  }

  return err
}


func (this* CenterClient) RemovePlayer (_name string) error {
  ret, _ := this.Call ("removeplayer", _name)
  if ret.Code == "200" {
    return nil
  }
  return errors.New (ret.Code)

}

func (this *CenterClient) ListPlayer (_params string) (_ps []* Player, _err error) {
  resp, _ := this.Call ("listplayer", _params)
  if resp.Code != "200" {
    _err = errors.New (resp.Code)
    return
  }

  _err = json.Unmarshal ([] byte (resp.Body), &_ps)
  return
}

func (this *CenterClient) Broadcast (_msg string) error {
  m := &Message {Content:_msg}
  b, err := json.Marshal (m)
  if err != nil {
    return err
  }

  resp, _ := this.Call ("broadcast", string (b))

  if resp.Code == "200" {
    return nil
  }

  return errors.New (resp.Code)
}


