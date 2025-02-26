<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
<script src="/resource/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="/resource/css/bootstrap.min.css"
   type="text/css">
<link rel="stylesheet" href="/resource/css/login.css" />
<script type="text/javascript">
	$(document).ready(function() {
		$('button[type="submit"]').click(function(e){
			e.preventDefault();
			console.log("작동");
			var customer_name = $('#customer_name').val();
			var customerid = $('#customerid').val();
			var password = $('#password').val();
			var customer_address = $('#customer_address').val();
			if(customer_name&&customerid&&password){
				var url = "/customer/Login.do?action=signup";
				$.ajax({
					url : url,
					method : 'POST',
					data : {
						customer_name: customer_name,
						customerid : customerid,
						password : password,
						customer_address : customer_address
					},
					success : function(response){
						console.log('success:',response);
						if(response.result=="success"){
							var message = response.message;
							//모달
							// 모달에 메시지 설정
	                        $('#modal-body').text(message);

	                        $('#myModal').modal('show');

	                        // 모달이 닫힌 후 페이지를 새로고침
	                        $('#myModal').on('hidden.bs.modal', function () {
								window.location.href="/customer/Login.do";
	                        });
						}else{
							var message = "회원가입 실패..!";
							$('#modal-body').text(message);

	                        $('#myModal').modal('show');

	                        // 모달이 닫힌 후 페이지를 새로고침
	                        $('#myModal').on('hidden.bs.modal', function () {
								window.location.reload();
	                        });
						}
					},
					error : function(xhr, status, error) {
						console.error('Error:', error);
					}
				});
				
			}else{
				//제대로 입력하라는 모달
				var message = "아이디와 비밀번호와 이름 모두 입력해주세요.";
				//모달
				// 모달에 메시지 설정
	            $('#modal-body').text(message);

	            $('#myModal').modal('show');
	            
	         // 모달이 닫힌 후 페이지를 새로고침
	            $('#myModal').on('hidden.bs.modal', function () {
	            	location.reload();
	            });// js 부분
			}	
		})
	});
</script>
</head>
<body>
 <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
        <div id="sign-up-container">
          <h3 style="text-align: center;">회원가입</h3>
          <form>
           <label for="customer_name">Name</label>
            <input type="text" name="customer_name" id="customer_name" placeholder="이름">

            <label for="customerid">ID</label>
            <input type="text" name="customerid" id="customerid" placeholder="아이디">

            <label for="password">Password</label>
            <input type="password" name="password" id="password" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;">
			
			<label for="customer_address">Address</label>
            <input type="text" name="customer_address" id="address" placeholder="주소">
            
            <div class="form-controls">
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

<!-- Modal -->
   <div id="myModal" class="modal" tabindex="-1" role="dialog">
     <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title"><i class="bi bi-exclamation-triangle"></i>&nbsp;&nbsp;올리브영 알림</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body" id="modal-body">
           <!-- 메시지가 동적으로 추가됩니다 -->
         </div>
         <div class="modal-footer">
           <button type="button" id="login-modal-btn" class="btn btn-secondary" data-dismiss="modal">Close</button>
         </div>
       </div>
     </div>
   </div>

</body>
</html>