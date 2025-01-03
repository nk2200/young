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
    <script type="text/javascript">
	    function checkForm() {
	        if(form.goods_name.value.trim() === '') {
	            alert("상품명을 입력해주세요.");
	            form.goods_name.focus();
	            return false;
	        }
	        
	        const price = form.goods_price.value.trim();
	        const qty = form.goods_qty.value.trim();
	        if(price === '' || isNaN(price)) {
	            alert("가격을 숫자로 입력해주세요.");
	            form.goods_price.focus();
	            return false;
	        }
	        if(qty === '' || isNaN(qty)) {
	            alert("수량을 숫자로 입력해주세요.");
	            form.goods_qty.focus();
	            return false;
	        }
	        
	        if(form.goods_category.value === 'none') {
	            alert("카테고리를 선택해주세요.");
	            return false;
	        }
	        if(form.goods_desc.value === '') {
	            alert("상품 설명 이미지를 업로드 해주세요.");
	            return false;
	        }
	        if(form.main_image.value === '') {
	            alert("상품 메인 이미지를 업로드 해주세요.");
	            return false;
	        }
	        return true;
	    }
    </script>
</head>

<body>
    <jsp:include page="../header.jsp"></jsp:include>

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
                <form action="/manage/Manage.do" method="post" enctype="multipart/form-data" name="form" onsubmit="return checkForm();">
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
									<option value="none">선택
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
	                            <p>서브 이미지</p>
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
    <jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>