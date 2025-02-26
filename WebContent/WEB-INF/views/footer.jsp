<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>올리브영 온라인몰</title>
<style>
.footer__lists {
    display: flex;
    gap: 20px; /* 이름과 기능 리스트 간 간격 */
}

.footer__lists .names {
    flex: 1; /* 이름 리스트의 넓이를 자동으로 설정 */
}

.footer__lists .features {
    flex: 5; /* 기능 리스트의 넓이를 더 크게 설정 */
}

.footer__widget ul {
    list-style: none;
    padding: 0;
}

.footer__widget ul li {
    margin-bottom: 10px;
}

.footer__widget ul li a {
    text-decoration: none;
    color: inherit;
}

.footer__widget ul li a:hover {
    text-decoration: underline;
}
	

</style>
</head>
<body>

	<hr>
<!-- Footer Section Begin -->
    <footer class="footer spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="footer__about">
                        <div class="footer__about__logo">
                            <a href="./index.jsp"><img src="resource/img/logo1.png" alt=""></a>
                        </div>                        
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6 offset-lg-1">
				    <div class="footer__widget">
				        <h6>young 프로젝트</h6>
				        <div class="footer__lists">
				            <ul class="names">
				                <li><a href="#">김소희</a></li>
				                <li><a href="#">신영서</a></li>
				                <li><a href="#">유혜린</a></li>
				                <li><a href="#">이연수</a></li>
				                <li><a href="#">최가은</a></li>
				            </ul>
				            <ul class="features">
				                <li><a href="#">결제 기능</a></li>
				                <li><a href="#">카테고리 및 장바구니 기능</a></li>
				                <li><a href="#">메인페이지 및 마이페이지 기능</a></li>
				                <li><a href="#">상품 관리 및 검색 기능</a></li>
				                <li><a href="#">상세페이지 및 로그인 회원가입 기능</a></li>
				            </ul>
				        </div>
				    </div>
				</div>

        </div>
        <div class="row">
               <div class="col-lg-12">
                   <div class="footer__copyright">
                       <div class="footer__copyright__text"><p>
 Copyright &copy;<script>document.write(new Date().getFullYear());</script> 저작권은 young 팀원들에게 있습니다.
 <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p></div>
                       <div class="footer__copyright__payment"><img src="img/payment-item.png" alt=""></div>
                   </div>
               </div>
           </div>
    </footer>
    <!-- Footer Section End -->
    
      <!-- Js Plugins -->
    <script src="/resource/js/jquery-3.3.1.min.js"></script>
    <script src="/resource/js/bootstrap.min.js"></script>
    <script src="/resource/js/jquery.nice-select.min.js"></script>
    <script src="/resource/js/jquery-ui.min.js"></script>
    <script src="/resource/js/jquery.slicknav.js"></script>
    <script src="/resource/js/mixitup.min.js"></script>
    <script src="/resource/js/owl.carousel.min.js"></script>
    <script src="/resource/js/main.js"></script>
    
</body>
</html>