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
                        <h2>상품 등록</h2>
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
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
            	<!-- <img src="../resource/img/goods/hair.jpg"> -->
                <form action="/register/Register.do" method="post" enctype="multipart/form-data">
	                <div class="checkout__input">
	                    <p>상품명<span>*</span></p>
	                    <input type="text" name="goods_name">
	                </div>
	                <div class="checkout__input">
	                    <p>가격<span>*</span></p>
	                    <input type="number" name="goods_price">
	                </div>
                    <div class="row">
	                    <div class="col-lg-6">
			                <div class="checkout__input">
			                    <p>카테고리<span>*</span></p>
			                    <select name="goods_category">
									<option value="skin">스킨케어
									<option value="makeup">메이크업
									<option value="hair">헤어케어
									<option value="body">바디케어
									<option value="perfume">향수/디퓨저
								</select>
			                </div>
	                    </div>
	                    <div class="col-lg-6">
			                <div class="checkout__input">
			                    <p>수량<span>*</span></p>
			                    <input type="number" name="goods_qty">
			                </div>
	                    </div>
	                </div>
	                <div class="checkout__input">
	                    <p>상품 설명<span>*</span></p>
	                    <input type="file" name="goods_desc" style="padding-left:0px;border:none;">
	                </div>
	                <div class="row">
	                    <div class="col-lg-6">
	                        <div class="checkout__input">
			                    <p>메인 이미지<span>*</span></p>
			                    <input type="file" name="main_image" style="padding-left:0px;border:none;">
	                        </div>
	                    </div>
	                    <div class="col-lg-6">
	                        <div class="checkout__input">
	                            <p>상세 이미지<span>*</span></p>
			                    <input type="file" name="sub_image" style="padding-left:0px;border:none;">
	                        </div>
	                    </div>
	                </div>
	                <div style="padding-top:30px;text-align:center;">
	                	<input type="hidden" name="action" value="insert">
		                <button type="submit" class="site-btn" style="width:200px;">등록</button>
	                </div>
                </form>
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