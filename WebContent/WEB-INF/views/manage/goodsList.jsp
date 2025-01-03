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
    <script type="text/javascript">
	    window.addEventListener("load", () => {
		    document.querySelectorAll(".sidebar__item a").forEach(link => {
		        const id = link.id;
		        if (id === 'all') {
			        link.href = '/manage/Manage.do';
				} else {
		        	link.href = '/manage/Manage.do?category=' + id;
				}
		    });
		    
		    document.querySelectorAll(".product__pagination a").forEach(link => {
		    	const params = new URLSearchParams(window.location.search);
		    	let url = link.href;

		    	const category = params.get("category");
		    	if (category != null) {
		    		link.href = url + '&category=' + category;
		    	}

		    	const searchName = params.get("searchName");
		    	if (searchName != null) {
		    		link.href = url + '&searchName=' + searchName;
		    	}
		    });
		    
		    document.querySelectorAll(".product__item__pic__hover a").forEach(link => {
		    	const params = new URLSearchParams(window.location.search);
		    	let url = link.href;

		    	const category = params.get("category");
		    	if (category != null) {
		    		url += '&category=' + category;
		    	}

		    	const searchName = params.get("searchName");
		    	if (searchName != null) {
		    		url += '&searchName=' + searchName;
		    	}

		    	const page = params.get("page");
		    	if (page != null) {
		    		url += '&page=' + page;
		    	}
		    	link.href = url;
		    });
	    });
    </script>
    <style>
		.noResult {
		    display: flex; /* flexbox를 사용하여 자식 요소들을 배치 */
		    flex-direction: column; /* 자식 요소들을 수직으로 배치 */
		    align-items: center; /* 자식 요소들을 수평으로 중앙 배치 */
		    width: 100%; /* 부모 div의 너비를 100%로 설정 */
		    padding: 20px 20px 50px; /* 패딩을 추가하여 요소들이 너무 붙지 않게 설정 */
		}
		
		.noResultImg {
		    width: 100px; /* 이미지의 너비 */
		    height: 100px; /* 이미지의 높이 */
		    background-position: center; /* 배경 이미지 중앙 정렬 */
		    background-repeat: no-repeat; /* 배경 이미지 반복 방지 */
		    background-size: contain; /* 배경 이미지가 요소에 맞게 조정 */
		}
		
		.test {
		    font-size: 18px;
		    font-weight: bold;
		    margin-bottom: 10px;
		    width: 100%;
		    display: flex;
		    justify-content: center;
		}
		
		.subMsg {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
			font-size: 14px;
		}
		
		#current_page {
			background: #7fad39;
			border-color: #7fad39;
			color: #ffffff;
		}
</style>
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
                            	<li><a href="#" id="all">전체</a></li>
                            	<li><a id="skin">스킨케어</a></li>
	                            <li><a id="makeup">메이크업</a></li>
	                            <li><a id="hair">헤어케어</a></li>
	                            <li><a id="body">바디케어</a></li>
	                            <li><a id="perfume">향수/디퓨저</a></li>
                            </ul>
                        </div>
                        <div>
                        	<a href="/manage/Manage.do?action=register" style="padding: 14px 32px;" class="primary-btn">상품 등록</a>
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
			                            <form action="/manage/Manage.do">
			                                <input type="text" placeholder="상품 검색" name="searchName" value="${param.searchName}">
			                                <button type="submit" class="site-btn">SEARCH</button>
			                            </form>
			                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                    	<c:if test="${not empty noResult}">
					         <div class="noResult"> 
								<div class="noResultImg" style="background-image: url('../resource/img/goods/noResult.png');">
								</div>
								<div class="test">검색 결과가 없어요</div>
								<div class="subMsg">
									<div class="test1">철자를 확인하거나</div>
									<div class="test2">다른 키워드로 검색해보세요.</div>
								</div>
					         </div> 
					    </c:if> 
	                    <c:forEach var="item" items="${goods}">
	                        <div class="col-lg-4 col-md-6 col-sm-6">
	                            <div class="product__item">
	                                <div class="product__item__pic set-bg" data-setbg="../resource/img/goods/${item.goods_fname_main}">
	                                	<ul class="product__item__pic__hover">
	                                        <li><a href="/manage/Manage.do?action=update&goodsid=${item.goodsid}"><i class="fa fa-pencil"></i></a></li>
	                                        <li><a href="/manage/Manage.do?action=delete&goodsid=${item.goodsid}"><i class="fa fa-trash"></i></a></li>
	                                    </ul>
	                                </div>
	                                <div class="product__item__text">
	                                    <span style="color:#b2b2b2;margin-bottom:7px;display:block;font-size:14px;">
	                                    	${item.goods_category}
	                                    </span>
	                                    <h6><b><a href="/detail/Detail.do?goodsid=${item.goodsid}">${item.goods_name}</a></b></h6>
	                                    <h6>${item.goods_price}원</h6>
	                                    <h6>수량: ${item.goods_qty}</h6>
	                                </div>
	                            </div>
	                        </div>
                        </c:forEach>
                    </div>
                    
                    <div class="product__pagination">
                    	<!-- 이전 페이지 버튼 -->
                    	<c:if test="${param.page > 1}">
	                        <a href="/manage/Manage.do?page=${param.page-1}">
	                        <i class="fa fa-long-arrow-left"></i></a>
                    	</c:if>
                    	
                    	<!-- 페이지 번호 -->
                    	<c:set var="currentPage" value="${empty param.page ? 1 : param.page}" />
                    	<c:forEach var="i" begin="1" end="${totalPages}">
                    		<c:choose>
                    			<c:when test="${currentPage == i}">
	                        		<a id="current_page" onclick="event.preventDefault();">${i}</a>
                    			</c:when>
                    			<c:otherwise>
                    				<a href="/manage/Manage.do?page=${i}">${i}</a>
                    			</c:otherwise>
                    		</c:choose>
                    	</c:forEach>
                    	
                    	<!-- 다음 페이지 -->
                    	<c:if test="${currentPage < totalPages}">
                        	<a href="/manage/Manage.do?page=${currentPage+1}"><i class="fa fa-long-arrow-right"></i></a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->
<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>