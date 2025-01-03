<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resource/css/login.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
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
		
/* 		var message_out_session = $('#message').val();
		if(message_out_session){
			alert(message_out_session);
			console.log(message_out_session);
		} */
	});
</script>
</head>
<body>
 <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3 style="text-align: center;">로그인</h3>
          <form method="post" action="/customer/Login.do?action=login">
<!--             <label for="name">Name</label>
            <input type="text" name="name" id="name" placeholder="Name">
 -->
            <label for="customerid">ID</label>
            <input type="text" name="customerid" id="email" placeholder="아이디">

            <label for="password">Password</label>
            <input type="password" name="password" id="password" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;">

            <div id="form-controls">
              <button type="submit">Sign In</button>
              <button type="button" id="toggleSignIn" onclick="window.location.href='/customer/Login.do?action=signup';">Sign Up</button>
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
  
  <c:if test="${not empty message}">
  <span id="message" >${message }</span>
  </c:if>

  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
  <script type="text/JavaScript" src="./my-script.js"></script>

</body>
</html>