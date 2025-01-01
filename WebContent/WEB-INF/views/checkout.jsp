<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>올리브영 온라인몰</title>

 </head>

<body>
  	<jsp:include page="header.jsp"></jsp:include>

 

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="resource/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Checkout</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.jsp">Home</a>
                            <span>Checkout</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h6><span class="icon_tag_alt"></span> Have a coupon? <a href="#">Click here</a> to enter your code
                    </h6>
                </div>
            </div>
            <div class="checkout__form">
                <h4>주문/결제</h4>
                <form action="#">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <div class="row">
                                <div class="col-lg-6">
                                
                                <!-- 이름 입력 -->
                                    <div class="checkout__input">
                                        <p>이름<span>*</span></p>
                                        <input type="text">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                
                                <!-- 휴대전화 번호 입력 -->
                                    <div class="checkout__input">
                                        <p>휴대폰 번호<span>*</span></p>
                                        <input type="text">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 배송지 입력 -->
                            <div class="checkout__input">
                                <p>배송지 입력<span>*</span></p>
                                <input type="text" placeholder="주소 입력" class="checkout__input__add">
                                <input type="text" placeholder="상세 주소 입력">
                            </div>
                            
                            <!-- 배송 메시지 입력 -->
                            <div class="checkout__input">
								 <div class="dropdown">
								 	<label for="deliveryMessage" class="form-label">배송 메시지를 선택해주세요.</label>
								 	<select class="form-select w-100" id="deliveryMessage">
								 		<option value="" selected>메시지를 선택하세요.</option>
								 		<option value="1">문 앞에 놓아주세요.</option>
								 		<option value="2">부재 시 경비실에 맡겨주세요.</option>
								 		<option value="3">배송 전에 연락주세요.</option>
								 		<option value="4">택배함에 넣어주세요.</option>
								 		<!--<option value="5">기타 (직접입력)</option>  -->
								 	</select>
								 </div>
								 <!--
								 <div class="dropdown" id="customMessageDiv" style="display: none;">
						            <label for="customMessage" class="form-label">기타 배송 메시지</label>
						            <input type="text" class="form-control" id="customMessage" placeholder="예: 오후 3시 이후 배송 부탁드립니다.">
						        </div>
						          -->
                            </div>
                            
                            <!-- 결제 수단 입력  -->
                            <div class="checkout__input">
                            <p>결제수단<span>*</span></p>
                            <div class="card shadow-lg">
                                <div class="card-body">
                                <!--
                                <div class="checkout__input__checkbox">
                                    <label for="payment">빠른 결제
                                        <input type="checkbox" id="queick">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="checkout__input__checkbox">
                                    <label for="payment">일반 결제
                                        <input type="checkbox" id="nomal">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                -->
                                <form>
                                <div class="checkout_input">
			                        <div class="btn-group w-100" role="group" aria-label="Payment methods">
			                            <input type="radio" class="btn-check" name="paymentMethod" id="creditCard" value="creditCard" checked>
			                            <label class="btn btn-outline-primary" for="creditCard">카드 결제</label>
			
			                            <input type="radio" class="btn-check" name="paymentMethod" id="bankTransfer" value="bankTransfer">
			                            <label class="btn btn-outline-primary" for="bankTransfer">계좌 이체</label>
			
			                            <input type="radio" class="btn-check" name="paymentMethod" id="easyPay" value="easyPay">
			                            <label class="btn btn-outline-primary" for="easyPay">간편 결제</label>
			                        </div>
			                    </div>
		                        
                            </div>
	                            <!-- 카드 결제 입력 필드 -->
			                    <div id="creditCardDetails" class="mb-4">
			                        <h5 class="text-primary">카드 정보 입력</h5>
			                        <div class="form-floating mb-3">
			                            <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9102 3456">
			                            <label for="cardNumber">카드 번호</label>
			                        </div>
			                        <div class="row">
			                            <div class="col-md-6 form-floating mb-3">
			                                <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY">
			                                <label for="expiryDate">유효기간 (MM/YY)</label>
			                            </div>
			                            <div class="col-md-6 form-floating mb-3">
			                                <input type="text" class="form-control" id="cvc" placeholder="CVC">
			                                <label for="cvc">CVC</label>
			                            </div>
			                        </div>
			                    </div>
			                    <!-- 계좌 이체 입력 필드 -->
			                    <div id="bankTransferDetails" class="mb-4" style="display: none;">
			                        <h5 class="text-primary">계좌 정보 입력</h5>
			                        <div class="form-floating mb-3">
			                            <input type="text" class="form-control" id="bankName" placeholder="은행명">
			                            <label for="bankName">은행명</label>
			                        </div>
			                        <div class="form-floating mb-3">
			                            <input type="text" class="form-control" id="accountNumber" placeholder="계좌 번호">
			                            <label for="accountNumber">계좌 번호</label>
			                        </div>
			                    </div>
		
			                    <!-- 간편 결제 안내 -->
			                    <div id="easyPayDetails" class="mb-4" style="display: none;">
			                        <h5 class="text-primary">간편 결제</h5>
			                        <p class="text-muted">선택하신 간편 결제 서비스로 진행됩니다.</p>
			                    </div>
		                    </div>
		                    </div>
                            </form>
                           
                        </div>
                        
                        <!-- 주문 상품 내역 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4>주문 상품</h4>
                                <div class="checkout__order__products">상품 <span>가격</span></div>
                                <ul>
                                    <li>Vegetableas Package <span>$75.99</span></li>
                                    <li>Fresh Vegetable <span>$151.99</span></li>
                                    <li>Organic Bananas <span>$53.99</span></li>
                                </ul>
                                <div class="checkout__order__total">Total <span>$750.99</span></div>
                                <div class="checkout__input__checkbox">
                                    <label for="acc-or">
                                        	모두 동의합니다.
                                        <input type="checkbox" id="acc-or">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <p>주문 상품 정보 및 결제 대행 서비스 이용 약관에 모두 동의합니다.</p>
                                <button type="submit" class="site-btn">결제 하기</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->
	<jsp:include page="footer.jsp"></jsp:include>
	
	<!--
    <script>
        // 기타 메시지 입력란 표시/숨기기
        const deliveryMessage = document.getElementById('deliveryMessage');
        const customMessageDiv = document.getElementById('customMessageDiv');

        deliveryMessage.addEventListener('change', () => {
            if (deliveryMessage.value === "5") {
                customMessageDiv.style.display = "block";
            } else {
                customMessageDiv.style.display = "none";
            }
        });
    </script>
  	-->
  	<script>
        // 결제 수단 선택에 따른 필드 표시/숨기기
        const creditCard = document.getElementById('creditCard');
        const bankTransfer = document.getElementById('bankTransfer');
        const easyPay = document.getElementById('easyPay');
        const creditCardDetails = document.getElementById('creditCardDetails');
        const bankTransferDetails = document.getElementById('bankTransferDetails');
        const easyPayDetails = document.getElementById('easyPayDetails');

        document.querySelectorAll('input[name="paymentMethod"]').forEach((radio) => {
            radio.addEventListener('change', () => {
                creditCardDetails.style.display = creditCard.checked ? 'block' : 'none';
                bankTransferDetails.style.display = bankTransfer.checked ? 'block' : 'none';
                easyPayDetails.style.display = easyPay.checked ? 'block' : 'none';
            });
        });
    </script>
</body>

</html>