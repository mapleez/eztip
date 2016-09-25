package ezpsql
// package main

import (
    _ "github.com/bmizerany/pq"
    "database/sql"
)

type Psqlengine struct {
  _connstr string
  _db *sql.DB
  _stmt *sql.Stmt
}

// constructor
func New_psqlengine (_host, _usr, _pwd, _dbname, _sslmode string) *Psqlengine {
  var res *Psqlengine = new (Psqlengine)
  res._connstr = "user=" + _usr + " password=" + _pwd + " dbname=" + _dbname +
    " sslmode=" + _sslmode
  return res
}

// open db connection
func (this *Psqlengine) open_db () error {
  var err error = nil
  this._db, err = sql.Open ("postgres", this._connstr)
  return err
}

// close db connection
func (this *Psqlengine) close_db () error {
  var err error = nil
  err = this._db.Close ()
  return err
}

// execute Psql
func (this *Psqlengine) Execute (_sql string, _args ...interface {}) (*sql.Result, error) {
  var err error
  var args [] interface {} = [] interface {} (_args)
  // open database
  if openerr := this.open_db (); openerr != nil {
    return nil, openerr
  }

  // prepare
  this._stmt, err = this._db.Prepare (_sql)
  if err != nil {
    return nil, err
  }

  // execution
  result, ok := this._stmt.Exec (args ...)
  if ok != nil {
    return nil, ok
  }

  // close database
  if closeerr := this.close_db (); closeerr != nil {
    return nil, closeerr
  }

  return &result, nil
}

// execute query
func (this *Psqlengine) ExecuteQuery (_sql string) (*sql.Rows, error) {
  // open db
  if openerr := this.open_db (); openerr != nil {
    return nil, openerr
  }

  // query db
  rows, ok := this._db.Query (_sql)
  if ok != nil {
    return nil, ok
  }

  // close db
  if closeerr := this.close_db (); closeerr != nil {
    return nil, closeerr
  }

  return rows, ok
}


// execute query string with arguments
func (this *Psqlengine) ExecuteQuery_Args (_sql string, _args ...interface{}) (*sql.Rows, error) {
  var err error
  var args [] interface {} = [] interface {} (_args)
  // open db
  if openerr := this.open_db (); openerr != nil {
    return nil, openerr
  }

  // prepare
  this._stmt, err = this._db.Prepare (_sql)
  if err != nil {
    return nil, err
  }

  // query
  res, reserr := this._stmt.Query (args...)
  if reserr != nil {
    return nil, reserr
  }

  // close db
  if closeerr := this.close_db (); closeerr != nil {
    return nil, closeerr
  }

  return res, reserr
}

// for unit testing...
// func main () {

  /*
  var engine *Psqlengine = New_psqlengine ("", "psqluser", "waq520", "exampledb", "disable")
  _, err := engine.Execute ("insert into psqluser_tb (id, value) values ($1, $2)", 1010, "string")
  if err != nil {
    println ("insert error: ", err.Error ())
    return
  }
  */

  // select 
  /*
  sets, err := engine.ExecuteQuery ("select * from psqluser_tb")
  if err != nil {
    println ("Select error: ", err.Error ())
    return
  }

  println ("start print.")
  for sets.Next () {
    var uid int
    var value string

    err = sets.Scan (&uid, &value)
    if err != nil {
      println ("Error: ", err.Error ())
    }
    println (uid, " ", value)
  }
  */

  // selection with condition
  /*
  sets, err := engine.ExecuteQuery_Args ("select * from psqluser_tb where id = $1", 100)
  if err != nil {
    println ("Select error: ")
  }
  for sets.Next () {
    var uid int
    var value string

    err = sets.Scan (&uid, &value)
    if err != nil {
      println ("Error: ", err.Error ())
    }
    println (uid, " ", value)
  }
  */

// }
