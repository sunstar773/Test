<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/9/10
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户修改密码</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">用户密码修改</div>
        <div class="panel-body">
            <%-- 表单--%>
            <form class="form-horizontal" id="userForm">
                <div class="form-group">
                    <label  class="col-sm-1 control-label">原密码</label>
                    <div class="col-sm-3">
                        <input type="email" class="form-control"   id="oldPassword"  placeholder="请输入原密码">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-1 control-label">新密码</label>
                    <div class="col-sm-3">
                        <input type="email" class="form-control"  id="newPassword" placeholder="请输入新密码">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-1 control-label">确认密码</label>
                    <div class="col-sm-3">
                        <input type="email" class="form-control"   id="a_newPassword" placeholder="请确认密码">
                    </div>
                </div>
                <div style="text-align: center">
                    <button type="button" class="btn btn-info" onclick="updatePassword()"><i class="glyphicon glyphicon-ok"></i>修改</button>
                    <button type="reset" class="btn btn-default" ><i class="glyphicon glyphicon-repeat"></i>重置</button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    function updatePassword() {
          var userId="${u.id}"
       var oldPassword=  $("#oldPassword").val();
       var newPassword=  $("#newPassword").val();
        var confirmPassword= $("#a_newPassword").val();
        if ( newPassword!=confirmPassword) {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>新密码与确认密码不一致！",
                size: 'small'
            });
            return;
        }
        $.post({
            url:"/updatePassword",
            data:{
                id:userId,
                oldPassword:oldPassword,
                newPassword:newPassword,
                confirmPassword:confirmPassword
            },
            success:function (result) {
                if (result.code==200){
                    bootbox.alert({
                        message: "<span class='glyphicon glyphicon-info-sign'>修改成功",
                        size: 'small'
                    });
                }
            }
        })
    }
</script>
</body>
</html>
