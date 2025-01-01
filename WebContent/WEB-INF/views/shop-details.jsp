<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>올리브영 온라인몰</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//카트 담기!
		$('#add-btn').click(function(event) {
			event.preventDefault(); // 기본 동작 방지 (페이지 새로 고침 방지)

			// 'pro-qty' 클래스에서 input 요소의 값 가져오기
			var quantity = $('.pro-qty input').val();

			// URL에서 goodsid 값을 추출
			var goodsid = getQueryParam('goodsid');

			// 'primary-btn'의 data-customerid 속성에서 customerid 값 가져오기
			var customerid = $(this).data('customerid');

			if (goodsid && customerid) {
				// 데이터를 URL 파라미터로 전달
				var url = '/cart/Cart.do?action=cart';

				// AJAX 요청으로 데이터를 전달
				$.ajax({
					url : url,
					method : 'POST',
					data : {
						goods_qty : quantity, // 수량
						goodsid : goodsid, // 상품 ID
						customerid : customerid
					// 고객 ID
					},
					success : function(response) {
						console.log('Success:', response);
						alert("장바구니에 정상적으로 추가되었습니다.");
					},
					error : function(xhr, status, error) {
						console.error('Error:', error);
					}
				});
			} else {
				console.error('goodsid or customerid is missing');
			}
		});
		//구매 페이지로!
		$('#buy-btn').click(function(event){
			event.preventDefault();
			var quantity = $('.pro-qty input').val();

			var goodsid = getQueryParam('goodsid');

			var customerid = $(this).data('customerid');
			
			if(goodsid && customerid){
				var url = '/pay/Pay.do';
				$.ajax({
					url : url,
					method : 'POST',
					data : {
						goods_qty : quantity,
						goodsid : goodsid,
						customerid : customerid
					},
					success : function(response){
						console.log('Success: ',response);
						//redirect
						window.location.href = "/pay/Pay.do";
					},
					error : function(xhr, status, error) {
						console.error('Error:', error);
					}
				});
			}else{
				console.error('goodsid or customerid is missing');
			}
		});
	});

	// URL에서 쿼리 파라미터를 추출하는 함수
	function getQueryParam(name) {
		var urlParams = new URLSearchParams(window.location.search);
		return urlParams.get(name);
	}
	//숫자 콤마형식으로 바꾸기
	function makeComma(number){
		const c = number.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		return c;
	}
	$(document).ready(function(){
		console.log("작동됨");
		const price = ${goods.goods_price};
		console.log(price);
		const formattedPrice = makeComma(price);
		$('#price').html(`&#8361;${formattedPrice}`);
	});
	
</script>
</head>

<body>
	<!-- Page Preloder -->
	<jsp:include page="header.jsp"></jsp:include>
	<!-- Breadcrumb Section Begin -->
