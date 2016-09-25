<!DOCTYPE html>

<html>
  <head>
    <title>Go web testing.</title>
  </head>

  <body>
    <form action="http://192.168.8.46:9090/login" method="post">
      <div>
			<h1></h1>
        <ul>
        <li type="circle">name: <input type="text" name="username" /></li>
        <li type="circle">password: <input type="password" name="password" /></li>
        <li><input type="submit" value="login"/></li>
        <li><input type="hidden" value="{{.}}"/></li>
      </div>
    </form>
  </body>

</html>
