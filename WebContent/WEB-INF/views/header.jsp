<%@ page contentType="text/html; charset=UTF-8"%>
<% %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

  <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="/resource/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/resource/css/slicknav.min.css" type="text/css">
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
                        <a href="./index.jsp"><img src="../resource/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-6">
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
                </div>
                <div class="col-lg-3">
                    <div class="header__cart">
                        <ul>
                            <li><a href="#"><i class="fa fa-heart"></i> <span>1</span></a></li>
                            <li><a href="#"><i class="fa fa-shopping-bag"></i> <span>3</span></a></li>
                        </ul>
                        <!-- <div class="header__cart__price">item: <span>$150.00</span></div> -->
                        <div class="header__cart__price"><a href="MyPage.do">MyPage</a></div> <!-- 마이페이지 메뉴로 수정,yhl -->
                    </div>
                </div>
            </div>
            <div class="humberger__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->
</body>
</html>