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
    <title>상품 등록</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="../resource/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="../resource/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="../resource/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="../resource/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="../resource/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="../resource/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="../resource/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="../resource/css/style.css" type="text/css">
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
	
	<%-- <jsp:include page="../header.jsp"></jsp:include> --%>


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
                            </div>
                            <div class="col-lg-4 col-md-4">
                                <div class="filter__found">
                                    <h6><span>${count}</span> Products found</h6>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-3">
                            </div>
                        </div>
                    </div>
                    <div class="row">
	                    <c:forEach var="item" items="${goods}">
	                        <div class="col-lg-4 col-md-6 col-sm-6">
	                            <div class="product__item">
	                                <div class="product__item__pic set-bg" data-setbg="../${item.goods_fname_main}">
	                                </div>
	                                <div class="product__item__text">
	                                    <h6><b><a href="#">${item.goods_name}</a></b></h6>
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

    <!-- Js Plugins -->
    <script src="../resource/js/jquery-3.3.1.min.js"></script>
    <script src="../resource/js/bootstrap.min.js"></script>
    <script src="../resource/js/jquery.nice-select.min.js"></script>
    <script src="../resource/js/jquery-ui.min.js"></script>
    <script src="../resource/js/jquery.slicknav.js"></script>
    <script src="../resource/js/mixitup.min.js"></script>
    <script src="../resource/js/owl.carousel.min.js"></script>
    <script src="../resource/js/main.js"></script>

</body>

</html>