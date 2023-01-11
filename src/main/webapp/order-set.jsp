<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        var modifyStatus;
        var showOrder;
        window.onload=function () {
            modifyStatus = function (id, btn) {
                $.post(
                    'order.do',
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
            showOrder = function (id) {
                $.post('order.do',
                    {'type': 'getOrderById', 'id': id},
                    function (result) {
                        $('#OrderNumber').val(result.data.orderNumber);
                        $('#OrderBelongsUser').val(result.data.userAccount);
                        $('#OrderDetail').val(result.data.orderDetail);
                        $('#OrderPrice').val(result.data.orderPrice);

                    });

            }
        }

    </script>
</head>

<body>
    <!-- 订单管理 -->
    <div class="panel panel-default" id="adminSet">
        <div class="panel-heading">
            <h3 class="panel-title">食堂订单管理</h3>
        </div>
        <div class="panel-body">

            <!-- 查询栏 -->
            <div class="showmargersearch">
                <form class="form-inline" action="order.do" method="post"
                    id="frmSearch">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}" id="pageNum">
                    <div class="form-group">
                        <label for="userName">订单号:</label>
                        <input type="text" class="form-control" id="userName" placeholder="请输入订单号" name="number"
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
            
            <!-- 显示栏 -->
            <div class="show-list text-center" style="position: relative; top: 10px;">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">序号</th>
                            <th class="text-center">订单号</th>
                            <th class="text-center">帐号</th>
                            <th class="text-center">电话</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <c:if test=""></c:if>
                        <c:set var="index" value="0"></c:set>
                        <c:forEach items="${order}" var="ordering">
                            <c:set var="index" value="${index+1}"></c:set>
                            <tr>
                                <td>${index}</td>
                                <td>${ordering.orderNumber}</td>
                                <td>${ordering.userAccount}</td>
                                <td>${ordering.userPhone}</td>
                                <td>
                                    <c:if test="${ordering.orderStatus==1}">有效</c:if>
                                    <c:if test="${ordering.orderStatus==0}">无效</c:if>
                                </td>
                                <!-- 数据操作 -->
                                <td class="text-center">
                                    <input type="button" class="btn btn-warning btn-sm doMangerModify" value="查看"
                                           onclick="showOrder(${ordering.orderId})";>

                                    <c:if test="${ordering.orderStatus==1}">
                                        <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用"
                                               onclick="modifyStatus(${ordering.orderId},this);">
                                    </c:if>
                                    <c:if test="${ordering.orderStatus==0}">
                                        <input type="button" class="btn btn-success btn-sm doMangerDisable" value="启用"
                                               onclick="modifyStatus(${ordering.orderId},this);">
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <ul id="pagination"></ul>
            </div>
        </div>
    </div>

    <!-- 查看订单 start -->
    <div class="modal fade" tabindex="-1" id="myModal-Manger">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <form action="order.do" id="watch" method="post">
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">订单详情</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="OrderNumber" class="col-sm-4 control-label">订单号：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="OrderNumber" name="number" readonly="readonly" value="" placeholder="1">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="OrderDetail" class="col-sm-4 control-label">详情：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="OrderDetail" name="detail" readonly="readonly">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="OrderBelongsUser" class="col-sm-4 control-label">订单所属用户：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="OrderBelongsUser" value="" readonly="readonly" placeholder="1">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="OrderPrice" class="col-sm-4 control-label">价格：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="OrderPrice" name="price" value="" readonly="readonly">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="type" value="watch">
<%--                        <button class="btn btn-primary doMargerModal" type="submit">修改</button>--%>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 修改菜式 end -->


</body>

</html>