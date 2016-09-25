package main

import (
    _ "github.com/bmizerany/pq"
    "database/sql"
)

var strings []string = [] string{
  "123456",
  "string",
  "int",
  "go",
  "func",
  "return",
  "if",
  "else",
  "for",
  "interface",
  "chan",
  "struct",
  "type",
  "nil",
  "var",
}

func main () {
  db, err := sql.Open ("postgres", "user=psqluser password=waq520 dbname=exampledb sslmode=disable")
  if err != nil {
    println ("error: ", err.Error ())
    return
  }
  println ("connect ok.") //  -

  // query
  rows, ok := db.Query ("select * from psqluser_tb")
  if ok != nil {
    println ("error: ", err.Error ())
    return
  }

  println ("query ok.") // -

  for rows.Next () {
    var uid int
    var value string

    err = rows.Scan (&uid, &value)
    if err != nil {
      println ("Error: ", err.Error ())
    }
    println (uid, " ", value)

  }

  // insert
  statement, err := db.Prepare ("insert into psqluser_tb (id, value) values ($1, $2)")
  for i, v := range strings {
    if err != nil {
      println ("Error: ", err.Error ())
    }

    result, ok := statement.Exec (i, v);
    if ok != nil {
      println ("Error: ", ok.Error ())
    }

    affected, _ := result.RowsAffected ()
    println ("Insert one, affected: ", affected)

  }

  // update
  statement, err = db.Prepare ("update psqluser_tb set value = $1 where id = $2")
  result, ok := statement.Exec ("fuck", 2)
  if ok != nil {
    println ("Error: ", ok.Error ())
  }

  affected, _ := result.RowsAffected ()
  println ("Update one, affected: ", affected)

  // delete
  // statement, err = db.Prepare ("Delete from psqluser_tb")
  // result, ok = statement.Exec ()
  // if ok != nil {
  //   println ("Error: ", ok.Error ())
  // }

  // affected, _ = result.RowsAffected ()
  // println ("delete all, affected: ", affected)

//   if err != nil {
//     println (err.Error ())
//     return
//   } else {
//     rows, _ := db.Query ("Select * from psqluser_tb")
//     columns, _ := rows.Columns ()
//     for _, v := range columns {
//       println (v)
//     }
// 
//   }

}
