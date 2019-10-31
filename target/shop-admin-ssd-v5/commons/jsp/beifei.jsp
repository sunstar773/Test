<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/8/28
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%--导航条--%>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6">
                <div class="navbar-header">
                    <a class="navbar-brand" href="/index/goBlank">飞狐电商后台管理</a>
                </div>
                <div >

                    <ul  class="nav navbar-nav" id="menu">


                </ul>
                </div>
            </div>
            <div class="col-sm-6">
                <ul class="nav navbar-nav">
                    <li ><a href="#">欢迎用户：${u.realname}</a></li>
                    <li ><a href="#"><img src="/${u.imgurl}" width="30px"  class="img-circle"></a></li>
                    <li ><a href="#">当天登陆次数：${u.loginCount}</a></li>
                    <c:if test="${!empty u.loginTime}">
                        <li ><a href="#">上次登陆时间：<fmt:formatDate value="${u.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a></li>
                    </c:if>
                    <li ><a   href="/loginController/loginOut"><i class="glyphicon glyphicon-off">退出</i></a></li>
                </ul>
            </div>
        </div>

    </div>
</nav>
<script src="/js/jquery-3.3.1.js"></script>
<script >

    $(function () {
        topMenu()
    })
    var menuArr;
    function  topMenu() {
        $.post({
            url:"/queryMenuById",
            type:"post",
            success:function (result) {
                menuArr=result;
                initMenu();
                console.log(menuArr)
            }
        })
    }
    function initMenu() {
        /*顶级 的菜单hml*/
        var topMenuHtml= getTopMenu();

        var menuHtmlObj=$(topMenuHtml)
        /*获取顶级菜单 的id 数组*/
        var topArr= getTopMenuArr();
        /*循环顶级菜单 ID数组*/
        for (var a=0;a<topArr.length;a++){
            /*每个顶级菜单  下的   子菜单数组 */
            var topChildArr= getTopChildren(topArr[a])

            var v_href= menuHtmlObj.find("a[data-id='"+topArr[a]+"']")
            if (topChildArr.length>0){
                v_href.attr("data-toggle","dropdown");
                v_href.append('<span class="caret"></span>');
                var childHtml= getChildrenHtml(topChildArr)
                v_href.parent().append(childHtml)

            }
        }
        $("#menu").html(menuHtmlObj)
    }
    /*顶级 的菜单hml*/
    function getTopMenu() {
        var topHtml=""
        for (var a=0;a<menuArr.length;a++){
            if (menuArr[a].pId==1) {
                topHtml+="<li ><a   data-id='"+menuArr[a].id+"'  href='"+menuArr[a].menuurl+"'>"+menuArr[a].name+"</a></li>"
            }
        }
        return topHtml;
    }
    /*获取顶级菜单 的id 数组*/
    function getTopMenuArr() {
        var topMenuArr=[];
        for (var a=0;a<menuArr.length;a++){
            if (menuArr[a].pId==1){
                topMenuArr.push(menuArr[a].id)
            }
        }
        return topMenuArr;
    }
    /*获取 每个顶级菜单的 子菜单*/
    function getTopChildren(id) {
        var childrenArr=[]
        for (var a=0;a<menuArr.length;a++){
            if (menuArr[a].pId==id){
                childrenArr.push(menuArr[a])
            }
        }
        console.log(childrenArr)
        return childrenArr
    }

    function getChildrenHtml(children) {
        var c_html="<ul class=\"dropdown-menu\">"
        for (var a=0;a<children.length;a++){
            c_html+="<li><a href='"+children[a].menuurl+"'>"+children[a].name+"</a></li>"
        }
        c_html+="</ul>"
        return c_html;
    }
</script>
</body>
</html>
