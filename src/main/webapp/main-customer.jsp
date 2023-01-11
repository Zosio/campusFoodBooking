<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.dao.BaseDao"%>
<%@ page import="com.booking.domain.User"%>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<html lang="en">

<head>
	<title>韶大云餐厅</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="css/animate.css">
	<!-- 显示第一部分 -->
	<link rel="stylesheet" href="css/owl.carousel.min.css">
	<link rel="stylesheet" href="css/ionicons.min.css">
	<link rel="stylesheet" href="css/style-customer.css">
<%--	<%! int count=0; %>--%>
<%--	<%--%>
<%--		try{--%>
<%--			Class.forName("com.mysql.cj.jdbc.Driver");--%>
<%--			String url="jdbc:mysql://localhost:3306/booking?userSSL=true&useUnicode=true&characterEncoding=utf-8";--%>
<%--			String username="root";--%>
<%--			String password="12345678";--%>
<%--			Connection connection= DriverManager.getConnection(url,username,password);--%>

<%--			if(connection!=null){--%>
<%--				PreparedStatement pstm = null;--%>
<%--				ResultSet rs = null;--%>
<%--				String sql="select count(*) from user";--%>

<%--				pstm=connection.prepareStatement(sql);--%>
<%--				rs= pstm.executeQuery();--%>
<%--				if(rs.next()){--%>
<%--					count =rs.getInt(1);--%>
<%--				}--%>

<%--			}else out.print("连接失败");--%>

<%--		}catch (Exception e){--%>
<%--			out.print("数据库连接异常");--%>
<%--		}--%>

<%--	%>--%>

</head>

