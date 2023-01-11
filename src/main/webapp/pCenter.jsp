<%@ page import="com.booking.domain.User" %>
<%@ page import="com.booking.util.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


	<head>
		<title>Tabbed Profile Widget Flat Responsive Widget Template :: w3layouts</title>
		<!-- for-mobile-apps -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
		<!-- //for-mobile-apps -->
		<link href="css/style-pCenter.css" rel="stylesheet" type="text/css" media="all" />
		<!-- <link rel="stylesheet" href="css/animate.css"> -->
		<link rel="stylesheet" href="css/style-customer.css">
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


		<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light ftco-navbar-light-2"
			id="ftco-navbar">
			<div class="container">
				<a class="navbar-brand" href="main-customer.jsp">韶大云餐厅</a>
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto">
						<!-- 导航栏 -->
						<li class="nav-item"><a href="main-customer.jsp" class="nav-link">首页</a></li>
						<li class="nav-item"><a href="order.jsp" class="nav-link">订单</a></li>
						<li class="nav-item active"><a href="pCenter.jsp" class="nav-link">个人中心</a></li>
					</ul>
				</div>
			</div>
		</nav>

		<div class="main">
			<div class="content">
				<div class="sap_tabs">
					<div id="horizontalTab">
						<div class="portfolio-grid">
							<!-- 左半部分 -->
							<div class="port-left">
								<ul class="resp-tabs-list">
									<img class="lady" src="images/pic1.jpg" alt="" />
									<li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>个人信息</span></li>
									<li class="resp-tab-item" aria-controls="tab_item-4" role="tab">
										<span>设置</span>
									</li>
									<div class="clear"></div>
								</ul>
							</div>
							<!-- 右半部分 -->
							<div class="port-right">
								<div class="resp-tabs-container">
									<div class="tab-1 resp-tab-content" aria-labelledby="tab_item-0">
										<div class="profile-content">
											<h3>用户昵称</h3>
											<div class="input-group">
												<span class="input-group-btn">
													<select class="btn btn-default button-one" name="ext">
														<option selected="">Ms.</option>
														<option>Mr.</option>
														<option>Mrs.</option>
													</select>
												</span>
												<input type="text" disabled="disabled" readonly="readonly" class="form-control" value="${userName}" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '${userName}';}">
											</div>
											<h3>邮箱</h3>
											<div class="email-group">
												<div class="email-icon"><span></span></div>
												<div class="email-form">
													<form>
														<input type="text" disabled="disabled" readonly="readonly" class="fb-ico" value="${userEmail}" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = ${userEmail};}">
													</form>
												</div>
												<div class="clear"></div>
											</div>
											<h3>手机号码</h3>
											<div class="phone-group">
												<div class="cell-icon"><span></span></div>
												<div class="cell-form">
													<form>
														<input type="text" disabled="disabled" readonly="readonly" value="${userPhone}" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = ${userPhone};}">
													</form>
												</div>
												<div class="clear"></div>
											</div>
										</div>
										<div class="update">
<%--											<a href="#">更新</a>--%>
										</div>
										<div class="clear"></div>
									</div>
									
									<div class="tab-1 resp-tab-content" aria-labelledby="tab_item-4">
										<form action="user.do" method="post">
										<div class="work-play">
											<h3>设置</h3>
											<h4>新昵称</h4>

<%--												<input type="text" value="" onfocus="this.value = '';"--%>
<%--													onblur="if (this.value == '') {this.value = '';}" name="firstname">--%>
												<input class="text" type="text" name="name" value=""/>
<%--											</form>--%>
											<h4>新邮件地址</h4>
<%--											<form>--%>
<%--												<input type="text" value="" onfocus="this.value = '';"--%>
<%--													onblur="if (this.value == '') {this.value = '';}" name="email">--%>
												<input class="text" type="text" name="email" value=""/>
<%--											</form>--%>
											<h4>新密码</h4>
<%--											<form>--%>
<%--												<input type="password" value="" onfocus="this.value = '';"--%>
<%--													onblur="if (this.value == '') {this.value = '';}" name="pwd1">--%>
												<input class="text" type="password" id="pwd" type="text" name="pwd1" value=""/>
<%--											</form>--%>
											<h4>再次输入密码</h4>
<%--											<form>--%>
<%--												<input type="password" value="" onfocus="this.value = '';"--%>
<%--													onblur="if (this.value == '') {this.value = '';}" name="pwd2">--%>
												<input class="text" type="password" id="pwd" type="text" name="pwd2" value=""/>

										</div>
										<div class="update">
											<input type="hidden" name="userId" value="${userId}">
											<input class="btn" type="submit" value="提交" /></td>
										</div>
										</form>
										<div class="clear"></div>
									</div>
								</div>

							</div>
							<div class="clear"></div>
						</div>

					</div>
				</div>

			</div>
		</div>


		<script type="text/javascript" src="js/jquery.min-pCenter.js"></script>
		<script src="js/easyResponsiveTabs-pCenter.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function () {
				$('#horizontalTab').easyResponsiveTabs({
					type: 'default', //Types: default, vertical, accordion           
					width: 'auto', //auto or any width like 600px
					fit: true,   // 100% fit in a container
					closed: 'accordion', // Start closed if in accordion view
					activate: function (event) { // Callback function if tab is switched
						var $tab = $(this);
						var $info = $('#tabInfo');
						var $name = $('span', $info);
						$name.text($tab.text());
						$info.show();
					}
				});

				$('#verticalTab').easyResponsiveTabs({
					type: 'vertical',
					width: 'auto',
					fit: true
				});
			});
		</script>

	</body>

	</html>

<%--<script>--%>
<%--	var str='';--%>
<%--	$('#pwd').keyup(function(){--%>
<%--		var value =$(this).val();--%>
<%--		str+=value.substr(value.length-1,1);--%>
<%--		$(this).val(value.replace(/./g,'*'))--%>
<%--		console.log(str);--%>
<%--	})--%>
<%--	$('#pwd1').keyup(function(){--%>
<%--		var value =$(this).val();--%>
<%--		str+=value.substr(value.length-1,1);--%>
<%--		$(this).val(value.replace(/./g,'*'))--%>
<%--		console.log(str);--%>
<%--	})--%>
<%--</script>--%>