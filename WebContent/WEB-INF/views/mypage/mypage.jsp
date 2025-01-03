<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- Breadcrumb Section Begin -->
	<!-- 고객정보 추가,yhl -->
	<!-- 	<section class="breadcrumb-section set-bg"
		data-setbg="resource/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>마이페이지</h2>
						<div class="breadcrumb__option">
							<a href="./index.jsp">Home</a> <span>Shopping Cart</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section> -->


	<!-- Breadcrumb Section End -->

	<!-- Shoping Cart Section Begin -->
	<section class="shoping-cart spad">
		<div class="container">
			<div
				style="text-align: center; font-weight: bold; font-size: 36px; margin-bottom: 20px;">
				마이페이지</div>
<%-- 			<div
				style="background-color: #EB6D9A; color: white; padding: 10px; margin-bottom: 20px;">
				${customer.customer_name}님 반갑습니다.</div> --%>
			<div class="row">

				<div class="col-lg-12">
					<div class="shoping__cart__table">
						<table>
							<thead>
								<tr>
									<th>주문일자</th>
									<th class="shoping__product">상품</th>
									<th>수량</th>
									<th>주문금액</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<!-- 주문상품 추가,yhl -->
								<c:forEach var="order" items="${orderList}">
									<tr>

										<!-- buy_date는 Price 영역에 하나씩, 같은 상품에 대해서만 한 줄씩 출력 -->
										<td class="shoping__cart__price">${order.buy_date}<br />
											<!-- BuyDto에서 buy_date를 가져오기 -->
										</td>
										<td class="shoping__cart__item"><img
											src="../resource/img/goods/${goods.goods_fname_main}" alt="">
											<h5>${order.goods_name}</h5> <!-- GoodsDto에서 goods_name 가져오기 -->
										</td>
										<td class="shoping__cart__quantity">
											<!-- 											<div class="quantity">
												<div class="pro-qty">
													<input type="text" value="1">
												</div>
											</div> -->
											<h5>${order.buy_qty}</h5>
										</td>

										<td class="shoping__cart__total"><h5>${order.total_price}원</h5>
											<!-- 예시로 가격 * 수량을 계산 --></td>

<!-- 										<td class="shoping__cart__item__close"><span
											class="icon_close"></span></td> -->
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- 			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__btns">
						<a href="#" class="primary-btn cart-btn">CONTINUE SHOPPING</a> <a
							href="#" class="primary-btn cart-btn cart-btn-right"><span
							class="icon_loading"></span> Upadate Cart</a>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="shoping__continue">
						<div class="shoping__discount">
							<h5>Discount Codes</h5>
							<form action="#">
								<input type="text" placeholder="Enter your coupon code">
								<button type="submit" class="site-btn">APPLY COUPON</button>
							</form>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="shoping__checkout">
						<h5>Cart Total</h5>
						<ul>
							<li>Subtotal <span>$454.98</span></li>
							<li>Total <span>$454.98</span></li>
						</ul>
						<a href="#" class="primary-btn">PROCEED TO CHECKOUT</a>
					</div>
				</div>
			</div> -->
		</div>
	</section>
	<!-- Shoping Cart Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>