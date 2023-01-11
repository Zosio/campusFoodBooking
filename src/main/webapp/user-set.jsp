<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/index.css" />
    <script src="js/jquery-manager.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/userSetting.js"></script>
    <script src="js/bootstrap-paginator.js"></script>
    <script src="js/layer.js"></script>
    <link rel="stylesheet" href="css/zshop.css">

    <script>
        var modifyStatus;
        var showUser
        window.onload=function () {
            modifyStatus = function (id, btn) {
                $.post(
                    'userManager.do',
                    ///?type=modifyStatus
                    {'id': id, 'type': "modifyStatus"},
                    function (result) {
                        if (result.status == 1) {
                            let $td = $(btn).parent().parent().children().eq(5);
                            if ($td.text().trim() == '有效') {
                                $td.text('无效');
                                $(btn).val('启用').removeClass('btn-danger').addClass('btn-success');
                            } else {
                                $td.text('有效');
                                $(btn).val('禁用').removeClass('btn-success').addClass('btn-danger');
                            }
                        }
                    }
                );

            }
            showUser = function (id) {
                $.post('userManager.do',
                    {'type': 'getUserById', 'id': id},
                    function (result) {
                        $('#UserId').attr('placeholder', result.data.userId);
                        $('#MargerStaffname').attr('placeholder',result.data.userName);
                        $('#UserPassword').attr('placeholder',result.data.userPwd);
                        $('#UserEmail').attr('placeholder',result.data.userAccount);
                        $('#UserPhone').attr('placeholder',result.data.userPhone);
                        $('#UserId').val(result.data.userId);

                    });

            }
        }

    </script>

</head>

<body>
    <!-- 普通用户管理 -->
    <div class="panel panel-default" id="adminSet">
        <div class="panel-heading">
            <h3 class="panel-title">食堂普通用户管理</h3>
        </div>
        <div class="panel-body">

            <!-- 查询栏 -->
            <div class="showmargersearch">
<%--                <form class="form-inline" action="${pageContext.request.contextPath}/backend/sysuser/list" method="post"--%>
<%--                    id="frmSearch">--%>
                <form class="form-inline" action="userManager.do" method="post"
                          id="frmSearch">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}" id="pageNum">
                    <div class="form-group">
                        <label for="userName">姓名:</label>
                        <input type="text" class="form-control" id="userName" placeholder="请输入姓名" name="name"
                            value="">
                    </div>
                    <div class="form-group">
                        <label for="loginName">帐号:</label>
                        <input type="text" class="form-control" id="loginName" placeholder="请输入帐号" name="account"
                            value="">
                    </div>
                    <div class="form-group">
                        <label for="phone">电话:</label>
                        <input type="text" class="form-control" id="phone" placeholder="请输入电话" name="phone"
                            value="">
                    </div>
                    <div class="form-group">
                        <label for="role">角色</label>
                        <select class="form-control" name="role" id="role">
                            <option value="-1">全部</option>
                            <option value="1"><c:if test="${sysuserParam.isValid==1}">selected</c:if>---客户---</option>
                            <option value="2"><c:if test="${sysuserParam.isValid==0}">selected</c:if>---管理员---</option>
                            <option value="3"><c:if test="${sysuserParam.isValid==0}">selected</c:if>---配送员---</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="status">状态</label>
                        <select class="form-control" name="isValid" id="status">
                            <option value="-1">全部</option>
                            <option value="1"><c:if test="${sysuserParam.isValid==1}">selected</c:if>---有效---</option>
                            <option value="0"><c:if test="${sysuserParam.isValid==0}">selected</c:if>---无效---</option>
                        </select>
                    </div>
                    <input type="hidden" name="type" value="query">
                    <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
                </form>
            </div>
            <br>

            <input type="button" value="添加普通用户" class="btn btn-primary" id="doAddManger">
            
            <!-- 显示栏 -->
            <div class="show-list text-center" style="position: relative; top: 10px;">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">序号</th>
                            <th class="text-center">姓名</th>
                            <th class="text-center">帐号</th>
                            <th class="text-center">电话</th>
                            <th class="text-center">角色</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
<%--                   --%>
                        <c:if test=""></c:if>
                        <c:set var="index" value="0"></c:set>
                        <c:forEach items="${users}" var="sysuser">
                            <c:set var="index" value="${index+1}"></c:set>
<%--                            <c:if test="${sysuser.role==0}">--%>
                            <tr>
                                <td>${index}</td>
                                <td>${sysuser.userName}</td>
                                <td>${sysuser.userAccount}</td>
                                <td>${sysuser.userPhone}</td>
                                <td>
                                    <c:if test="${sysuser.userType==1}">客户</c:if>
                                    <c:if test="${sysuser.userType==2}">管理员</c:if>
                                    <c:if test="${sysuser.userType==3}">配送员</c:if>
<%--                                        ${sysuser.userAccount}--%>
                                </td>
                                <td>
                                    <c:if test="${sysuser.userStatus==1}">有效</c:if>
                                    <c:if test="${sysuser.userStatus==0}">无效</c:if>
                                </td>
                                <td class="text-center">
                                    <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改"
                                           onclick="showUser(${sysuser.userId});">
                                    <c:if test="${sysuser.userStatus==1}">
                                        <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用"
                                               onclick="modifyStatus(${sysuser.userId},this);">
                                    </c:if>
                                    <c:if test="${sysuser.userStatus==0}">
                                        <input type="button" class="btn btn-success btn-sm doMangerDisable" value="启用"
                                               onclick="modifyStatus(${sysuser.userId},this);">
                                    </c:if>
                                </td>
                            </tr>
<%--                            </c:if>--%>
                        </c:forEach>
                    </tbody>
                </table>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>

    <!-- 添加普通用户 start -->
    <div class="modal fade" tabindex="-1" id="myMangerUser">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <form action="userManager.do" id="frmAddSysuser" method="post">
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">添加普通用户</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="marger-username" class="col-sm-4 control-label">用户姓名：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-username" name="name">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-account" class="col-sm-4 control-label">登录帐号：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-account" name="account">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-password" class="col-sm-4 control-label">登录密码：</label>
                            <div class="col-sm-4">
                                <input type="password" class="form-control" id="marger-password" name="password">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-phone" class="col-sm-4 control-label">联系电话：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-phone" name="phone">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-email" class="col-sm-4 control-label">角色(1:客户,2:管理,3:配送员)：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-email" name="email">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="type" value="addManagerUser">
                        <button class="btn btn-primary add-Manger" type="submit">添加</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 添加普通用户 end -->

    <!-- 修改菜式 start -->
    <div class="modal fade" tabindex="-1" id="myModal-Manger">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <form action="userManager.do" id="modify" method="post">
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">用户修改</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="UserId" class="col-sm-4 control-label">用户编号：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="UserId" name="id" readonly="readonly" value="" placeholder="1">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="MargerStaffname" class="col-sm-4 control-label">用户姓名：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="MargerStaffname" name="name">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="UserPassword" class="col-sm-4 control-label">账号密码：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="UserPassword" value="" name="password">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="UserEmail" class="col-sm-4 control-label">账号邮箱：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="UserEmail" value="" name="email">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="UserPhone" class="col-sm-4 control-label">电话：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="UserPhone" name="phone">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="UserRole" class="col-sm-4 control-label">角色(1:客户,2:管理,3:配送员)：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="UserRole" name="role">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="type" value="modify">
                        <button class="btn btn-primary doMargerModal" type="submit">修改</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 修改菜式 end -->



</body>

</html>