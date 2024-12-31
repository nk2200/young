<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
	<jsp:include page="../header.jsp"></jsp:include>


	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="/resource/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>Shopping Cart</h2>
						<div class="breadcrumb__option">
							<a href="./index.jsp"><i class="bi bi-house-door"></i></a> <span>Shopping
								Cart</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Shoping Cart Section Begin -->
	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__table">
						<span>올리브영 배송상품 </span>
						<table>
							<thead>
								<tr>
									<th></th>
									<th class="shoping__product">상품정보</th>
									<th>판매가</th>
									<th>수량</th>
									<th>선택</th>

									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="cart" items="${cartList}">
									<tr>
										<td class="shoping__cart__item__check"><input
											type="checkbox" /></td>
										<td class="shoping__cart__item"><img
											src="${cart.goods.goods_fname_main}" alt="">
											<h5>${cart.goods.goods_name}</h5></td>
										<td class="shoping__cart__price">
											${cart.goods.goods_price}</td>
										<td class="shoping__cart__quantity">
											<div class="quantity">
												<div class="pro-qty">
													<input type="text" value="${cart.cart_qty}">
												</div>
											</div>
										</td>
										<td class="shoping__cart__total">
											<a href="#" class="heart-icon"><span class="icon_heart_alt"></span>
												쇼핑찜</a> <br> <a href="#" class="icon_close"><span
												class="icon"></span> 삭제</a></td>
									</tr>
								</c:forEach>


							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__btns">
						<a href="#" class="primary-btn cart-btn">선택 상품 삭제</a>
					</div>
					<
				</div>

				<div class="col-lg-12">
					<div class="shoping__checkout">
						<ul>
							<li>총 판매가 <span>${totalPrice }</span></li>
							<li>총 개수 <span>${totalQty }</span></li>
						</ul>
						<div class="order_btn_area">
							<a href="#" class="select-btn">선택주문 </a> <a href="#"
								class="all-btn">전체주문</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Shoping Cart Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>