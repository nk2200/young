<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>상품 목록</title>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../resource/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>상품 목록</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.jsp">Home</a>
                            <span>Goods</span>
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
                            	<li><a href="#">전체</a></li>
                            	<li><a href="#">스킨케어</a></li>
	                            <li><a href="#">메이크업</a></li>
	                            <li><a href="#">헤어케어</a></li>
	                            <li><a href="#">바디케어</a></li>
	                            <li><a href="#">향수/디퓨저</a></li>
                            </ul>
                        </div>
                        <div>
                        	<a href="/register/Register.do?action=register" style="padding: 14px 32px;" class="primary-btn">상품 등록</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-md-7">
                    <div class="filter__item" style="padding-top:0px;border-top:none;">
                        <div class="row">
                            <div class="col-lg-4 col-md-5">
                            	<div class="filter__found" style="text-align:left;">
                                    <h6><span>${count}</span> Products found</h6>
                                </div>
                            </div>
                            <div class="col-lg-8 col-md-7">
                            	<div class="filter__option">
                                    <div class="footer__widget" style="margin-bottom:0px";>
			                            <form action="/register/Register.do">
			                                <input type="text" placeholder="상품 검색" name="searchName" value="${param.searchName}">
			                                <button type="submit" class="site-btn">SEARCH</button>
			                            </form>
			                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
	                    <c:forEach var="item" items="${goods}">
	                        <div class="col-lg-4 col-md-6 col-sm-6">
	                            <div class="product__item">
	                                <div class="product__item__pic set-bg" data-setbg="../${item.goods_fname_main}">
	                                	<ul class="product__item__pic__hover">
	                                        <li><a href="/register/Register.do?action=update&goodsid=${item.goodsid}"><i class="fa fa-pencil"></i></a></li>
	                                        <li><a href="/register/Register.do?action=delete&goodsid=${item.goodsid}"><i class="fa fa-trash"></i></a></li>
	                                    </ul>
	                                </div>
	                                <div class="product__item__text">
	                                    <h6><b><a href="/detail/Detail.do?goodsid=${item.goodsid}">${item.goods_name}</a></b></h6>
	                                    <h6>${item.goods_price}원</h6>
	                                    <h6>수량: ${item.goods_qty}</h6>
	                                </div>
	                            </div>
	                        </div>
                        </c:forEach>
                    </div>
                    <div class="product__pagination">
                        <a href="#">1</a>
                        <a href="#">2</a>
                        <a href="#">3</a>
                        <a href="#"><i class="fa fa-long-arrow-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->
<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>