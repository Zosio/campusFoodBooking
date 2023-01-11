<%@ page import="com.booking.domain.User" %>
<%@ page import="com.booking.util.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>云餐厅</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/style-customer.css">
	<link rel="stylesheet" href="css/style-shoppingCart-order.css" type="text/css" media="all" />
	<%
		User user= (User) session.getAttribute(Constants.USER_SESSION);
		long userid =user.getUserId();
		String username=user.getUserName();
		String useremail=user.getUserAccount();
		String userphone=user.getUserPhone();
		pageContext.setAttribute("userId",userid);
		pageContext.setAttribute("userName",username);
		pageContext.setAttribute("userEmail",useremail);
		pageContext.setAttribute("userPhone",userphone);
	%>
</head>

<body>
<script defer="defer">
	var price=new Number;
	price=0;
	var detail="";
	function showbuy(){
		price=0;
		detail="";
		var itemnumber=document.querySelector('.items').children;
		for(var i=0;i<itemnumber.length;i++){
			var price1=itemnumber[i].children[0].children[4].children[0].children[1].innerHTML;
			price1.substr(1,price1.length-1);
			var numberfood=itemnumber[i].children[0].children[3].children[0].children[0].getAttribute('value');
			console.log(numberfood);
			numberfood.substr(1,numberfood.length-1);
			price=price+Number(price1)*Number(numberfood);
			detail=detail+itemnumber[i].children[0].children[2].children[0].innerHTML+"*1,";
		}

		console.log(price)
		console.log(detail)
		document.querySelector('.total2').innerHTML=price;
	}
	function addOrder(){
		$.post('order.do',
				{'price':price,'detail':detail,"userId":${userId},'type':'addFoodFromCart'},function(){
					price=0;
					detail="";
				})
	}
</script>
<script defer="defer">
	function addToCart(id){
		$.post('food.do',
				{'id':id,'type':'getFoodById'},
		function (result){
			var foodiD=result.data.foodId;
			var classname=".close"+foodiD;
			var div=document.querySelector('.item11').cloneNode(true);
			var div2=document.querySelector('.items');
			div2.appendChild(div);
			document.querySelector(".item11").removeAttribute('hidden');
			document.querySelector(".item11").setAttribute('class',"item"+result.data.foodId);
			document.querySelector(".close11").setAttribute('class','close'+result.data.foodId);
			document.querySelector(".alert-close11").setAttribute('class',"alert-close"+result.data.foodId);
			document.querySelector(classname).children[1].children[0].setAttribute('src',"images/"+result.data.foodImage);
			document.querySelector(classname).children[2].children[0].innerHTML=result.data.foodName;
			document.querySelector(classname).children[4].children[0].children[1].innerHTML=result.data.foodPrice;
			var js =document.createTextNode("$(document).ready(function (c){");
			js.appendData("$('.alert-close");
			js.appendData(result.data.foodId+"').on('click',function(c){");
			js.appendData("$('.close"+result.data.foodId+"').fadeOut('slow',function(c){");
			js.appendData("$('.item"+result.data.foodId+"').remove();");
			js.appendData("});");
			js.appendData("});");
			js.appendData("});");
			var jss=document.createElement('script');
			jss.type="text/javascript";
			jss.setAttribute('id','js');
			document.querySelector("body").appendChild(jss);
			$('#js').html(js);
			document.querySelector('#js').setAttribute('id','jss'+result.data.foodId);

			showbuy();

		})
	}


