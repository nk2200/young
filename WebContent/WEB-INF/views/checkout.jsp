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
                                    <div class="checkout__input">
                                        <p>이름<span>*</span></p>
                                        <input type="text">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>휴대폰 번호<span>*</span></p>
                                        <input type="text">
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>배송지 입력<span>*</span></p>
                                <input type="text" placeholder="XX시  OO구  ㅁㅁ동" class="checkout__input__add">
                                <input type="text" placeholder="상세 주소 입력">
                            </div>
                            <div class="checkout__input">
                                <p>배송 요청사항</p>
                                <div class="dropdown">
								    <button class="btn btn-primary dropdown-toggle" type="button" id="deliveryOption" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								       배송 메세지를 선택해주세요.
								    </button>
								    <ul class="dropdown-menu" aria-labelledby="basicDropdown">
								        <li><a class="dropdown-item" href="#">부재 시 경비실에 맡겨주세요.</a></li>
								        <li><a class="dropdown-item" href="#">파손의 위험이 있으므로, 배송 시 주의해주세요.</a></li>
								        <li><a class="dropdown-item" href="#">배송 전에 연락주세요.</a></li>
								        <li><a class="dropdown-item" href="#">택배함에 넣어주세요.</a></li>
								    </ul>
								</div>
                            </div>
                            <div class="checkout__input">
                                <p>결제수단<span>*</span></p>
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
                            </div>
                           
                        </div>
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

</body>

</html>