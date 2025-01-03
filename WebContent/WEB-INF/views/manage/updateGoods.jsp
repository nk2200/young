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
    <title>상품 수정</title>
    <script type="text/javascript">
	    window.addEventListener("load", () => {
			document.getElementById('confirm').addEventListener('click', function () {
		        $('#inputModal').modal('hide');
		    });
		});
		
	    function checkForm() {
	        if(form.goods_name.value.trim() === '') {
	        	$('#modal-body').text('상품명을 입력해주세요.');
	        	$('#inputModal').modal('show');
	            return false;
	        }
	        
	        const price = form.goods_price.value.trim();
	        const qty = form.goods_qty.value.trim();
	        if(price === '' || isNaN(price)) {
	        	$('#modal-body').text('가격을 숫자로 입력해주세요.');
	        	$('#inputModal').modal('show');
	            return false;
	        }
	        if(qty === '' || isNaN(qty)) {
	        	$('#modal-body').text('수량을 숫자로 입력해주세요.');
	        	$('#inputModal').modal('show');
	            return false;
	        }
	        
	        if(form.goods_category.value === 'none') {
	        	$('#modal-body').text('카테고리를 선택해주세요.');
	        	$('#inputModal').modal('show');
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
                        <h2>상품 수정</h2>
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
	                    <input type="text" name="goods_name" value="${goods.goods_name}">
	                </div>
	                <div class="checkout__input">
	                    <p>가격<span>*</span></p>
	                    <input type="number" name="goods_price" value="${goods.goods_price}">
	                </div>
                    <div class="row">
	                    <div class="col-lg-6">
			                <div class="checkout__input">
			                    <p>카테고리<span>*</span></p>
			                    <select name="goods_category">
			                    	<option value="none">선택
									<option value="skin" ${goods.goods_category=='skin'?'selected':''}>스킨케어
									<option value="makeup" ${goods.goods_category=='makeup'?'selected':''}>메이크업
									<option value="hair" ${goods.goods_category=='hair'?'selected':''}>헤어케어
									<option value="body" ${goods.goods_category=='body'?'selected':''}>바디케어
									<option value="perfume" ${goods.goods_category=='perfume'?'selected':''}>향수/디퓨저
								</select>
			                </div>
	                    </div>
	                    <div class="col-lg-6">
			                <div class="checkout__input">
			                    <p>수량<span>*</span></p>
			                    <input type="number" name="goods_qty" value="${goods.goods_qty}">
			                </div>
	                    </div>
	                </div>
	                <div class="checkout__input">
	                    <p>상품 설명<span>*</span></p>
	                    <input type="file" name="goods_desc" style="padding-left:0px;border:none;">
	                    <img src="../resource/img/goods/${goods.goods_desc}" style="width:150px;max-height:300px;">
	                    <input type="hidden" name="current_desc_path" value="${goods.goods_desc}">
	                </div>
	                <div class="row">
	                    <div class="col-lg-6">
	                        <div class="checkout__input">
			                    <p>메인 이미지<span>*</span></p>
			                    <input type="file" name="main_image" style="padding-left:0px;border:none;">
			                    <img src="../resource/img/goods/${goods.goods_fname_main}" style="width:150px;">
			                    <input type="hidden" name="current_main_path" value="${goods.goods_fname_main}">
	                        </div>
	                    </div>
	                    <div class="col-lg-6">
	                        <div class="checkout__input">
	                            <p>서브 이미지</p>
			                    <input type="file" name="sub_image" style="padding-left:0px;border:none;">
			                    <img src="../resource/img/goods/${goods.goods_fname_sub}" style="width:150px;">
			                    <input type="hidden" name="current_sub_path" value="${goods.goods_fname_sub}">
	                        </div>
	                    </div>
	                </div>
	                <div style="padding-top:30px;text-align:center;">
	                	<input type="hidden" name="goodsid" value="${param.goodsid}">
	                	<input type="hidden" name="searchName" value="${param.searchName}">
	                	<input type="hidden" name="searchCate" value="${param.category}">
	                	<input type="hidden" name="page" value="${param.page}">
	                	<input type="hidden" name="action" value="update">
		                <button type="submit" class="site-btn" style="width:200px;">수정</button>
	                </div>
                </form>
            </div>
        </div>
    </section>
    <!-- Product Section End -->
    
    <!-- Modal -->
    <div class="modal fade" id="inputModal" tabindex="-1" aria-labelledby="inputModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="inputModalLabel">상품 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					    <span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modal-body"></div>
				<div class="modal-footer">
				    <button type="button" class="btn btn-primary" id="confirm">확인</button>
				</div>
			</div>
		</div>
	</div>
    <jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>