</script>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light ftco-navbar-light-2"
		id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="main-customer.html">韶大云餐厅</a>
			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<!-- 导航栏 -->
					<li class="nav-item"><a href="main-customer.jsp" class="nav-link">首页</a></li>
					<li class="nav-item"><a href="order.jsp" class="nav-link">订单</a></li>
					<li class="nav-item"><a href="pCenter.jsp" class="nav-link">个人中心</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- END nav -->

	<section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_4.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate text-center">
					<h1 class="mb-2 bread">品园</h1>
					<p class="breadcrumbs">
						<span class="mr-2"><a href="main-customer.html">Home <i class="ion-ios-arrow-forward"></i></a></span>
						<span>Menu</span>
					</p>
				</div>
			</div>
		</div>
	</section>

	<!-- 菜式展示部分 -->
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center mb-5 pb-2">
				<div class="col-md-7 text-center heading-section ftco-animate">
					<h2 class="mb-4">美味佳肴</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3 >早餐</h3>
					</div>
					<c:forEach items="${foodlist}" var="foods">
						<c:if test="${foods.foodType eq '早'}">
							<div class="menus d-flex ftco-animate">
<%--								<form>--%>
									<div class="menu-img img" name="img" style="background-image: url(images/${foods.foodImage});"></div>
									<div class="text">
										<div class="d-flex">
											<div class="one-half">
												<h3 name="name">${foods.foodName}</h3>
											</div>
											<div class="one-forth">
												<span>$</span><span class="price" name="price">${foods.foodPrice}</span>
												<button class="add_btn" onclick="addToCart(${foods.foodId})">添加</button>
											</div>
										</div>
										<p><span>备注：</span><span name="detail">${foods.foodDetail}</span></p>
									</div>
