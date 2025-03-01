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
<script type='text/javascript'>


	function deleteCart(cartid) {
	   
	    // 모달에 확인 메시지 설정
	    document.getElementById('modal-body-confirm').textContent = '상품을 삭제하시겠습니까?';
	    $('#simpleConfirmModal').modal('show');
	
	    // "확인" 버튼 클릭 시 실행할 로직
	    document.getElementById('simpleConfirmYes').onclick = function () {	        
	    	 $('#simpleConfirmModal').modal('hide'); // 확인 모달 닫기
	        // 삭제 요청 실행
	        fetch('/cart/Cart.do', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded',
	            },
	            body: new URLSearchParams({
	                action: "deleteCart",
	                cartid: cartid,
	            }),
	        })
	            .then(response => {
	                if (response.ok) {
	                    // 성공 메시지를 표시하는 모달
	                    document.getElementById('modal-body').textContent = '상품을 삭제했습니다.';
	                    $('#myModal').modal('show');
	
	                    // 모달이 닫힌 후 페이지 새로고침
	                    $('#myModal').on('hidden.bs.modal', function () {
	                        location.reload();
	                    });
	                } else {
	                    // 실패 메시지를 표시하는 모달
	                    document.getElementById('modal-body').textContent = '상품 삭제에 실패했습니다.';
	                    $('#myModal').modal('show');
	
	                    // 모달이 닫힌 후 페이지 새로고침
	                    $('#myModal').on('hidden.bs.modal', function () {
	                        location.reload();
	                    });
	                }
	            })
	            .catch(error => {
	                console.error('Error:', error);
	
	                // 오류 메시지를 표시하는 모달
	                document.getElementById('modal-body').textContent = '오류가 발생했습니다.';
	                $('#myModal').modal('show');
	
	                // 모달이 닫힌 후 페이지 새로고침
	                $('#myModal').on('hidden.bs.modal', function () {
	                    location.reload();
	                });
	            });
	    };
	
	    // "취소" 버튼 동작은 기본적으로 아무 작업도 하지 않음
	    document.getElementById('simpleConfirmCancel').onclick = function () {
	        $('#simpleConfirmModal').modal('hide'); // 확인 모달 닫기
	    };
	}

	
	function deleteSelect() {
	    // 확인 모달 띄우기
	    document.getElementById('modal-body-confirm').textContent = '상품을 삭제하시겠습니까?';
	    $('#simpleConfirmModal').modal('show');

	    // "확인" 버튼 클릭 시 실행할 로직
	    document.getElementById('simpleConfirmYes').onclick = function () {
	        $('#simpleConfirmModal').modal('hide'); // 확인 모달 닫기

	        const checkboxes = document.querySelectorAll('.item-checkbox');

	        // 선택된 체크박스의 value 값만 모은 배열 생성
	        const selectedItems = Array.from(checkboxes)
	            .filter(checkbox => checkbox.checked)
	            .map(checkbox => checkbox.value);

	        // 선택된 항목이 없으면 경고
	        if (selectedItems.length === 0) {
	            document.getElementById('modal-body').textContent = '선택된 상품이 없습니다.';
	            $('#myModal').modal('show');
	            return; // 이후 로직 실행 중단
	        }

	        // fetch로 데이터 전송
	        fetch('/cart/Cart.do', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded',
	            },
	            body: new URLSearchParams({
	                action: "selectDelete",
	                selectedItems: selectedItems.join(',') // 배열을 ','로 구분된 문자열로 전송
	            })
	        })
	        .then(response => {
	            if (response.ok) {
	                document.getElementById('modal-body').textContent = '상품을 삭제했습니다.';
	                $('#myModal').modal('show');
	            } else {
	                document.getElementById('modal-body').textContent = '상품 삭제에 실패했습니다.';
	                $('#myModal').modal('show');
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	            document.getElementById('modal-body').textContent = '오류가 발생했습니다.';
	            $('#myModal').modal('show');
	        });
	    };
	    
	    $('#myModal').on('hidden.bs.modal', function () {
	        location.reload();
	    });
	}

	
	function increase(cartid) {
		var quantity = document.getElementById("quantity_" + cartid); // 동적으로 찾기
		quantity.value = parseInt(quantity.value) + 1;
	    
		updateCartQty(cartid, quantity.value);
	  }

	  function decrease(cartid) {
		  var quantity = document.getElementById("quantity_" + cartid); // 동적으로 찾기
		   
	    if (parseInt(quantity.value) > 1) {
	      quantity.value = parseInt(quantity.value) - 1;
	    }
	    
	    updateCartQty(cartid, quantity.value);
	  }

	
	// 수량 업데이트 함수
	function updateCartQty(cartId, newQty) {
	
		fetch('/cart/Cart.do', {
		    method: 'POST',
		    headers: {
		        'Content-Type': 'application/x-www-form-urlencoded',
		    },
		    body: new URLSearchParams({
		        action: 'updateQty',
		        cartid: cartId,
		        cart_qty: newQty
		    })
		})
		.then(response => response.json())
		.then(data => {
		    if (data.status === 'success') {
		        // 수량 업데이트 성공 시 총 가격과 개수 업데이트
		        const totalPriceElement = document.getElementById("totalPrice");
		        const totalQtyElement = document.getElementById("totalQty");

		        if (totalPriceElement && totalQtyElement) {
		            totalPriceElement.textContent = data.totalPrice;
		            totalQtyElement.textContent = data.totalQty;
		        } else {
		            console.error("요소가 존재하지 않습니다.");
		        }

		        console.log("수량 업데이트 성공:", data);
		    } else {
		    	document.getElementById('modal-body').textContent = '수량업데이트 실패';
		        $('#myModal').modal('show');
		
		        // 모달이 닫힌 후 페이지를 새로고침
		        $('#myModal').on('hidden.bs.modal', function () {
		            location.reload();
		        });
		        
		    }
		})
		.catch(error => {
		    console.error("에러 발생:", error);
		    document.getElementById('modal-body').textContent = '수량 업데이트 중 오류가 발생했습니다.';
	        $('#myModal').modal('show');
	
	        // 모달이 닫힌 후 페이지를 새로고침
	        $('#myModal').on('hidden.bs.modal', function () {
	            location.reload();
	        });
		});

	}
	
	function selectPay() {
	    const checkboxes = document.querySelectorAll('.item-checkbox');
	    const selectedItems = Array.from(checkboxes)
	        .filter(checkbox => checkbox.checked) 
	        .map(checkbox => checkbox.value);   

	    if (selectedItems.length === 0) {
	    	document.getElementById('modal-body').textContent = '선택된 상품이 없습니다.';
	        $('#myModal').modal('show');
	
	        // 모달이 닫힌 후 페이지를 새로고침
	        $('#myModal').on('hidden.bs.modal', function () {
	            location.reload();
	        }); 
	        return;
	    }
	    
	    const params = new URLSearchParams();
	    params.append("action", "selectCart");
	    params.append("selectedItems", selectedItems.join(',')); // 배열을 ','로 구분된 문자열로 변환

	    fetch('/pay/Pay.do', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	        },
	        body: params
	    })
	    .then(response => response.json()) // 응답을 JSON으로 처리
	    .then(data => {
	        if (data.redirectUrl) {
	            window.location.href = data.redirectUrl; // 리다이렉트 URL로 이동
	        } else {
	        	document.getElementById('modal-body').textContent ='선택주문에 실패했습니다.';
		        $('#myModal').modal('show');
		
		        // 모달이 닫힌 후 페이지를 새로고침
		        $('#myModal').on('hidden.bs.modal', function () {
		            location.reload();
		        });  
	        }
	    })
	    .catch(error => {
	        console.error('Error:', error);
	        document.getElementById('modal-body').textContent ='오류가 발생했습니다.';
	        $('#myModal').modal('show');
	
	        // 모달이 닫힌 후 페이지를 새로고침
	        $('#myModal').on('hidden.bs.modal', function () {
	            location.reload();
	        });  
	    });
	}


	
	function allPay() {
	 
		let allCartIds = []; // cartid 값을 담을 배열

		// .cartid_value 클래스를 가진 모든 hidden input에서 cartid 값 가져오기
		document.querySelectorAll('.cartId').forEach(hiddenInput => {
		    allCartIds.push(hiddenInput.value); // cartid 값을 배열에 추가  
		});

		console.log(allCartIds); // 확인용 출력

		console.log('allCartIds' + allCartIds);
	    // 배열이 비어있는지 확인
	    if (allCartIds.length === 0) {
	    	document.getElementById('modal-body').textContent ='장바구니에 상품이 없습니다.';
	        $('#myModal').modal('show');
	
	        // 모달이 닫힌 후 페이지를 새로고침
	        $('#myModal').on('hidden.bs.modal', function () {
	            location.reload();
	        });
	    	
	        return;
	    }

	    // fetch로 데이터 전송
	    fetch('/pay/Pay.do', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	        },
	        body: new URLSearchParams({
	            action: 'allCart',  // 예시 액션
	            allIds: allCartIds.join(',')  // ','로 구분된 cartid 목록을 전송
	        })
	    })
	    .then(response => response.json()) // 응답을 JSON으로 처리
	    .then(data => {
	        if (data.redirectUrl) {
	            window.location.href = data.redirectUrl; // 리다이렉트 URL로 이동
	        } else {
	            
	        	document.getElementById('modal-body').textContent ='선택주문에 실패했습니다.';
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
	}


	
</script>
<style>
.shoping__cart__quantity {
	text-align: center; /* 테이블 셀 내에서 중앙 정렬 */
}

.quantity-container {
	display: flex;
	justify-content: center;
	align-items: center;
}

.quantity-container button, .quantity-container input {
	margin: 0 5px; /* 버튼 간의 간격을 설정 */
}

.quantity-container input {
	width: 40px; /* 원하는 입력 크기 설정 */
	text-align: center; /* 입력값 가운데 정렬 */
}

.shoping__cart__table {
	width: 100%;
	margin-top: 20px; /* 테이블 위쪽 마진 */
}

.shoping__cart__table {
	width: 100%;
	margin-top: 20px;
}

.shoping__cart__table table {
	width: 100%;
	border-collapse: collapse; /* 셀 간 경계가 겹치지 않도록 설정 */
}

th, td {
	border: 1px solid #ebebeb; /* 셀에 경계 추가 */
	padding: 10px; /* 셀 안의 여백 설정 */
	text-align: left; /* 텍스트 왼쪽 정렬 */
}

th {
	background-color: #f9f9f9; /* 헤더 배경 색상 설정 */
	font-weight: bold; /* 헤더 글자 두껍게 설정 */
}

.shoping__cart__item__check {
	border: none; /* 선을 제거 */
}

.shoping__cart__item__check input[type="checkbox"] {
	margin-right: 10px; /* 체크박스와 텍스트 간격 추가 */
}

.shoping__cart__quantity button {
	background-color: #f27370; /* 버튼 배경색 */
	color: white; /* 버튼 텍스트 색상 */
	border: none;
	padding: 5px 10px;
	cursor: pointer;
}

.shoping__cart__quantity input[type="text"] {
	width: 40px;
	text-align: center;
	padding: 5px;
	border: 1px solid #ccc;
}

.shoping__cart__total a {
	text-decoration: none;
	color: #f27370; /* 텍스트 색상 */
}

.shoping__cart__total a:hover {
	color: #d25a5a; /* hover 시 텍스트 색상 변경 */
}
</style>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>


	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="/resource/img/cart/cartheader.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div style="color: black;" class="breadcrumb__text">
						<h2 style="color: black;">장바구니</h2>
						<a href="/" style="color: black;"><i class="bi bi-house-door"></i></a>
						<span>&nbsp;></span> <span style="color: black;">Shopping
							Cart</span>

					</div>
				</div>
			</div>
		</div>
	</section>


	<br>
	<br>
	<!-- Shoping Cart Section Begin -->
	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__table">
						<span>올리브영 배송상품 </span>
						<table>
							<thead>
								<tr>
									<th></th>
									<th class="shoping__product">상품정보</th>
									<th>판매가</th>
									<th>수량</th>
									<th>선택</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="cart" items="${cartList}">
									<tr>
										<td class="shoping__cart__item__check"><input
											type="checkbox" value="${cart.cartid}" checked
											class="item-checkbox" /> <input type="hidden"
											value="${cart.cartid}" id="cartid_value" /> <input
											type="hidden" value="${cart.cartid}" class="cartId" /></td>
										<td class="shoping__cart__item"><img
											src="/resource/img/goods/${cart.goods.goods_fname_main}"
											alt="">
											<h5>${cart.goods.goods_name}</h5></td>
										<td class="shoping__cart__price">
											${cart.goods.goods_price}</td>
										<td class="shoping__cart__quantity">
											<div class="quantity-container">
												<button type="button" onclick="decrease('${cart.cartid}')">-</button>
												<input type="text" id="quantity_${cart.cartid}"
													value="${cart.cart_qty}">
												<button type="button" onclick="increase('${cart.cartid}')">+</button>
											</div>

										</td>

										<td class="shoping__cart__total"><a
											href="/detail/Detail.do?goodsid=${cart.goods.goodsid }"
											class="icon_cursor_alt"><span class="icon"></span> 상세</a> <br>
											<a href="#" onclick="deleteCart(${cart.cartid})" class="icon_close"><span
												class="icon"></span> 삭제</a></td>
									</tr>
								</c:forEach>


							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__btns">
						<a href="#" class="primary-btn cart-btn" onclick="deleteSelect()">선택
							상품 삭제</a>
					</div>

				</div>

				<div class="col-lg-12">
					<div class="shoping__checkout">
						<ul>
							<li>총 판매가 <span id="totalPrice">${totalPrice }</span></li>
							<li>총 개수 <span id="totalQty">${totalQty }</span></li>
						</ul>
						<div class="order_btn_area">
							<a class="select-btn" onclick="selectPay()">선택주문 </a>
							&nbsp;&nbsp;&nbsp; <a class="all-btn" onclick="allPay()">전체주문</a>
						</div>
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
		
	<!-- Shoping Cart Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>