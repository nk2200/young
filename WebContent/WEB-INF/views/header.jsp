<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>올리브영 온라인몰</title>
<style>
body, html {
   font-family: Montserrat, -apple-system, NotoSansCJKkr, AppleSDGothicNeo,
      Roboto, dotum, "돋움", sans-serif;
}
</style>

<!-- Css Styles -->
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="/resource/css/bootstrap.min.css"
   type="text/css">
<link rel="stylesheet" href="/resource/css/font-awesome.min.css"
   type="text/css">
<link rel="stylesheet" href="/resource/css/elegant-icons.css"
   type="text/css">
<link rel="stylesheet" href="/resource/css/nice-select.css"
   type="text/css">
<link rel="stylesheet" href="/resource/css/jquery-ui.min.css"
   type="text/css">
<link rel="stylesheet" href="/resource/css/owl.carousel.min.css"
   type="text/css">
<link rel="stylesheet" href="/resource/css/slicknav.min.css"
   type="text/css">
<link rel="stylesheet" href="/resource/css/style.css" type="text/css">

</head>
<body>
   <!-- Page Preloder -->
   <div id="preloder">
      <div class="loader"></div>
   </div>

   <!-- Header Section Begin -->
   <header class="header">
      <div class="container">
         <div class="row">
            <div class="col-lg-3">
               <div class="header__logo">
                  <!-- 로고 클릭 시 메인으로 이동 -->
                  <a href="/main"><img src="../resource/img/logo1.png"
                     alt="Logo"></a>
               </div>
            </div>
            <div class="col-lg-9">
               <div class="header__cart">
                  <div class="header__cart__price">
                     <!-- admin일 때는 상품관리만 보이고, 그 외 사용자에게는 마이페이지만 보이게 처리 -->
                     <c:choose>
                        <c:when test="${not empty customerid and customerid != 'admin'}">
                           <!-- 고객이 admin이 아닐 경우 마이페이지 링크 표시 -->
                  		<span style="font-weight=200">young회원 <i style="font-weight: 700;">${customerid}님</i></span>&nbsp;&nbsp;
                     <ul>
                        <!-- <li><a href="#"><i class="fa fa-heart"></i> <span>1</span></a></li> -->
                          <li><a href="/cart/Cart.do?action=select"><i class="fa fa-shopping-bag"></i><span>3</span></a></li>
                     </ul>
                           <a href="MyPage.do">마이페이지</a>&nbsp;
                        </c:when>
                        <c:when test="${customerid == 'admin' }">
                           <a href="/manage/Manage.do">상품관리</a>&nbsp;                        
                        </c:when>
                        <c:otherwise>
                           <!-- 고객이 admin일 경우 상품관리 링크 표시 -->
	                        <span>로그인 해주세요!</span>&nbsp;
                        </c:otherwise>
                     </c:choose>

                     <div class="header__cart__price">
                        <!-- 로그인 메뉴 (로그인 여부에 따라 표시) -->
                        <c:choose>
                           <c:when test="${empty customerid}">
                              <a href="/customer/Login.do">로그인</a>
                           </c:when>
                           <c:otherwise>
                              <a href="/customer/Login.do?action=logout">로그아웃</a>
                              
                           </c:otherwise>
                        </c:choose>
                     </div>
                  </div>
               </div>
            </div>
            <div class="humberger__open">
               <i class="fa fa-bars"></i>
            </div>
         </div>
   </header>
   <!-- Header Section End -->

   <!-- Hero Section Begin -->
   <section class="hero hero-normal">
      <div class="container">
         <div class="row">
            <div class="col-lg-3">
               <div class="hero__categories">
                  <div class="hero__categories__all">
                     <i class="fa fa-bars"></i> <span>카테고리</span>
                  </div>
                  <ul>
					<li><a href="/category/Category.do?action=selectMain&goodsCategory=skin">스킨케어</a></li>
                     <li><a href="/category/Category.do?action=selectMain&goodsCategory=makeup">메이크업</a></li>
                     <li><a href="/category/Category.do?action=selectMain&goodsCategory=hair">헤어케어</a></li>
                     <li><a href="/category/Category.do?action=selectMain&goodsCategory=body">바디케어</a></li>
                     <li><a href="/category/Category.do?action=selectMain&goodsCategory=perfume">향수/디퓨저</a></li>

                  </ul>
               </div>
            </div>
            <!-- 삭제,yhl -->
            <!--                 <div class="col-lg-9">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="./index.jsp">Home</a></li>
                            <li><a href="./shop-grid.jsp">Shop</a></li>
                            <li><a href="#">Pages</a>
                                <ul class="header__menu__dropdown">
                                    <li><a href="./shop-details.jsp">Shop Details</a></li>
                                    <li><a href="./shoping-cart.jsp">Shoping Cart</a></li>
                                    <li><a href="./checkout.jsp">Check Out</a></li>
                                    <li><a href="./blog-details.jsp">Blog Details</a></li>
                                </ul>
                            </li>
                            <li><a href="./blog.jsp">Blog</a></li>
                            <li><a href="./contact.jsp">Contact</a></li>
                        </ul>
                    </nav>
                </div> -->
            <!--  위치 이동,yhl -->
            <div class="col-lg-7">
               <div class="hero__search">
                  <div class="hero__search__form">
                     <!-- 검색 폼으로 수정,yhl -->
                     <form action="/main" method="get">

                        <input type="text" name="searchName" placeholder="상품 검색"
                           value="${param.searchName}">
                        <button type="submit" class="site-btn">
                           <i class="bi bi-search text-dark"></i>
                        </button>
                     </form>
                  </div>

               </div>
            </div>
            <div class="col-lg-2"></div>
         </div>
      </div>
   </section>
   <!-- Hero Section End -->

</body>
</html>