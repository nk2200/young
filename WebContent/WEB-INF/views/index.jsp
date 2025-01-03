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
<style>
.noResult {
	display: flex; /* flexbox를 사용하여 자식 요소들을 배치 */
	flex-direction: column; /* 자식 요소들을 수직으로 배치 */
	justify-content: center; /* 자식 요소들을 수직으로 중앙 배치 */
	align-items: center; /* 자식 요소들을 수평으로 중앙 배치 */
	text-align: center; /* 텍스트 가운데 정렬 */
	width: 100%; /* 부모 div의 너비를 100%로 설정 */
	height: 100%; /* 부모 div의 높이를 100%로 설정 */
	padding: 20px; /* 패딩을 추가하여 요소들이 너무 붙지 않게 설정 */
}

.noResultImg {
	width: 100px; /* 이미지의 너비 */
	height: 100px; /* 이미지의 높이 */
	background-position: center; /* 배경 이미지 중앙 정렬 */
	background-repeat: no-repeat; /* 배경 이미지 반복 방지 */
	background-size: contain; /* 배경 이미지가 요소에 맞게 조정 */
	margin-bottom: 0px; /* 이미지와 텍스트 사이의 간격 */
}

.test {
	font-size: 18px; /* 글자 크기 */
	font-weight: bold; /* 글자 두껍게 */
	margin-bottom: 10px; /* 각 텍스트 요소 사이에 여백 추가 */
	width: 100%; /* 각 요소가 부모 너비에 맞도록 설정 */
	display: flex;
	justify-content: center; /* 텍스트를 수평 중앙 정렬 */
	align-items: center; /* 텍스트를 수직 중앙 정렬 */
}

.subMsg {
	display: flex; /* 자식 요소들을 flexbox로 배치 */
	flex-direction: column; /* 자식 요소들을 수직으로 배치 */
	justify-content: center; /* 자식 요소들을 수직으로 중앙 배치 */
	align-items: center; /* 자식 요소들을 수평으로 중앙 배치 */
}

.test1, .test2 {
	font-size: 14px;
}
</style>
</head>

<body>

	<jsp:include page="header.jsp"></jsp:include>

	<!-- Featured Section Begin -->
	<section class="featured spad">
		<div class="container" style="margin-top: -20px">
			<div class="row">
				<div class="col-lg-12">
					<!-- <div class="section-title" style="background-color: #FFE5EE;"> -->
					<div class="section-title">
						<h2>랭킹</h2>
						<div>오늘의 랭킹! 요즘 가장 핫한 상품</div>
					</div>
				</div>
			</div>

			<!-- 상품 조회, yhl -->

			<div class="row featured__filter" style="min-height: 500px;">
				<c:if test="${not empty noResult}">
					<div class="noResult">
						<div class="noResultImg"
							style="background-image: url('../resource/img/goods/noResult.png');">
						</div>
						<div class="test" style="": 200px; height:200px;>검색 결과가 없어요</div>
						<div class="subMsg">
							<div class="test1" style="": 200px; height:200px;>철자를 확인하거나</div>
							<div class="test2" style="": 200px; height:200px;>다른 키워드로
								검색해보세요.</div>
						</div>
					</div>
				</c:if>
<c:forEach var="goods" items="${goodsList}">
    <div class="col-lg-3 col-md-4 col-sm-6 mix">
        <div class="featured__item">
            <!-- 이미지 영역을 <a> 태그로 감싸서 클릭 시 상세 페이지로 이동 -->
            <a href="/detail/Detail.do?goodsid=${goods.goodsid}">
                <div class="featured__item__pic set-bg"
                     data-setbg="../resource/img/goods/${goods.goods_fname_main}">
                </div>
            </a>
            
            <div class="featured__item__text">
                <!-- 상품 이름 클릭 시 상세 페이지로 이동 -->
                <h6>
                    <a href="/detail/Detail.do?goodsid=${goods.goodsid}">${goods.goods_name}</a>
                </h6>
                <!-- 상품 가격 클릭 시 상세 페이지로 이동 -->
                <h5>
                    <a href="/detail/Detail.do?goodsid=${goods.goodsid}">${goods.goods_price}원</a>
                </h5>
            </div>
        </div>
    </div>
