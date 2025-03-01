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
<style>
.table {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 테이블 전체 그림자 */
    border-radius: 8px; /* 모서리 둥글게 */
    overflow: hidden; /* 테두리 둥글게 적용 */
  }
.active-category {
	background-color: #f27370; /* 배경색 */
	font-weight: bold; /* 텍스트 두께 */
}

.text-white {
	color: #fff; /* 텍스트 색상 */
}

.table a {
	color: black;
}

.table a:hover {
	color: black; /* 텍스트 색상 */
}
</style>
<script>

	

	function addCart(goodsid){
				
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
					document.getElementById('modal-body').textContent ='장바구니에 추가되었습니다.';
			        $('#myModal').modal('show');
			
			        // 모달이 닫힌 후 페이지를 새로고침
			        $('#myModal').on('hidden.bs.modal', function () {
			            location.reload();
			        });
					
				}else{
					document.getElementById('modal-body').textContent ='장바구니 추가에 실패했습니다.';
			        $('#myModal').modal('show');
			
			        // 모달이 닫힌 후 페이지를 새로고침
			        $('#myModal').on('hidden.bs.modal', function () {
			            location.reload();
			        });
					
				}
			})
			.catch(error => {
				console.error('Error :', error);
				document.getElementById('modal-body').textContent ='오류가 발생했습니다.';
		        $('#myModal').modal('show');
		
		        // 모달이 닫힌 후 페이지를 새로고침
		        $('#myModal').on('hidden.bs.modal', function () {
		            location.reload();
		        });
			});
	    };
	}


</script>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>



	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="/resource/img/categories/rankheader.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h2 style="color:black;">랭킹</h2>
						<span style="color:black;">오늘의 랭킹! 요즘 가장 핫한 상품</span>

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
				<div class="col-lg-12 col-md-7">
					<div class="row">
						<table class="table table-bordered text-center">
							<thead>
								<tr>
									<th scope="col"
										class="${goodsCategory == 'all' ? 'active-category' : ''}">
										<a href="/category/Category.do?action=selectRank&goodsCategory=all"
										class="${goodsCategory == 'all' ? 'text-white' : ''}">전체</a>
									</th>
									<th scope="col"
										class="${goodsCategory == 'skin' ? 'active-category' : ''}">
										<a href="/category/Category.do?action=selectRank&goodsCategory=skin"
										class="${goodsCategory == 'skin' ? 'text-white' : ''}">스킨케어</a>
									</th>
									<th scope="col"
										class="${goodsCategory == 'makeup' ? 'active-category' : ''}">
										<a href="/category/Category.do?action=selectRank&goodsCategory=makeup"
										class="${goodsCategory == 'makeup' ? 'text-white' : ''}">메이크업</a>
									</th>
									<th scope="col"
										class="${goodsCategory == 'hair' ? 'active-category' : ''}">
										<a href="/category/Category.do?action=selectRank&goodsCategory=hair"
										class="${goodsCategory == 'hair' ? 'text-white' : ''}">헤어케어</a>
									</th>
									<th scope="col"
										class="${goodsCategory == 'body' ? 'active-category' : ''}">
										<a href="/category/Category.do?action=selectRank&goodsCategory=body"
										class="${goodsCategory == 'body' ? 'text-white' : ''}">바디케어</a>
									</th>
									<th scope="col"
										class="${goodsCategory == 'perfume' ? 'active-category' : ''}">
										<a href="/category/Category.do?action=selectRank&goodsCategory=perfume"
										class="${goodsCategory == 'perfume' ? 'text-white' : ''}">향수/디퓨저</a>
									</th>
								</tr>
							</thead>
						</table>


					</div>
					<br><br>
					<div class="row">
						<c:forEach var="goods" items="${goods_like}">
							<!-- 한 상품을 표시할 div -->
							<div class="col-lg-3 col-md-6 col-sm-6">
								<div class="product__item">
									<div class="product__item__pic set-bg"
										data-setbg="/resource/img/goods/${goods.goods_fname_main}">
										<ul class="product__item__pic__hover">
											
											<li><a href="#" onclick="addCart(${goods.goodsid})"><i class="fa fa-shopping-cart"></i></a></li>
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