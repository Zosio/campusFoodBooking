<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
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

        //添加配送员
        function addSysuser() {
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/add',
                $('#frmAddSysuser').serialize(),
                function (result) {
                    if (result.status == 1) {
                        layer.msg('添加成功', {
                            time: 2000,
                            skin: 'successMsg'
                        }, function () {
                            location.href = '${pageContext.request.contextPath}/backend/sysuser/list';
                        })
                    }

                }
            );
        }

        //修改配送员的状态
        function modifyStatus(id, btn) {
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/modifyStatus',
                { 'id': id },
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

        //修改配送员信息
        function showSysUser(id) {
            $.post(
                '${pageContext.request.contextPath}/backend/sysuser/findUserById',
                { 'id': id },
                function (result) {
                    if (result.status == 1) {

                        $('#MargerStaffId').val(result.data.id);
                        $('#MargerStaffname').val(result.data.name);
                        $('#MargerLoginName').val(result.data.loginName);
                        $('#MargerPhone').val(result.data.phone);
                        $('#MargerAdrees').val(result.data.email);
                        $('#MargerRole').val(result.data.role.id);

                    }
                }
            );
        }

        // 
        function modifySave() {
            $.ajax({
                type: 'post',
                url: '${pageContext.request.contextPath}/backend/sysuser/modifySave',
                data: { 'id': $('#MargerStaffId').val(), 'name': $('#MargerStaffname').val(), 'loginName': $('#MargerLoginName').val(), 'phone': $('#MargerPhone').val(), 'email': $('#MargerAdrees').val(), 'role': $('#MargerRole').val() },
                dataType: 'json',
                success: function (result) {
                    if (result.status == 1) {
                        layer.msg(result.message, {
                            time: 2000,
                            skin: 'successMsg'
                        }, function () {
                            //重新加载数据
                            location.href = '${pageContext.request.contextPath}/backend/sysuser/list';
                        })
                    } else {
                        layer.msg(result.message, {
                            time: 2000,
                            skin: 'errorsMsg'
                        })
                    }
                }
            });
        }

        // $(function () {
        //     //分页
        //     $('#pagination').bootstrapPaginator({
        //         bootstrapMajorVersion: 3,
        //         currentPage: ${ pageModel.pageIndex },
        //         totalPages: ${ pageModel.totalPageSum },
        //         itemTexts: function (type, page, current) {
        //             switch (type) {
        //                 case "first":
        //                     return "首页";
        //                 case "prev":
        //                     return "上一页";
        //                 case "next":
        //                     return "下一页";
        //                 case "last":
        //                     return "末页";
        //                 case "page":
        //                     return page;
        //             }
        //         },
        //         pageUrl: function (type, page, current) {
        //             return '${pageContext.request.contextPath}/backend/sysuser/list?pageIndex=' + page;
        //         }
        //    })
	    // });

    </script>
</head>

<body>
    <!-- 配送员管理 -->
    <div class="panel panel-default" id="adminSet">
        <div class="panel-heading">
            <h3 class="panel-title">配送员管理</h3>
        </div>
        <div class="panel-body">

            <!-- 查询栏 -->
            <div class="showmargersearch">
                <form class="form-inline" action="${pageContext.request.contextPath}/backend/sysuser/list" method="post"
                    id="frmSearch">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}" id="pageNum">
                    <div class="form-group">
                        <label for="userName">姓名:</label>
                        <input type="text" class="form-control" id="userName" placeholder="请输入姓名" name="name"
                            value="${sysuserParam.name}">
                    </div>
                    <div class="form-group">
                        <label for="loginName">帐号:</label>
                        <input type="text" class="form-control" id="loginName" placeholder="请输入帐号" name="loginName"
                            value="${sysuserParam.loginName}">
                    </div>
                    <div class="form-group">
                        <label for="phone">电话:</label>
                        <input type="text" class="form-control" id="phone" placeholder="请输入电话" name="phone"
                            value="${sysuserParam.phone}">
                    </div>
                    <div class="form-group">
                        <label for="status">状态</label>
                        <select class="form-control" name="isValid" id="status">
                            <option value="-1">全部</option>
                            <option value="1"><c:if test="${sysuserParam.isValid==1}">selected</c:if>---有效---</option>
                            <option value="0"><c:if test="${sysuserParam.isValid==0}">selected</c:if>---无效---</option>
                        </select>
                    </div>
                    <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
                </form>
            </div>
            <br>

            <input type="button" value="添加配送员" class="btn btn-primary" id="doAddManger">
            
            <!-- 显示栏 -->
            <div class="show-list text-center" style="position: relative; top: 10px;">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">序号</th>
                            <th class="text-center">姓名</th>
                            <th class="text-center">帐号</th>
                            <th class="text-center">电话</th>
                            <th class="text-center">邮箱</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">角色</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <c:forEach items="${sysUsers}" var="sysuser">
                            <tr>
                                <td>${sysuser.id}</td>
                                <td>${sysuser.name}</td>
                                <td>${sysuser.loginName}</td>
                                <td>${sysuser.phone}</td>
                                <td>${sysuser.email}</td>
                                <td>
                                    <c:if test="${sysuser.isValid==1}">有效</c:if>
                                    <c:if test="${sysuser.isValid==0}">无效</c:if>
                                </td>
                                <td>配送员</td>
                                <!-- 数据操作 -->
                                <td class="text-center">
                                    <c:if test="${sysuser.isValid==1}">
                                        <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用"
                                            onclick="modifyStatus(${sysuser.id},this)">
                                    </c:if>
                                    <c:if test="${sysuser.isValid==0}">
                                        <input type="button" class="btn btn-success btn-sm doMangerDisable" value="启用"
                                            onclick="modifyStatus(${sysuser.id},this)">
                                    </c:if>
                                    <input type="button" class="btn btn-warning btn-sm doMangerDel" value="删除"
                                        onclick="">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>

    <!-- 添加配送员 start -->
    <div class="modal fade" tabindex="-1" id="myMangerUser">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <form id="frmAddSysuser" method="post">
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">添加配送员</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="marger-username" class="col-sm-4 control-label">姓名：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-username" name="name">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-loginName" class="col-sm-4 control-label">登录帐号：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-loginName" name="loginName">
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
                            <label for="marger-adrees" class="col-sm-4 control-label">联系邮箱：</label>
                            <div class="col-sm-4">
                                <input type="email" class="form-control" id="marger-email" name="email">
                            </div>
                        </div>
                        <br>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary add-Manger" onclick="addSysuser()" type="button">添加</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 添加配送员 end -->

    <!-- 修改配送员 start -->
    <div class="modal fade" tabindex="-1" id="myModal-Manger">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">配送员修改</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="MargerUsername" class="col-sm-4 control-label">用户编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerStaffId" readonly="readonly">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerUsername" class="col-sm-4 control-label">用户姓名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerStaffname">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerLoginName" class="col-sm-4 control-label">登录帐号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerLoginName" readonly="readonly">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerPhone" class="col-sm-4 control-label">联系电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerPhone">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerAdrees" class="col-sm-4 control-label">联系邮箱：</label>
                        <div class="col-sm-4">
                            <input type="email" class="form-control" id="MargerAdrees">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerRole"
                            class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                        <div class=" col-sm-4">
                            <select class="form-control" id="MargerRole">
                                <option>--请选择--</option>
                                <c:forEach items="${roles}" var="role">
                                    <option value="${role.id}">食堂管理员</option>
                                    <option value="${role.id}">普通用户</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary doMargerModal">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改配送员 end -->

</body>

</html>