<body>

	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="#">韶大云餐厅</a>			
			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<!-- 导航栏 -->
					<li class="nav-item active"><a href="main-customer.jsp" class="nav-link">首页</a></li>
					<li class="nav-item"><a href="order.jsp" class="nav-link">订单</a></li>
					<li class="nav-item"><a href="pCenter.jsp" class="nav-link">个人中心</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- END nav -->

	<!-- 第一部分 -->
	<section class="home-slider js-fullheight owl-carousel bg-white">
		<div class="slider-item js-fullheight">
			<div class="overlay"></div>
			<div class="container-fluid p-0">
				<div class="row d-md-flex no-gutters slider-text js-fullheight align-items-center justify-content-end"
					data-scrollax-parent="true">
					<div class="one-third order-md-last img js-fullheight"
						style="background-image:url(images/bg_3.jpg);">
						<div class="overlay"></div>
					</div>
					<div class="one-forth d-flex js-fullheight align-items-center ftco-animate"
						data-scrollax=" properties: { translateY: '70%' }">
						<div class="text mt-md-5">
							<!-- 内容 -->
							<h1 class="mb-4">享受健康 <br> 自然的食物！</h1>
							<p>温暖你的是服务，感动你的是美食！</p>
							<p>如在家一般，却享受到不一样的好味道！</p>
							<div class="thumb mt-4 mb-3 d-flex">
								<a href="#" class="thumb-menu pr-md-4 text-center">
									<div class="img" style="background-image: url(images/menu-1.jpg);"></div>
									<h4>自助式火锅</h4>
								</a>
								<a href="#" class="thumb-menu pr-md-4 text-center">
									<div class="img" style="background-image: url(images/menu-2.jpg);"></div>
									<h4>麻辣烫</h4>
								</a>
								<a href="#" class="thumb-menu pr-md-4 text-center">
									<div class="img" style="background-image: url(images/menu-3.jpg);"></div>
									<h4>排骨煲</h4>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="slider-item js-fullheight">
			<div class="overlay"></div>
			<div class="container-fluid p-0">
				<div class="row d-flex no-gutters slider-text js-fullheight align-items-center justify-content-end"
					data-scrollax-parent="true">
					<div class="one-third order-md-last img js-fullheight"
						style="background-image:url(images/bg_2.jpg);">
						<div class="overlay"></div>
					</div>
					<div class="one-forth d-flex js-fullheight align-items-center ftco-animate"
						data-scrollax=" properties: { translateY: '70%' }">
						<div class="text mt-md-5">
							<h1 class="mb-4">我们都喜爱 <br> 可口实惠的饭菜！</h1>
							<p>下课铃声响起，缘来是你！</p>
							<p>安心坐下来吃一碗吧！既便宜又好吃！</p>
							<div class="thumb mt-4 mb-3 d-flex">
								<a href="#" class="thumb-menu pr-md-4 text-center">
									<div class="img" style="background-image: url(images/menu-1.jpg);"></div>
									<h4>石锅拌饭</h4>
								</a>
								<a href="#" class="thumb-menu pr-md-4 text-center">
									<div class="img" style="background-image: url(images/menu-2.jpg);"></div>
									<h4>盖浇饭</h4>
								</a>
								<a href="#" class="thumb-menu pr-md-4 text-center">
									<div class="img" style="background-image: url(images/menu-3.jpg);"></div>
									<h4>四川风味回锅肉</h4>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 第二部分 -->
	<section class="ftco-section ftco-counter img" id="section-counter" style="background-image: url(images/bg_4.jpg);"
		data-stellar-background-ratio="0.5">
		<div class="container">
			<div class="row d-md-flex align-items-center justify-content-center">
				<div class="col-lg-10">
					<div class="row d-md-flex align-items-center">
						
						<div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
							<div class="block-18">
								<div class="text">
									<strong class="number" data-number=2000>>0</strong>
									<span>平台用户数</span>
								</div>
							</div>
						</div>
						<div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
							<div class="block-18">
								<div class="text">
									<strong class="number" data-number="3564">0</strong>
									<span>已完成订单数</span>
								</div>
							</div>
						</div>
						<div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
							<div class="block-18">
								<div class="text">
									<strong class="number" data-number="300">0</strong>
									<span>云餐厅平台运营天数</span>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 第三部分 -->
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center mb-5 pb-2">
				<div class="col-md-7 text-center heading-section ftco-animate">
					<h2 class="mb-4">高级餐厅</h2>
				</div>
			</div>
			<!-- 食堂集合 -->
			<div class="row">
				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3><a href="firstRestaurant.jsp">品园（第一食堂）</a></h3>
					</div>
					<div class="menus d-flex ftco-animate">
						<div class="menu-img img" style="background-image: url(images/breakfast-1.jpg);"></div>
						<div class="text">
							<div class="d-flex">
								<div class="one-half">
									<h3>东西南北区</h3>
								</div>
							</div>
							<p><span>联系电话</span>：<span>18866668888</span></p>
						</div>
					</div>
				
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3><a href="firstRestaurant.jsp">味园（第二食堂)</a></h3>
					</div>
					<div class="menus d-flex ftco-animate">
						<div class="menu-img img" style="background-image: url(images/lunch-1.jpg);"></div>
						<div class="text">
							<div class="d-flex">
								<div class="one-half">
									<h3>东西南北区</h3>
								</div>
							</div>
							<p><span>联系电话</span>：<span>18866668888</span></p>
						</div>
					</div>
					
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3><a href="firstRestaurant.jsp">清园（第三食堂）</a></h3>
					</div>
					<div class="menus d-flex ftco-animate">
						<div class="menu-img img" style="background-image: url(images/dinner-1.jpg);"></div>
						<div class="text">
							<div class="d-flex">
								<div class="one-half">
									<h3>东西南北区</h3>
								</div>
							</div>
							<p><span>联系电话</span>：<span>18866668888</span></p>
						</div>
					</div>
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3><a href="firstRestaurant.jsp">雅园（第四食堂）</a></h3>
					</div>
					<div class="menus d-flex ftco-animate">
						<div class="menu-img img" style="background-image: url(images/dessert-1.jpg);"></div>
						<div class="text">
							<div class="d-flex">
								<div class="one-half">
									<h3>东西南北区</h3>
								</div>
							</div>
							<p><span>联系电话</span>：<span>18866668888</span></p>
						</div>
					</div>
					
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3><a href="firstRestaurant.jsp">陶园（第五食堂）</a></h3>
					</div>
					<div class="menus d-flex ftco-animate">
						<div class="menu-img img" style="background-image: url(images/wine-1.jpg);"></div>
						<div class="text">
							<div class="d-flex">
								<div class="one-half">
									<h3>东西南北区</h3>
								</div>
							</div>
							<p><span>联系电话</span>：<span>18866668888</span></p>
						</div>
					</div>
					
				</div>

				<div class="col-md-6 col-lg-4 menu-wrap">
					<div class="heading-menu text-center ftco-animate">
						<h3><a href="firstRestaurant.jsp">小南园</a></h3>
					</div>
					<div class="menus d-flex ftco-animate">
						<div class="menu-img img" style="background-image: url(images/drink-1.jpg);"></div>
						<div class="text">
							<div class="d-flex">
								<div class="one-half">
									<h3>东西南北区</h3>
								</div>
							</div>
							<p><span>联系电话</span>：<span>18866668888</span></p>
						</div>
					</div>
				</div>

			</div>
		</div>

	</section>

	<footer>
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

</body>

</html>