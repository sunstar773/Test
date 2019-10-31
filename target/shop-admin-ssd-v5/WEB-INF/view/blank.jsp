<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/9/2
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
  <center><h1>欢迎来到飞狐后台电商管理</h1>
<div id="myTime">
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="160" height="100" id="honehoneclock" align="middle">
        <param name="allowScriptAccess" value="always">
        <param name="movie" value="http://chabudai.sakura.ne.jp/blogparts/honehoneclock/honehone_clock_wh.swf">
        <param name="quality" value="high">
        <param name="bgcolor" value="#ffffff">
        <param name="wmode" value="transparent">
        <embed wmode="transparent" src="http://chabudai.sakura.ne.jp/blogparts/honehoneclock/honehone_clock_wh.swf" quality="high" bgcolor="#ffffff" width="300" height="100" name="honehoneclock" align="middle" allowscriptaccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
    </object>
</div>
<label id="time"></label>
  </center>
<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
</body>
</html>