<%-- 	<section class="breadcrumb-section set-bg"
		data-setbg="/resource/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>${goods.goods_name }</h2>
						<div class="breadcrumb__option">
							<a href="./index.jsp">Home</a> > <a href="#">${goods.goods_category }</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section> --%>
	<!-- Breadcrumb Section End -->
	<!--카테고리 만들기  -->
	<nav class="container">
		<ul style="list-style-type: none; display: flex; align-items: center;">
			<li style="margin-right: 10px;"><a href="#" aria-label="홈">
					<img src="/resource/home-icon.png" alt="홈 아이콘"
					style="vertical-align: middle;" width="15px" height="15px">
			</a> <span>></span></li>
			<li style="margin-right: 10px;"><a href="#">${goods.goods_category }</a>
				<span>></span></li>
			<li style="margin-right: 10px;"><span>${goods.goods_name }</span>
			</li>
		</ul>
	</nav>

	<!-- Product Details Section Begin -->
	<section class="product-details spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6">
					<div class="product__details__pic">
						<div class="product__details__pic__item">
							<img class="product__details__pic__item--large"
								src="/resource/img/goods/${goods.goods_fname_main }" alt="">
						</div>
						<div class="product__details__pic__slider owl-carousel">
							<img
								data-imgbigurl="/resource/img/goods/${goods.goods_fname_sub }"
								src="/resource/img/goods/${goods.goods_fname_sub }" alt=""> 
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-6">
					<div class="product__details__text detailpage">
						<h3>${goods.goods_name }</h3>
						<div class="product__details__rating">
							<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
								class="fa fa-star"></i> <i class="fa fa-star"></i> <i
								class="fa fa-star-half-o"></i> <span>(18 reviews)</span>
						</div>
						<div class="product__details__price" id="price">&#8361;${goods.goods_price }</div>
						
						<ul class="product__details__text__list">
							<li><b>Availability</b> <span>In Stock</span></li>
							<li><b>Shipping</b> <span>01 day shipping. <samp>Free
										pickup today</samp></span></li>
							<li><b>Weight</b> <span>0.5 kg</span></li>
							<li><b>Share on</b>
								<div class="share">
									<a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i
										class="fa fa-twitter"></i></a> <a href="#"><i
										class="fa fa-instagram"></i></a> <a href="#"><i
										class="fa fa-pinterest"></i></a>
								</div></li>
						</ul>
								
						<div class="product__details__quantity">
							<div class="quantity">
								<div class="pro-qty">
									<input type="text" value="1">
								</div>
							</div>
						</div>
						<a href="#" class="primary-btn" id="add-btn"
							data-customerid="${customerid}">ADD TO CART</a> 
							<a href="/pay/Pay.do?goodsid=${goods.goodsid }" class="primary-btn" id="buy-btn"
							data-customerid="${customerid }">BUY</a>
							<a href="#" class="heart-icon"><span class="icon_heart_alt"></span></a>
					</div>
				</div>
				<div class="col-lg-12">
					<div class="product__details__tab">
						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#tabs-1" role="tab" aria-selected="true">Description</a>
							</li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#tabs-3" role="tab" aria-selected="false">Reviews <span>(1)</span></a>
							</li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tabs-1" role="tabpanel">
								<div class="product__details__tab__desc">
									<div style="text-align : center;"><img src="/resource/img/goods/${goods.goods_desc }" alt=""></div>
								</div>
							</div>
							<div class="tab-pane" id="tabs-3" role="tabpanel">
								<div class="product__details__tab__desc">
									<h6>리뷰 추가할까 말까</h6>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Details Section End -->

	<!-- Related Product Section Begin -->
	<section class="related-product">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title related__product__title">
						<h2>Related Product</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-3 col-md-4 col-sm-6">
					<div class="product__item">
						<div class="product__item__pic set-bg"
							data-setbg="/resource/img/product/product-1.jpg">
							<ul class="product__item__pic__hover">
								<li><a href="#"><i class="fa fa-heart"></i></a></li>
								<li><a href="#"><i class="fa fa-retweet"></i></a></li>
								<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6>
								<a href="#">Crab Pool Security</a>
							</h6>
							<h5>$30.00</h5>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-4 col-sm-6">
					<div class="product__item">
						<div class="product__item__pic set-bg"
							data-setbg="/resource/img/product/product-2.jpg">
							<ul class="product__item__pic__hover">
								<li><a href="#"><i class="fa fa-heart"></i></a></li>
								<li><a href="#"><i class="fa fa-retweet"></i></a></li>
								<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6>
								<a href="#">Crab Pool Security</a>
							</h6>
							<h5>$30.00</h5>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-4 col-sm-6">
					<div class="product__item">
						<div class="product__item__pic set-bg"
							data-setbg="/resource/img/product/product-3.jpg">
							<ul class="product__item__pic__hover">
								<li><a href="#"><i class="fa fa-heart"></i></a></li>
								<li><a href="#"><i class="fa fa-retweet"></i></a></li>
								<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6>
								<a href="#">Crab Pool Security</a>
							</h6>
							<h5>$30.00</h5>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-4 col-sm-6">
					<div class="product__item">
						<div class="product__item__pic set-bg"
							data-setbg="/resource/img/product/product-7.jpg">
							<ul class="product__item__pic__hover">
								<li><a href="#"><i class="fa fa-heart"></i></a></li>
								<li><a href="#"><i class="fa fa-retweet"></i></a></li>
								<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6>
								<a href="#">Crab Pool Security</a>
							</h6>
							<h5>$30.00</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Related Product Section End -->

	<jsp:include page="footer.jsp"></jsp:include>

</body>

</html>