<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/9/11
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>找回密码</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">找回密码</div>
        <div class="panel-body">
            <%-- 表单--%>
            <form class="form-horizontal" >
                <div class="form-group">
                    <label  class="col-sm-4 control-label">注册时的邮箱</label>
                    <div class="col-sm-3">
                        <input type="email" class="form-control"   id="email"  placeholder="请输入邮箱">
                    </div>
                </div>
                <div style="text-align: center">
                    <button type="button" class="btn btn-info" onclick="sendPassword()"><i class="glyphicon glyphicon-ok"></i>发送密码到邮箱</button>
                    <button type="reset" class="btn btn-default" ><i class="glyphicon glyphicon-repeat"></i>重置</button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    function sendPassword() {
        var email=$("#email").val();
        if (email==null || email==""){
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>邮箱不能为空",
                size: 'small'
            });
        }
        else {
        $.post({
            url:"/sendPassword",
            data:{email:email},
            success:function (result) {
                if (result.code==200){
                    bootbox.alert({
                        message: "<span class='glyphicon glyphicon-info-sign'>密码已发送至邮箱，请查看！",
                        size: 'small'
                    });
                }else {
                    bootbox.alert({
                        message: "<span class='glyphicon glyphicon-info-sign'>"+result.msg,
                        size: 'small'
                    });
                }
            }
        })
        }
    }
</script>
</body>
</html>