</c:forEach>

			</div>
			<%-- <div class="row featured__filter" style="min-height: 500px;">
    <!-- 검색 결과가 없을 경우 메시지 -->
    <c:if test="${not empty noResult}">
        <div class="noResult"> 
            <div class="noResultImg" style="background-image: url('../resource/img/goods/noResult.png');">
            </div>
            <div class="test" style="width: 200px; height: 200px;">검색 결과가 없어요</div>
            <div class="subMsg">
                <div class="test1" style="width: 200px; height: 200px;">철자를 확인하거나</div>
                <div class="test2" style="width: 200px; height: 200px;">다른 키워드로 검색해보세요.</div>
            </div>
        </div> 
    </c:if>
    
    <!-- action이 'rank'일 때는 랭킹 상품을 보여주고, 'search'일 때는 검색된 상품을 보여줍니다 -->
    <c:choose>
        <c:when test="${param.action == 'rank'}">
            <h4>상품 랭킹</h4>
            <c:forEach var="goods" items="${goodsList}">
                <div class="col-lg-3 col-md-4 col-sm-6 mix">
                    <div class="featured__item">
                        <div class="featured__item__pic set-bg"
                            data-setbg="../${goods.goods_fname_main}">
                            <ul class="featured__item__pic__hover">
                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                            </ul>
                        </div>
                        <div class="featured__item__text">
                            <h6><a href="#">${goods.goods_name}</a></h6>
                            <h5>${goods.goods_price}</h5>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:when test="${param.action == 'search'}">
            <h4>검색 결과</h4>
            <c:forEach var="goods" items="${goodsList}">
                <div class="col-lg-3 col-md-4 col-sm-6 mix">
                    <div class="featured__item">
                        <div class="featured__item__pic set-bg"
                            data-setbg="../${goods.goods_fname_main}">
                            <ul class="featured__item__pic__hover">
                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                            </ul>
                        </div>
                        <div class="featured__item__text">
                            <h6><a href="#">${goods.goods_name}</a></h6>
                            <h5>${goods.goods_price}</h5>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- action 파라미터가 없거나 잘못된 값일 경우 기본적으로 상품 랭킹을 보여줍니다 -->
            <h4>상품 랭킹</h4>
            <c:forEach var="goods" items="${goodsList}">
                <div class="col-lg-3 col-md-4 col-sm-6 mix">
                    <div class="featured__item">
                        <div class="featured__item__pic set-bg"
                            data-setbg="../${goods.goods_fname_main}">
                            <ul class="featured__item__pic__hover">
                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                            </ul>
                        </div>
                        <div class="featured__item__text">
                            <h6><a href="#">${goods.goods_name}</a></h6>
                            <h5>${goods.goods_price}</h5>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div> --%>

		</div>
	</section>

	<!-- Featured Section End -->

	<!-- Blog Section Begin -->
	<section class="from-blog spad">
		<div class="container">
			<c:if test="${isLoggedIn}">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-title from-blog__title">
							<h2>${customer.customer_name}님을 위한 추천 상품</h2>

						</div>
					</div>
				</div>
				<div class="row">
					<c:forEach var="goods" items="${recommendedList}">
						<div class="col-lg-4 col-md-4 col-sm-6">
							<div class="featured__item">
								<div class="featured__item__pic set-bg"
									data-setbg="../${goods.goods_fname_main}">
									<ul class="featured__item__pic__hover">
										<li><a href="#"><i class="fa fa-heart"></i></a></li>
										<li><a href="#"><i class="fa fa-retweet"></i></a></li>
										<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
									</ul>
								</div>
								<div class="featured__item__text">
									<h6>
										<a href="#">${goods.goods_name}</a>
									</h6>
									<h5>${goods.goods_price}원</h5>
								</div>
							</div>
						</div>
					</c:forEach>
			</c:if>
		</div>
		</div>
	</section>
	<!-- Blog Section End -->

	<jsp:include page="footer.jsp"></jsp:include>

</body>

</html>