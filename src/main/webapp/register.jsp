<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>注册韶大云餐厅</title>
	<!-- Meta tag Keywords -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="UTF-8" />
	<meta name="keywords" content="Merged Forms Page Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
	<!-- //Meta tag Keywords -->
	<link rel="stylesheet" href="css/style-register.css" type="text/css" media="all" /><!-- Style-CSS -->
</head>

<body>
	<!-- /form-26-section -->
	<section class="form-26-1">
		<div class="form-26-mian">
			<div class="layer">
				<div class="wrapper">
					<div class="form-inner-cont">
						<div class="forms-info">
							<h2>注册新账户</h2>
							<p>Etiam sit amet iaculis nunc, et feugiat enim. Aenean lorem dui, mattis et neque ac,
								viverra dignissim elit. Nunc quis finibus lorem.</p>
						</div>
						<div class="form-right-inf">
							<form action="register.do" method="post" class="signin-form">
								<div class="forms-gds">
									<div class="form-input">
										<input type="text" name="firstname" placeholder="Firstname" required />
									</div>
									<div class="form-input">
										<input type="text" name="lastname" placeholder="Lastname" required />
									</div>
									<div class="form-input">
										<input type="email" name="email" placeholder="Email" required />
									</div>
									<div class="form-input">
										<input type="password" name="password1" placeholder="Password" required />
									</div>
									<div class="form-input">
										<input type="password" name="password2" placeholder="Confirm Password"
											required />
									</div>
									<div class="form-input"><button class="btn">注册</button></div>
								</div>
								<h6 class="already"> 已有账户了吗？ <a href="login.html"><span>点这里登录<span></span></span></a></h6>
							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- //form-26-section -->
</body>

</html>