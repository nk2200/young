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
<script>
	function addCart(goodsid){
	
		// 모달에 확인 메시지 설정
	    document.getElementById('modal-body-confirm').textContent = '상품을 장바구니에 추가하시겠습니까?';
	    $('#simpleConfirmModal').modal('show');
	
	    // "확인" 버튼 클릭 시 실행할 로직
	    document.getElementById('simpleConfirmYes').onclick = function () {	   
	    	 $('#simpleConfirmModal').modal('hide'); // 확인 모달 닫기
	        fetch('/cart/Cart.do', {
	            method : 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded',
	            },
	            body: new URLSearchParams({
	                action: "addCart",
	                goodsid: goodsid
	            })
	        }).then(response => {
	            if(response.ok){
	            	document.getElementById('modal-body').textContent = '장바구니에 추가하였습니다.';
			        $('#myModal').modal('show');

			        // 모달이 닫힌 후 페이지를 새로고침
			        $('#myModal').on('hidden.bs.modal', function () {
			            location.reload();
			        });
	            } else {
	            	document.getElementById('modal-body').textContent = '장바구니 추가에 실패했습니다.';
			        $('#myModal').modal('show');

			        // 모달이 닫힌 후 페이지를 새로고침
			        $('#myModal').on('hidden.bs.modal', function () {
			            location.reload();
			        });
	                
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	            document.getElementById('modal-body').textContent = '오류가 발생했습니다.';
		        $('#myModal').modal('show');

		        // 모달이 닫힌 후 페이지를 새로고침
		        $('#myModal').on('hidden.bs.modal', function () {
		            location.reload();
		        });
			});
	    };
	}
	
	function addCartNomal(goodsid){
				
		// 모달에 확인 메시지 설정
	    document.getElementById('modal-body-confirm').textContent = '상품을 장바구니에 추가하시겠습니까?';
	    $('#simpleConfirmModal').modal('show');
	
	    // "확인" 버튼 클릭 시 실행할 로직
	    document.getElementById('simpleConfirmYes').onclick = function () {	   
	    	 $('#simpleConfirmModal').modal('hide'); // 확인 모달 닫기
			fetch('/cart/Cart.do',{
				method : 'POST',
				headers: {
				    'Content-Type': 'application/x-www-form-urlencoded',
				},
				body: new URLSearchParams({
				    action: "addCart",
				    goodsid: goodsid
				})

			}).then(response =>{
				if(response.ok){
					document.getElementById('modal-body').textContent = '장바구니에 추가되었습니다.';
			        $('#myModal').modal('show');

			        // 모달이 닫힌 후 페이지를 새로고침
			        $('#myModal').on('hidden.bs.modal', function () {
			            location.reload();
			        });
					
				}else{
					document.getElementById('modal-body').textContent = '장바구니 추가에 실패했습니다.';
			        $('#myModal').modal('show');

			        // 모달이 닫힌 후 페이지를 새로고침
			        $('#myModal').on('hidden.bs.modal', function () {
			            location.reload();
			        });
						
				}
			})
			.catch(error => {
				console.error('Error :', error);
				document.getElementById('modal-body').textContent = '오류가 발생했습니다.';
		        $('#myModal').modal('show');

		        // 모달이 닫힌 후 페이지를 새로고침
		        $('#myModal').on('hidden.bs.modal', function () {
		            location.reload();
		        });
			});
	    };
	}
	
	
</script>
<style>
	.circle {
	  text-align: center;
	}
	
	.circle-img {
	  width: 150px;
	  height: 150px;
	  border-radius: 50%;
	  object-fit: cover;
	}
	
	.circle-text {
	  margin-top: 10px;	 
	  font-size: 18px;
	  color: #333;
	  font-family: Arial, sans-serif;
	}
	
	.headerrow {
	  display: flex;
	  gap: 20px; /* 사진들 간의 간격을 설정 */
	  justify-content: center; /* 수평 중앙 정렬 */
	  align-items: center; /* 수직 중앙 정렬 */
	}
	
	#gotoBest{
		text-align: center;
	    font-size: 22px;
	    line-height: 24px;
	    color: #333;
	    font-weight: 700;
	}
	
