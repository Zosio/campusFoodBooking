<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.booking.util.Constants" %>
<%@ page import="com.booking.domain.User" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>云餐厅</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- 显示字 -->
	<link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/style-customer.css">
	<link rel="stylesheet" href="css/style-shoppingCart-order.css" type="text/css" media="all" />
	<%
		User user= (User) session.getAttribute(Constants.USER_SESSION);
		long userid =user.getUserId();
		pageContext.setAttribute("userId",userid);
	%>
</head>

<body>

	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light ftco-navbar-light-2"
		id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="main-customer.jsp">韶大云餐厅</a>
			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<!-- 导航栏 -->
					<li class="nav-item"><a href="main-customer.jsp" class="nav-link">首页</a></li>
					<li class="nav-item active"><a href="order.jsp" class="nav-link">订单</a></li>
					<li class="nav-item"><a href="pCenter.jsp" class="nav-link">个人中心</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- END nav -->

	<!-- 订单 -->
	<section class="ftco-section">
		<div class="row justify-content-center mb-5 pb-2">
			<div class="col-md-7 text-center heading-section ftco-animate">
				<h2 class="mb-4">订单信息</h2>
			</div>
		</div>
		<div>
			<!-- Content-Starts-Here -->
			<div class="container">
				<!-- Items-Starts-Here -->
				<div class="items">
<%--					<c:set var="user" value="${sessionScope.get(USER_SESSION)}"></c:set>--%>
					<c:forEach items="${order}" var="orders">
						<c:if test="${orders.orderStatus==1}">
							<c:if test="${orders.orderBelongUser==userId}">
								<div class="item1">
									<div class="close1">
										<div class="image1">
											<img src="images/dessert-1.jpg" alt="item1">
										</div>
										<div class="title1">
											<p class="orderID">订单号:<span>${orders.orderNumber}</span></p>
											<p class="orderDetail"><span>${orders.orderDetail}</span></p>
										</div>
										<div class="price">
											<p>$<span>${orders.orderPrice}</span></p>
										</div>
										<div class="clear"></div>
									</div>
								</div>
							</c:if>
						</c:if>
					</c:forEach>

				</div>
				<!-- //Items-Ends-Here -->
			</div>
			<!-- Content-Ends-Here -->

		</div>
	</section>


</body>

</html>