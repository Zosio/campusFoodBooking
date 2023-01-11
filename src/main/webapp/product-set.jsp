<%@ page import="com.booking.domain.Food" %>
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
    <script src="Js/jquery-3.3.1.min.js"></script>
    <script>
        //图片预览
        function getFullPath(obj){
            if (obj){
                //ie
                if (window.navigator.userAgent.indexOf("MSIE") >= 1){
                    obj.select();
                    return document.selection.createRange().text;
                }else if (window.navigator.userAgent.indexOf("Firefox") >= 1){
                    //firefox　
                    return window.URL.createObjectURL(obj.files.item(0));
                }else if(navigator.userAgent.indexOf("Chrome")>0){
                    //chrome
                    return window.URL.createObjectURL(obj.files.item(0));
                }
                return obj.value;
            }
        }

        $(function(){
            $("#filePic").change(function(){
                var path = getFullPath($(this)[0]);
                console.log(path);
                $("#imgPic").prop("src",path);
            });
        });
    </script>

    <link rel="stylesheet" href="css/zshop.css">

    <script>
        var modifyStatus;
        var showfood
        window.onload=function () {
            modifyStatus = function (id, btn) {
                $.post(
                    'food.do',
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
            showfood = function (id) {
                $.post('food.do',
                    {'type': 'getFoodById', 'id': id},
                    function (result) {
                        $('#MargerStaffId').attr('placeholder', result.data.foodId);
                        // $('#MargerStaffId').attr('value', result.data.foodId);
                        // console.log("111111111");
                        $('#MargerLoginName').attr('placeholder', result.data.foodImage);
                        // $('#MargerStaffId').val(result.data.foodId);
                        // $('#MargerLoginName').val(result.data.foodImage);

                    });

            }
        }

    </script>
</head>

<body>
    <!-- 菜式管理 -->
    <div class="panel panel-default" id="adminSet">
        <div class="panel-heading">
            <h3 class="panel-title">食堂菜式管理</h3>
        </div>
        <div class="panel-body">

            <!-- 查询栏 -->
            <div class="showmargersearch">
                <form class="form-inline" action="food.do" method="post" type="query"
                    id="frmSearch">
<%--                    <input type="hidden" name="type" value="query">--%>
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}" id="pageNum">
                    <div class="form-group">
                        <label for="userName">菜式名字:</label>
                        <input type="text" class="form-control" id="userName" placeholder="请输入菜式姓名" name="name"
                            value="">
                    </div>

                    <div class="form-group">
                        <label for="phone">价格:</label>
                        <input type="text" class="form-control" id="phone" placeholder="请输入价格" name="price"
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
            <br>

            <input type="button" value="添加菜式" class="btn btn-primary" id="doAddManger">
            
            <!-- 显示栏 -->
            <div class="show-list text-center" style="position: relative; top: 10px;">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">序号</th>
                            <th class="text-center">菜式名字</th>
                            <th class="text-center">图片</th>
                            <th class="text-center">价格/元</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <c:if test=""></c:if>
                        <c:set var="index" value="0"></c:set>
                        <c:forEach items="${foodlist}" var="f">
                            <c:set var="index" value="${index+1}"></c:set>

                            <tr>
                                <td>${index}</td>
                                <td>${f.foodName}</td>
                                <td><img src="images/${f.foodImage}" width="50" height="50" alt="error"></td>
                                <td>${f.foodPrice}</td>
                                <td>
                                    <c:if test="${f.foodStatus==1}">有效</c:if>
                                    <c:if test="${f.foodStatus==0}">无效</c:if>
                                </td>
                                <!-- 数据操作 -->
                                <td class="text-center">
                                    <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改"
                                        onclick="showUser(${f.foodId});">
                                    <c:if test="${f.foodStatus==1}">
                                        <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用"
                                            onclick="modifyStatus(${f.foodId},this);">
                                    </c:if>
                                    <c:if test="${f.foodStatus==0}">
                                        <input type="button" class="btn btn-success btn-sm doMangerDisable" value="启用"
                                            onclick="modifyStatus(${f.foodId},this);">
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

    <!-- 添加菜式 start -->
    <div class="modal fade" tabindex="-1" id="myMangerUser">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <form action="food.do"  id="frmAddSysuser" method="post" type="addfood">
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">添加菜式</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="marger-username" class="col-sm-4 control-label">菜式名字：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-username" name="name">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-loginName" class="col-sm-4 control-label">图片：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-loginName" name="image">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="marger-phone" class="col-sm-4 control-label">价格：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="marger-phone" name="price">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="type" value="addfood">
                        <button class="btn btn-primary add-Manger" type="submit">添加</button>
<%--                        <button class="btn btn-primary add-Manger" onclick="addSysuser()" type="submit" type="button">添加</button>--%>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 添加菜式 end -->

    <!-- 修改菜式 start -->
    <div class="modal fade" tabindex="-1" id="myModal-Manger">
        <!-- 窗口声明 -->
        <div class="modal-dialog">
            <!-- 内容声明 -->
            <form action="food.do" id="modify" method="post">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">菜式修改</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="MargerStaffId" class="col-sm-4 control-label">菜式编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerStaffId" name="foodId" readonly="readonly" value="" placeholder="1">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerStaffname" class="col-sm-4 control-label">菜式名字：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerStaffname" name="name">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerLoginName" class="col-sm-4 control-label">食堂：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerLoginName" value="" readonly="readonly" placeholder="1">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="MargerPhone" class="col-sm-4 control-label">价格：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="MargerPhone" name="price">
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