</style>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>



	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="/resource/img/categories/category_main.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2 style="color:black;" style="color:black;">${goodsCategory} 부분</h2>
						
							<a href="/" style="color:black;"><i class="bi bi-house-door"></i></a> 
							 <span>&nbsp;></span> 
							<span style="color:black;">${goodsCategory}</span>
						
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container">
			<p id="gotoBest">Best 상품 보러가기</p>
			<br>
			<div class="headerrow">				
					<div class="circle">
					    <a href="/category/Category.do?action=selectRank&goodsCategory=skin"><img src="/resource/img/categories/category_skin.png" alt="Image" class="circle-img"></a>
					    <p class="circle-text">스킨</p>
					 </div>
					 <div class="circle">
					    <a href="/category/Category.do?action=selectRank&goodsCategory=makeup"><img src="/resource/img/categories/category_makeup.png" alt="Image" class="circle-img"></a>
					    
					    <p class="circle-text">메이크업</p>
					 </div>
					 <div class="circle">
					    <a href="/category/Category.do?action=selectRank&goodsCategory=hair"><img src="/resource/img/categories/category_hair.png" alt="Image" class="circle-img"></a>
					    <p class="circle-text">헤어케어</p>
					 </div>
					 <div class="circle">
					    <a href="/category/Category.do?action=selectRank&goodsCategory=body"><img src="/resource/img/categories/category_body.png" alt="Image" class="circle-img"></a>
					    <p class="circle-text">바디케어</p>
					 </div>
					 <div class="circle">
					    <a href="/category/Category.do?action=selectRank&goodsCategory=perfume"><img src="/resource/img/categories/category_perfume.png" alt="Image" class="circle-img"></a>
					    <p class="circle-text">향수/디퓨저</p>
					 </div>
				
             </div>
             <br><br><br> 
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
												data-setbg="/resource/img/goods/${goods_like.goods_fname_main}">
												<ul class="product__item__pic__hover">
													
													<li><a href="#" onclick="addCart(${goods_like.goodsid})"><i class="fa fa-shopping-cart"></i></a></li>
												</ul>
											</div>
											<div class="product__discount__item__text">
												<span>${goods_like.goods_category}</span>
												<h5>
													<a href="/detail/Detail.do?goodsid=${goods_like.goodsid}">${goods_like.goods_name}</a>
												</h5>
												<span>${goods_like.goods_price}</span>
											</div>
											 
										</div>
									</div>

								</c:forEach>
							</div>
						</div>
						<br><br><br>
						<div style="display: flex; justify-content: center; align-items: center;" class="row" >
						    <a href="/category/Category.do?action=selectRank&goodsCategory=${goodsCategory}" class="goRankbtn">${goodsCategory} 베스트 상품 더보기 ></a>
						</div>

					</div>
					
					<div class="filter__item">
						<div class="row">

							<div class="col-lg-4 col-md-4">
								<div class="filter__found">
									<h6>
										<span>${goods_count}</span> 개의 상품
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
										data-setbg="/resource/img/goods/${goods.goods_fname_main}">
										<ul class="product__item__pic__hover">
											
											<li><a href="#" onclick="addCartNomal(${goods.goodsid})"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
									<div class="product__item__text">
										<h6>
											<a href="/detail/Detail.do?goodsid=${goods.goodsid}">${goods.goods_name}</a>										
										</h6>
										<h5>${goods.goods_price}</h5>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>				
				</div>
			</div>
		</div>
	</section>
	
	<div id="myModal" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title"><i class="bi bi-exclamation-triangle"></i>&nbsp;&nbsp;올리브영 알림</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modal-body">
					<!-- 메시지가 동적으로 추가됩니다 -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Confirm Modal -->
	<div id="simpleConfirmModal" class="modal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title"><i class="bi bi-check-square"></i>&nbsp;&nbsp;올리브영 확인메시지</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body-confirm" id="modal-body-confirm" >
	        
	      </div>
	      <div class="modal-footer">
	        <button id="simpleConfirmYes" type="button" class="btn btn-primary">확인</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- Product Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>