<%--								</form>--%>
							</div>
						</c:if>
					</c:forEach>
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3 >午餐</h3>
					</div>
					<c:forEach items="${foodlist}" var="foods">
						<c:if test="${foods.foodType eq '中'}">
							<div class="menus d-flex ftco-animate">
								<div class="menu-img img" name="img" style="background-image: url(images/${foods.foodImage});"></div>
								<div class="text">
									<div class="d-flex">
										<div class="one-half">
											<h3 name="name">${foods.foodName}</h3>
										</div>
										<div class="one-forth">
											<span>$</span><span class="price" name="price">${foods.foodPrice}</span>
											<button class="add_btn" onclick="addToCart(${foods.foodId})">添加</button>
										</div>
									</div>
									<p><span>备注：</span><span name="detail">${foods.foodDetail}</span></p>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3 >晚餐</h3>
					</div>
					<c:forEach items="${foodlist}" var="foods">
						<c:if test="${foods.foodType eq '晚'}">
							<div class="menus d-flex ftco-animate">
								<div class="menu-img img" name="img" style="background-image: url(images/${foods.foodImage});"></div>
								<div class="text">
									<div class="d-flex">
										<div class="one-half">
											<h3 name="name">${foods.foodName}</h3>
										</div>
										<div class="one-forth">
											<span>$</span><span class="price" name="price">${foods.foodPrice}</span>
											<button class="add_btn" onclick="addToCart(${foods.foodId})">添加</button>
										</div>
									</div>
									<p><span>备注：</span><span name="detail">${foods.foodDetail}</span></p>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3 >套餐</h3>
					</div>
					<c:forEach items="${foodlist}" var="foods">
						<c:if test="${foods.foodType eq '套餐'}">
							<div class="menus d-flex ftco-animate">
									<div class="menu-img img" name="img" style="background-image: url(images/${foods.foodImage});"></div>
									<div class="text">
										<div class="d-flex">
											<div class="one-half">
												<h3 name="name">${foods.foodName}</h3>
											</div>
											<div class="one-forth">
												<span>$</span><span class="price" name="price">${foods.foodPrice}</span>
												<button class="add_btn" onclick="addToCart(${foods.foodId})">添加</button>
											</div>
										</div>
										<p><span>备注：</span><span name="detail">${foods.foodDetail}</span></p>
									</div>
							</div>
						</c:if>
					</c:forEach>
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3 >饮料</h3>
					</div>
					<c:forEach items="${foodlist}" var="foods">
						<c:if test="${foods.foodType eq '饮料'}">
							<div class="menus d-flex ftco-animate">
									<div class="menu-img img" name="img" style="background-image: url(images/${foods.foodImage});"></div>
									<div class="text">
										<div class="d-flex">
											<div class="one-half">
												<h3 name="name">${foods.foodName}</h3>
											</div>
											<div class="one-forth">
												<span>$</span><span class="price" name="price">${foods.foodPrice}</span>
												<button class="add_btn" onclick="addToCart(${foods.foodId})">添加</button>
											</div>
										</div>
										<p><span>备注：</span><span name="detail">${foods.foodDetail}</span></p>
									</div>
							</div>
						</c:if>
					</c:forEach>
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3 >水果</h3>
					</div>
					<c:forEach items="${foodlist}" var="foods">
						<c:if test="${foods.foodType eq '水果'}">
							<div class="menus d-flex ftco-animate">
									<div class="menu-img img" name="img" style="background-image: url(images/${foods.foodImage});"></div>
									<div class="text">
										<div class="d-flex">
											<div class="one-half">
												<h3  name="name">${foods.foodName}</h3>
											</div>
											<div class="one-forth">
												<span>$</span><span class="price" name="price">${foods.foodPrice}</span>
												<button class="add_btn" onclick="addToCart(${foods.foodId})">添加</button>
											</div>
										</div>
										<p><span>备注：</span><span name="detail">${foods.foodDetail}</span></p>
									</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>

		</div>

	</section>

	<!-- 购物车 -->
	<section class="ftco-section">
		<div class="row justify-content-center mb-5 pb-2">
			<div class="col-md-7 text-center heading-section ftco-animate">
				<h2 class="mb-4">购物车信息</h2>
			</div>
		</div>
		<div>
			<!-- Content-Starts-Here -->
			<div class="container1">

				<!-- Mainbar-Starts-Here -->
				<div class="main-bar">
					<div class="product">
						<h3>菜式</h3>
					</div>
					<div class="quantity">
						<h3>数量</h3>
					</div>
					<div class="price">
						<h3>价格</h3>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //Mainbar-Ends-Here -->

				<!-- Items-Starts-Here -->
				<div class="items">



				</div>
				<!-- //Items-Ends-Here -->

				<!-- Total-Price-Starts-Here -->
				<div class="total">
					<div class="total1">总价钱</div>
					<form><div class="total2" name="tatolprice">0</div></form>
					<div class="clear"></div>
				</div>
				<!-- //Total-Price-Ends-Here -->

				<!-- Checkout-Starts-Here -->
				<div class="checkout">
					<div class="add">
						<a href="#">继续加菜</a>
					</div>
					<div class="checkout-btn">
						<a href="#" onclick="addOrder()">付款</a>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //Checkout-Ends-Here -->

			</div>
			<!-- Content-Ends-Here -->
		</div>
	</section>
<div hidden="hidden" class="item11" style="position: relative; margin-bottom: 20px;">
	<div class="close11">
		<!-- Remove-Item -->
		<div class="alert-close11" style="top:15px;right: -10px; background:url('/images/close1.png') no-repeat 0px 0;cursor: pointer;height: 22px; width: 22px; position: absolute; transition: color 0.2s ease-in-out;"> </div>
		<!-- //Remove-Item -->
		<%--							<form action="">--%>
		<div class="image1">
			<img name="img" src="images/dinner-1.jpg" alt="item1">
		</div>
		<div class="title1">
			<p name="name"></p>
		</div>
		<%--							</form>--%>
		<div class="quantity1">
			<form action="">
				<input type="number" name="quantity" min="1" max="10" value="1"></intput>
			</form>
		</div>
		<div class="price1">
			<%--								<form action="">--%>
			<p><span>$</span><span name="price"></span></p>
			<%--								</form>--%>
		</div>
		<div class="clear"></div>
	</div>
