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
    <title>상품 삭제</title>
    <style>
    	th {
    		padding: 10px 5px;
    	}
    	.site-btn {
    		padding:14px 30px 12px;
    		margin-right:10px;
    	}
    </style>
    <script>
    	window.addEventListener("load", () => {
		    document.getElementById('confirmDelete').addEventListener('click', function () {
		        document.getElementById('deleteForm').submit(); 
		        $('#deleteModal').modal('hide');
		    });
	    });
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
                        <h2>상품 삭제</h2>
                        <div class="breadcrumb__option">
                            <a href="/main">Home</a>
                            <span>Goods</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Product Section Begin -->
    <section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__table" style="margin-top:40px;">
                        <table>
                        	<thead>
								<tr>
									<th class="shoping__product">상품정보</th>
									<th>판매가</th>
									<th>수량</th>
								</tr>
							</thead>
                            <tbody>
                                <tr>
                                    <td class="shoping__cart__item">
                                        <img src="../resource/img/goods/${goods.goods_fname_main}" alt="" style="margin-right:20px;">
                                        <h5>${goods.goods_name}</h5>
                                    </td>
                                    <td class="shoping__cart__price">
                                        ${goods.goods_price}원
                                    </td>
                                    <td class="shoping__cart__price">
                                        ${goods.goods_qty}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                	<form action="/manage/Manage.do" method="post" id="deleteForm">
                		<input type="hidden" name="current_desc_path" value="${goods.goods_desc}">
                		<input type="hidden" name="current_main_path" value="${goods.goods_fname_main}">
                		<input type="hidden" name="current_sub_path" value="${goods.goods_fname_sub}">
                		<input type="hidden" name="goodsid" value="${param.goodsid}">
                		<input type="hidden" name="searchName" value="${param.searchName}">
	                	<input type="hidden" name="searchCate" value="${param.category}">
	                	<input type="hidden" name="page" value="${param.page}">
	                	<input type="hidden" name="action" value="delete">
	                    <div class="shoping__cart__btns" style="text-align:center;">
	                        <button type="button" class="site-btn" data-toggle="modal" data-target="#deleteModal">삭제</button>
	                        <a href="#" onclick="window.history.go(-1); return false;" class="primary-btn cart-btn cart-btn-right" style="float:none;">취소</a>
	                    </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

	<!-- Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteModalLabel">상품 삭제</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					    <span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">상품을 삭제하시겠습니까?</div>
				<div class="modal-footer">
				    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				    <button type="button" class="btn btn-primary" id="confirmDelete">확인</button>
				</div>
			</div>
		</div>
	</div>
    <!-- Product Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>