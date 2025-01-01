<%@ page contentType="text/html; charset=UTF-8" language="java"%>
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
	<section class="breadcrumb-section set-bg"
		data-setbg="/resource/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>${goodsCategory} 부분</h2>
						<div class="breadcrumb__option">
							<a href="../index.jsp"><i class="bi bi-house-door"></i></a> <span>${goodsCategory}</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-5">
					<div class="sidebar">
						<div class="sidebar__item">
							<h4>카테고리</h4>
							<ul>
								<li><a href="/category/Category.do?action=selectMain&goodsCategory=skin">스킨케어</a></li>
								<li><a href="/category/Category.do?action=selectMain&goodsCategory=makeup">메이크업</a></li>
								<li><a href="/category/Category.do?action=selectMain&goodsCategory=hair">헤어케어</a></li>
								<li><a href="/category/Category.do?action=selectMain&goodsCategory=body">바디케어</a></li>
								<li><a href="/category/Category.do?action=selectMain&goodsCategory=perfume">향수/디퓨저</a></li>
							</ul>
						</div>

					</div>
				</div>
				<div class="col-lg-9 col-md-7">
					<div class="product__discount">
						<div class="section-title product__discount__title">
							<h2>${goodsCategory} Best만 모아봤어요</h2>
						</div>
						<div class="row">
							<div class="product__discount__slider owl-carousel">
								<c:forEach var="goods_like" items="${goods_like}">
									<div class="col-lg-4">
										<div class="product__discount__item">
											<div class="product__discount__item__pic set-bg"
												data-setbg="${goods_like.goods_fname_main}">
												<ul class="product__item__pic__hover">
													<li><a href="#"><i class="fa fa-heart"></i></a></li>
													<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
												</ul>
											</div>
											<div class="product__discount__item__text">
												<span>${goods_like.goods_category}</span>
												<h5>
													<a href="#">${goods_like.goods_name}</a>
												</h5>
												<span>${goods_like.goods_price}</span>
											</div>
										</div>
									</div>

								</c:forEach>
							</div>
						</div>
						<div class="row">
							<a href="/category/Category.do?action=selectRank&category=${goodsCategory}" class="goRankbtn">${goodsCategory} 베스트 상품 더보기 ></a>
						</div>
					</div>
					
					<div class="filter__item">
						<div class="row">

							<div class="col-lg-4 col-md-4">
								<div class="filter__found">
									<h6>
										<span>${goods_count }</span> 개의 상품
									</h6>
								</div>
							</div>

						</div>
					</div>
					<div class="row">
						<c:forEach var="goods" items="${goods}">
							<!-- 한 상품을 표시할 div -->
							<div class="col-lg-4 col-md-6 col-sm-6">
								<div class="product__item">
									<div class="product__item__pic set-bg"
										data-setbg="${goods.goods_fname_main}">
										<ul class="product__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
									<div class="product__item__text">
										<h6>
											<a href="#">${goods.goods_name}</a>
										</h6>
										<h5>${goods.goods_price}</h5>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

					<div class="product__pagination">
						<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#"><i
							class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>