</div>
	<!-- 页末 -->
	<footer class="ftco-footer ftco-bg-dark ftco-section">
		<div class="container">
			<div class="row mb-5">
				<div class="col-md-6 col-lg-3">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">韶大云餐厅</h2>
						<p>安心坐下来吃一碗吧！既便宜又好吃！</p>
						<p>下课铃声响起，缘来是你！</p>
						<p>温暖你的是服务，感动你的是美食！</p>
						<p>如在家一般，却享受到不一样的好味道！</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">营业时间</h2>
						<ul class="list-unstyled open-hours">
							<li class="d-flex"><span>Monday</span><span>9:00 - 24:00</span></li>
							<li class="d-flex"><span>Tuesday</span><span>9:00 - 24:00</span></li>
							<li class="d-flex"><span>Wednesday</span><span>9:00 - 24:00</span></li>
							<li class="d-flex"><span>Thursday</span><span>9:00 - 24:00</span></li>
							<li class="d-flex"><span>Friday</span><span>9:00 - 02:00</span></li>
							<li class="d-flex"><span>Saturday</span><span>9:00 - 02:00</span></li>
							<li class="d-flex"><span>Sunday</span><span> Closed</span></li>
						</ul>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">留言板</h2>
						<p>你的所思所想所偿所获，都可以在此呈现：</p>
						<form action="#" class="subscribe-form">
							<div class="form-group">
								<input type="text" class="form-control mb-2 text-center" placeholder="写下你的留言">
								<input type="submit" value="确定" class="form-control submit px-3">
							</div>
						</form>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">图册集</h2>
						<div class="thumb d-sm-flex">
							<a href="#" class="thumb-menu img" style="background-image: url(images/insta-1.jpg);">
							</a>
							<a href="#" class="thumb-menu img" style="background-image: url(images/insta-2.jpg);">
							</a>
							<a href="#" class="thumb-menu img" style="background-image: url(images/insta-3.jpg);">
							</a>
						</div>
						<div class="thumb d-flex">
							<a href="#" class="thumb-menu img" style="background-image: url(images/insta-5.jpg);">
							</a>
							<a href="#" class="thumb-menu img" style="background-image: url(images/insta-5.jpg);">
							</a>
							<a href="#" class="thumb-menu img" style="background-image: url(images/insta-6.jpg);">
							</a>
						</div>
					</div>
				</div>
			</div>

		</div>
	</footer>


	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-migrate-3.0.1.min.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/jquery.stellar.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/aos.js"></script>
	<script src="js/jquery.animateNumber.min.js"></script>
	<script src="js/scrollax.min.js"></script>
	<script src="js/main.js"></script>

	<!-- Remove-Item-JavaScript -->
	<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
	<script type="text/javascript" src="js/jquery-shoppingCart.min.js"></script>
<%--	<script id="js">--%>

<%--	</script>--%>
<%--	<script>$(document).ready(function (c) {--%>
<%--			$('.alert-close1').on('click', function (c) {--%>
<%--				$('.close1').fadeOut('slow', function (c) {--%>
<%--					$('.close1').remove();--%>
<%--				});--%>
<%--			});--%>
<%--		});--%>
<%--	</script>--%>
<%--	<script>$(document).ready(function (c) {--%>
<%--			$('.alert-close2').on('click', function (c) {--%>
<%--				$('.close2').fadeOut('slow', function (c) {--%>
<%--					$('.close2').remove();--%>
<%--				});--%>
<%--			});--%>
<%--		});--%>
<%--	</script>--%>
<%--	<script>$(document).ready(function (c) {--%>
<%--			$('.alert-close').on('click', function (c) {--%>
<%--				$('.close11').fadeOut('slow', function (c) {--%>
<%--					$('.close11').remove();--%>
<%--				});--%>
<%--			});--%>
<%--		});--%>
<%--	</script>--%>


	<!-- //Remove-Item-JavaScript -->



</body>

</html>