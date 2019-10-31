<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/8/28
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登陆</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body style="background-color: #ebcccc">


<style>
    .container {
        width: 420px;
        height: 320px;
        min-height: 320px;
        max-height: 320px;
        position: absolute;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
        margin: auto;
        padding: 20px;
        z-index: 130;
        border-radius: 8px;
        background-color: #7df4bf;
        box-shadow: 0 3px 18px rgba(100, 0, 0, .5);
        font-size: 16px;
    }
</style>
<center>
    <h1>用户登陆页面</h1>
</center>
<div class="container">

    <div class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-3 control-label">用户名</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="loginname" placeholder="请输入用户名">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="password" placeholder="请输入密码">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">验证码</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="imgCode" placeholder="请输入验证码">
            </div>
        </div>
        <div class="form-group">
            <img src="/imgCode" id="code"><a href="#" onclick="refreshImg()">换一张</a>
        </div>
        <div class="form-group">
            <div class="col-sm-2">
            </div>
            <div class="col-sm-10">
                <button class="btn btn-primary" onclick="login()">登录</button>
                <button class="btn btn-success">注册</button>
                <button class="btn btn-warning" onclick="toForgetPassword()">忘记密码</button>
            </div>
        </div>
    </div>

</div>
<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    function refreshImg() {
        var t=new Date().getTime();
        document.getElementById("code").src="/imgCode?"+t
    }
    function toForgetPassword() {
       location.href="/toFindPassword"
    }
    
    
    function login() {
         var loginname= $("#loginname").val();
         var password= $("#password").val();
         var imgCode= $("#imgCode").val();
         $.post({
             url:"/loginController/login",
             data:{"loginname":loginname,"password":password,"imgCode":imgCode},
             success:function (result) {

                 if (result.code==200){
                       location.href="/index/goBlank"
                 }else {
                     bootbox.alert({
                         message: "<span class='glyphicon glyphicon-info-sign'>"+result.msg+"",
                         size: 'small'
                     });
                 }
             }
         })
    }
    
</script>
</body>
</html>
