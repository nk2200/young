<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3>Get Started</h3>
          <form>
            <label for="name">Name</label>
            <input type="text" name="name" id="name" placeholder="Name">

            <label for="email">Email</label>
            <input type="email" name="email" id="email" placeholder="Email">

            <label for="password">Password</label>
            <input type="password" name="password" id="password" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;">

            <div id="form-controls">
              <button type="submit">Sign Up</button>
              <button type="button" id="toggleSignIn">Sign In</button>
            </div>

            <input type="checkbox" name="terms" id="terms">
            <label for="terms">I agree to the <a href="#" class="termsLink">Terms of service</a> and <a href="#" class="termsLink">Privacy Policy</a>.</label>
          </form>
        </div>

        <!-- Sign in form -->
        <div id="sign-in-container" class="hide">
          <h3>Welcome Back</h3>
          <form>
            <label for="username">Username</label>
            <input type="text" name="username" id="username" placeholder="user@example.com">

            <label for="password">Password</label>
            <input type="password" name="password" id="password" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;">

            <div id="form-controls">
              <button type="submit">Sign In</button>
              <button type="button" id="toggleSignUp">Sign Up</button>
            </div>

            <input type="checkbox" name="terms" id="terms">
            <label for="terms">I agree to the <a href="#" class="termsLink">Terms of service</a> and <a href="#" class="termsLink">Privacy Policy</a>.</label>
          </form>
        </div>

        <!-- Lottie animation -->
        <div id="animation-container">
          <lottie-player src="https://assets3.lottiefiles.com/packages/lf20_aesgckiv.json"  background="transparent"  speed="1"  style="width: 520px; height: 520px;" loop autoplay></lottie-player>
        </div>
      </div>
  </div>

  

  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
  <script type="text/JavaScript" src="./my-script.js"></script>

</body>
</html>