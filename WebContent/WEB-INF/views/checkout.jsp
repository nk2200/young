<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
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
    <section class="breadcrumb-section set-bg" data-setbg="/resource/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Checkout</h2>
                        <div class="breadcrumb__option">
                            <a href="/">Home</a>
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
                <form action="/pay/Pay.do?action=payment" method="post">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <div class="row">
                                <div class="col-lg-12">
                                
                                	<!-- 이름 입력 -->
                                    <div class="checkout__input">
                                        <p>이름<span>*</span></p>
                                        <input type="text" id="checkout_name" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                
                                <!-- 휴대전화 번호 입력 -->
                                    <div class="checkout__input">
                                        <p>휴대폰 번호<span>*</span></p>
                                        <input type="text" id="checkout_phone" required>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 배송지 입력 -->
                            <div class="checkout__input">
                                <p>배송지 입력<span>*</span></p>
                                <div class="d-flex">
							        <input type="text" placeholder="주소 입력" class="form-control" id="checkout_address1" required>
							        <input type="button" class="btn btn-success text-white ml-3" onclick="openPostcodeSearch()" value="주소 검색">
							    </div>
							    <input type="text" placeholder="상세 주소 입력" class="form-control mt-3" id="checkout_address2">
                                <!-- 모달 영역 -->
								<div id="postcodeModal" class="modal" tabindex="-1" role="dialog">
								    <div class="modal-dialog" role="document">
								        <div class="modal-content">
								            <div id="postcodeDiv"></div>
								        </div>
								    </div>
								</div>
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
								 	</select>
								 </div>
                            </div>
                            
                            <!-- 결제 수단 입력  -->
							<div class="checkout__input">
							    <p>결제수단<span>*</span></p>
							    <div class="card">
							        <div class="card-body">
							            <form>
							                <div class="checkout_input mb-3">
							                    <!-- 버튼 그룹 -->
							                    <div class="btn-group d-flex" role="group" aria-label="Payment methods">
							                        <button type="button" class="btn btn-outline-success flex-fill" id="creditCard" value="creditCard" onclick="selectPayment('creditCard')">카드 결제</button>
							                        <button type="button" class="btn btn-outline-success flex-fill" id="bankTransfer" value="bankTransfer" onclick="selectPayment('bankTransfer')">계좌 이체</button>
							                        <button type="button" class="btn btn-outline-success flex-fill" id="easyPay" value="easyPay" onclick="selectPayment('easyPay')">간편 결제</button>
							                    </div>
							                </div>
							                <!-- 카드 결제 입력 필드 -->
							                <div id="creditCardDetails" class="mb-4">
							                    <h5 class="text-primary mb-3">카드 정보 입력</h5>
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
							            </form>
							        </div>
							    </div>
							</div>                         
                        </div>
                        
                        <!-- 주문 상품 내역 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4>주문 상품</h4>
                                <div class="checkout__order__products">상품<span>가격</span></div>
                                <!--
                                <ul>
                                    <li> ${param.goodsName} (${param.goods_qty}개)<span>${param.price}</span></li>
                                    
                                </ul>
                                <div class="checkout__order__total">Total <span>${param.totalPrice}</span></div>	-->
                                
                                <ul>
							        <c:forEach var="item" items="${sessionScope.tempDataList}">
							            <li>${item.goodsName} (${item.goods_qty}개) <span>${item.goodsPrice}</span></li>
							        </c:forEach>
							    </ul>
							    <div class="checkout__order__total">
							        Total: 
							        <span>
							            <c:forEach var="item" items="${sessionScope.tempDataList}" varStatus="status">
							               <!-- ${status.index == 0 ? 0: ''}  --> 
							                <c:set var="totalPrice" value="${totalPrice + item.totalPrice}" scope="page" />
							            </c:forEach>
							            ${totalPrice}
							        </span>
							    </div>
                                
                                <!-- 결제 확인 체크 박스 -->
                                <div class="checkout__input__checkbox">
                                    <label for="acc-or">
                                        	모두 동의합니다.
                                        <input type="checkbox" id="acc-or" checked>
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <p>주문 상품 정보 및 결제 대행 서비스 이용 약관에 모두 동의합니다.</p>
                                <input type="hidden" name="action" value="payment">
                                <button type="submit" class="site-btn" id="payment_btn">결제 하기</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->
	<jsp:include page="footer.jsp"></jsp:include>
	
	
	<!-- script 부분 이후 수정 예정  -->
  	<script>
  	// 결제 수단 선택에 따른 필드 표시/숨기기
	    const creditCardDetails = document.getElementById('creditCardDetails');
	    const bankTransferDetails = document.getElementById('bankTransferDetails');
	    const easyPayDetails = document.getElementById('easyPayDetails');
	
	    document.querySelectorAll('.btn-group .btn').forEach((button) => {
	        button.addEventListener('click', () => {
	            document.querySelectorAll('.btn-group .btn').forEach((btn) => {
	                btn.classList.remove('active');
	            });
	
	            button.classList.add('active');
	
	            const selectedPayment = button.id;
	            creditCardDetails.style.display = selectedPayment === 'creditCard' ? 'block' : 'none';
	            bankTransferDetails.style.display = selectedPayment === 'bankTransfer' ? 'block' : 'none';
	            easyPayDetails.style.display = selectedPayment === 'easyPay' ? 'block' : 'none';
	        });
	    });
    </script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    // 우편번호 검색 모달 열기
	    function openPostcodeSearch() {
	        const modal = new bootstrap.Modal(document.getElementById('postcodeModal'));
	        modal.show();
	
	        new daum.Postcode({
	            oncomplete: function(data) {
	                document.getElementById('checkout_address1').value = data.roadAddress || data.jibunAddress; // 도로명주소 또는 지번주소
	                modal.hide();
	            },
	            onclose: function(state) {
	                modal.hide();
	            }
	        }).embed(document.getElementById('postcodeDiv'));
	    }
	</script>
	<script>
	//동의 체크 확인
    document.addEventListener('DOMContentLoaded', () => {
	    const checkbox = document.getElementById('acc-or');
	    const submitButton = document.getElementById('payment_btn');
	
	    checkbox.addEventListener('change', () => {
	        submitButton.disabled = !checkbox.checked;
	        
	     	// 버튼 색상 변경
	        if (checkbox.checked) {
	          submitButton.style.backgroundColor = '#7FAD39'; // 활성화 색상
	          submitButton.style.color = '#fff'; // 활성화 텍스트 색상
	        } else {
	          submitButton.style.backgroundColor = '#ccc'; // 비활성화 색상
	          submitButton.style.color = '#666'; // 비활성화 텍스트 색상
	        }
	    });
    });
  </script>
</body>

</html>