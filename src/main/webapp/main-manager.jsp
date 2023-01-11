<%@ page import="com.booking.domain.User" %>
<%@ page import="com.booking.util.Constants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>后台管理系统</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/index.css" />
    <script src="js/jquery-manager.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/userSetting.js"></script>
    <script type="text/javascript">
        $(function () {
            // 点击切换页面
            $("#product-set").click(function () {
                $("#frame-id").attr("src", "product-set.jsp");

            });
            $("#order-set").click(function () {
                $("#frame-id").attr("src", "order-set.jsp");
            });
            $("#user-set").click(function () {
                $("#frame-id").attr("src", "user-set.jsp");
            });
            // $("#delivery-set").click(function () {
            //     $("#frame-id").attr("src", "delivery-set.jsp");
            // });
        });

    </script>
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
    <div class="wrapper-cc clearfix">
        <div class="content-cc">
            <!-- header start -->
            <div class="clear-bottom head">
                <div class="container head-cc">
                    <p>韶关学院云餐厅<span>后台管理系统</span></p>
                    <div class="welcome">
                        <div class="left">欢迎您：</div>
                        <div class="right"><b>${userName}</b></div>
<%--                        <td width="30%" style="padding-top:13px;font:15px Arial,SimSun,sans-serif;color:#FFF"> 当前用户:<b>${user.name}</b>&nbsp;<a style="color:white" onclick="return confirm('确认退出');" href="user.let?type=exit">安全退出</a></td>--%>
                        <div class="exit"><a onclick="return confirm('确认退出');" href="user.let?type=exit" class="nav-link">退出</a></div>
                    </div>
                </div>
            </div>
            <!-- header end -->
            <!-- content start -->
            <div class="container-flude flude-cc" id="a">
                <div class="row user-setting">
                    <div class="col-xs-2 user-wrap">
                        <ul class="list-group">
                            <li class="list-group-item " name="userSet" id="product-set">
                                菜式管理
                            </li>
                            <li class="list-group-item" name="userPic" id="order-set">
                                订单管理
                            </li>
                            <li class="list-group-item" name="userInfo" id="user-set">
                                用户管理
                            </li>
<%--                            <li class="list-group-item active" name="adminSet" id="delivery-set">--%>
<%--                                配送员管理--%>
<%--                            </li>--%>
                        </ul>
                    </div>
                    <div class="col-xs-10" id="userPanel">
                        <iframe id="frame-id" src="user-set.jsp" width="100%"
                            height="100%" frameborder="0" scrolling="no">
                        </iframe>
                    </div>

                </div>
            </div>
            <!-- content end-->
        </div>
    </div>

</body>

</html>