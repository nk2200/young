<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resource/css/login.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
// URL에서 쿼리 파라미터를 추출하는 함수

	function getQueryParam(param) {
		var urlParams = new URLSearchParams(window.location.search);
		return urlParams.get(param);
	}
	$(document).ready(function() {
		var message = getQueryParam('message');
		if (message) {
			alert(message);
			console.log(message);
		}
	});
</script>
</head>
<body>
 <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3 style="text-align: center;">회원가입</h3>
          <form method="post" action="/customer/Login.do?action=signup">
           <label for="customer_name">Name</label>
            <input type="text" name="customer_name" id="name" placeholder="이름">

            <label for="customerid">ID</label>
            <input type="text" name="customerid" id="customerid" placeholder="아이디">

            <label for="password">Password</label>
            <input type="password" name="password" id="password" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;">
			
			<label for="customer_address">Address</label>
            <input type="text" name="customer_address" id="address" placeholder="주소">
            
            <div id="form-controls">
              <button type="submit">Sign Up</button>
              <button type="button" id="toggleSignIn" onclick="window.location.href='/customer/Login.do';">Sign In</button>
            </div>

            <input type="checkbox" name="terms" id="terms">
            <label for="terms">I agree to the <a href="#" class="termsLink">Terms of service</a> and <a href="#" class="termsLink">Privacy Policy</a>.</label>
          </form>
        </div>

        <!-- Lottie animation -->
<!--         <div id="animation-container">
          <lottie-player src="https://assets3.lottiefiles.com/packages/lf20_aesgckiv.json"  background="transparent"  speed="1"  style="width: 520px; height: 520px;" loop autoplay></lottie-player>
        </div> -->
      </div>
  </div>

  

  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
  <script type="text/JavaScript" src="./my-script.js"></script>

</body>
</html>