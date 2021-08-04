% if {!logged_in} {
      <h1>Login</h1>
      <form action="" method="POST">
          <label for="username">Username:</label>
          <input type="text" name="username" id="username" required="" placeholder="kwercfan42" value="%(`{echo $^p_username | escape_html}%)">

          <label for="password">Password:</label>
          <input type="password" name="password" id="password" required="" placeholder="••••••••••••••••">

          <button type="submit">Login</button>
      </form>

      <p>Don't have an account yet?</p>
      <a href="/register">Register</a>
% } {
      <h1>Login</h1>
      <p>You're already logged in!</p>
      <a href="/logout">Logout</a>
% }
