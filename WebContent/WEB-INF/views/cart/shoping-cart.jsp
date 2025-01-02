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
	function deleteCart(){
		const deleteId = document.getElementById("cartid_value");
		const cartid = deleteId.value;
		
		console.log('cartid' + cartid);
		if(confirm('삭제하시겠습니까 ?')){
			fetch('/cart/Cart.do',{
				method : 'POST',
				headers :{
					'Content-Type': 'application/x-www-form-urlencoded',
				},
				body : new URLSearchParams({
					action : "deleteCart",
					cartid : cartid
				})
			}).then(response =>{
				if(response.ok){
					alert('상품을 삭제했습니다.');
					location.reload();
				}else{
					alert('상품 삭제에 실패했습니다.');
					location.reload();
				}
			})
			.catch(error => {
				console.error('Error :', error);
				alert('오류가 발생했습니다.');
			})
			
		}else {
			alert('삭제를 취소하였습니다.');
		}
		
	}
	
	
	function deleteSelect(){
		const checkboxes = document.querySelectorAll('.item-checkbox');
		
		const selectedItems = Array.from(checkboxes)
	        .filter(checkbox => checkbox.checked) 
	        .map(checkbox => checkbox.value);   

	    if (selectedItems.length === 0) {
	        alert('선택된 상품이 없습니다.');
	        return;
	    }
	    
	    const params = new URLSearchParams();
	    params.append("selectedItems", selectedItems.join(','));  // 배열을 ','로 구분된 문자열로 변환

        
	    console.log('선택된 항목', selectedItems);
	    
		fetch('/cart/Cart.do',{
			method: 'POST',
			headers :{
				'Content-Type': 'application/x-www-form-urlencoded',
			},
			body :  new URLSearchParams({
				action : "selectDelete",
				selectedItems : params
			})
		})
		.then(response =>{
			if(response.ok){
				alert('상품을 삭제했습니다.');
				location.reload();
			}else{
				alert('상품 삭제에 실패했습니다.');
			}
		})
		.catch(error => {
			console.error('Error :', error);
			alert('오류가 발생했습니다.');
		})
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
		// JavaScript (fetch 요청 후 업데이트)
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
		        console.error("수량 업데이트 실패");
		        alert("수량 업데이트 실패");
		    }
		})
		.catch(error => {
		    console.error("에러 발생:", error);
		    alert("수량 업데이트 중 문제가 발생했습니다.");
		});

	}
	
	function selectPay(){

		const checkboxes = document.querySelectorAll('.item-checkbox');
		const selectedItems = Array.from(checkboxes)
	        .filter(checkbox => checkbox.checked) 
	        .map(checkbox => checkbox.value);   

	    if (selectedItems.length === 0) {
	        alert('선택된 상품이 없습니다.');
	        return;
	    }
	    
	    const params = new URLSearchParams();
	    params.append("selectedItems", selectedItems.join(','));  // 배열을 ','로 구분된 문자열로 변환

        
	    console.log('선택된 항목', selectedItems);
	    
		fetch('/pay/Pay.do',{
			method: 'POST',
			headers :{
				'Content-Type': 'application/x-www-form-urlencoded',
			},
			body :  new URLSearchParams({
				action : "selectCart",
				selectedItems :  selectedItems.join(',') 
			})
		})
		.then(response =>{
			if(response.ok){
				alert('구매 페이지로 이동합니다.');
			}else{
				alert('선택주문에 실패했습니다.');
			}
		})
		.catch(error => {
			console.error('Error :', error);
			alert('오류가 발생했습니다.');
		})
	}

	
	function allPay() {
	    let allCartIds = []; // cartid 값을 담을 배열

	    // .cartid_value 클래스를 가진 모든 hidden input에서 cartid 값 가져오기
	     document.querySelectorAll('#cartid_value').forEach(hiddenInput => {
	        allCartIds.push(hiddenInput.value); // cartid 값을 배열에 추가
	    });
	
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
	    .then(response =>{
			if(response.ok){
				alert('구매 페이지로 이동합니다.');
			}else{
				alert('전체 주문에 실패했습니다.');
			}
		})
		.catch(error => {
			console.error('Error :', error);
			alert('오류가 발생했습니다.');
		})
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

  .quantity-container button,
  .quantity-container input {
    margin: 0 5px; /* 버튼 간의 간격을 설정 */
  }

  .quantity-container input {
    width: 40px; /* 원하는 입력 크기 설정 */
    text-align: center; /* 입력값 가운데 정렬 */
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
					<div style="color:black;"class="breadcrumb__text" >
						<h2 style="color:black;">장바구니</h2>
							<a href="/" style="color:black;"><i class="bi bi-house-door"></i></a>
							 <span>&nbsp;></span> 
							<span style="color:black;">Shopping
								Cart</span>
					
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

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

									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="cart" items="${cartList}">
									<tr>
										<td class="shoping__cart__item__check"><input
											type="checkbox" value="${cart.cartid}" checked
											class="item-checkbox" /> <input type="hidden"
											value="${cart.cartid}" id="cartid_value" /></td>
										<td class="shoping__cart__item"><img
											src="/resource/img/goods/${cart.goods.goods_fname_main}" alt="">
											<h5>${cart.goods.goods_name}</h5></td>
										<td class="shoping__cart__price">
											${cart.goods.goods_price}</td>
										<td class="shoping__cart__quantity">
											<div class="quantity-container">
											    <button type="button" onclick="decrease('${cart.cartid}')">-</button>
											    <input type="text" id="quantity_${cart.cartid}" value="${cart.cart_qty}">
											    <button type="button" onclick="increase('${cart.cartid}')">+</button>
											</div>

										</td>

										<td class="shoping__cart__total">
											<a href="/detail/Detail.do?goodsid=${cart.goods.goodsid }" class="icon_cursor_alt"><span class="icon"></span>
												상세</a> <br> 
											<a href="#" onclick="deleteCart()" class="icon_close"><span class="icon"></span> 삭제</a></td>
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
							<a class="select-btn" onclick="selectPay()">선택주문 </a> &nbsp;&nbsp;&nbsp;
							<a href="#"class="all-btn" onclick="allPay()">전체주문</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Shoping Cart Section End -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>