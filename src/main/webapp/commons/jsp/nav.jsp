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
<style>
    .dropdown-submenu {
        position: relative;
    }

    .dropdown-submenu > .dropdown-menu {
        top: 0;
        left: 100%;
        margin-top: -6px;
        margin-left: -1px;
        -webkit-border-radius: 0 6px 6px 6px;
        -moz-border-radius: 0 6px 6px;
        border-radius: 0 6px 6px 6px;
    }

    .dropdown-submenu:hover > .dropdown-menu {
        display: block;
    }

    .dropdown-submenu > a:after {
        display: block;
        content: " ";
        float: right;
        width: 0;
        height: 0;
        border-color: transparent;
        border-style: solid;
        border-width: 5px 0 5px 5px;
        border-left-color: #ccc;
        margin-top: 5px;
        margin-right: -10px;
    }

    .dropdown-submenu:hover > a:after {
        border-left-color: #fff;
    }

    .dropdown-submenu.pull-left {
        float: none;
    }

    .dropdown-submenu.pull-left > .dropdown-menu {
        left: -100%;
        margin-left: 10px;
        -webkit-border-radius: 6px 0 6px 6px;
        -moz-border-radius: 6px 0 6px 6px;
        border-radius: 6px 0 6px 6px;
    }
    table{word-break:break-all;}
/*
  !* !*dateTable*!*!
     .table th{ !*!*数据表格标题文字居中*!*!
         text-align: center;
         vertical-align: middle!important;
     }
   !*  标题不换行*!
    .dataTable th {
        white-space: nowrap !important;
    }
*/

</style>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">飞狐电商后台管理</a>
        </div>
       <div id="sun"></div>
            <ul class="nav navbar-nav navbar-right" id="initUserInfo">
                <li ><a href="#">欢迎用户：##realname##</a></li>
                <li ><a href="#"><img src="/##imgurl##" width="30px"  class="img-circle"></a></li>
                <li ><a   href="/goChangePassword">修改密码</a></li>
                <li ><a href="#">当天登陆次数：##loginCount##</a></li>
                <li style="display: none" id="logintime"><a href="#">上次登陆时间：##loginTime##</a></li>
              <%--  <c:if test="${!empty u.loginTime}">
                <li ><a href="#">上次登陆时间：<fmt:formatDate value="${u.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a></li>
            </c:if>--%>
                <li ><a   href="/loginController/loginOut"><i class="glyphicon glyphicon-off">退出</i></a></li>
            </ul>
    </div>
</nav>
<script src="/js/jquery-3.3.1.js"></script>
<script>
    $(function () {
        /*这是 ajax的全局设置  */
        $.ajaxSetup({
            complete:function (result) {
                var re= result.responseJSON;
                console.log(re.data)
                if (re.code && re.code!=200) {
                    bootbox.alert({
                        message: "<span class='glyphicon glyphicon-info-sign'>"+re.msg,
                        size: 'small'
                    });
                }/*else if (re.code==-1){
                    bootbox.alert({
                        message: "<span class='glyphicon glyphicon-info-sign'>操作失败",
                        size: 'small'
                    });
                }*/
            }

        })
        topMenu();
        initUserInfo()
    })

    function initUserInfo() {
        $.post({
            url:"/findUserInfo",
            success:function (result) {
                if (result.code==200){

                    var v_data=result.data
                    if (v_data.loginTime){
                       var timeHtml= $("#logintime").html().replace(/##loginTime##/g,v_data.loginTime)
                        $("#logintime").html(timeHtml)
                        $("#logintime").show()
                    }
                    var userInfo=$("#initUserInfo").html().replace(/##realname##/g,v_data.realname).replace(/##loginCount##/g,v_data.loginCount)
                        .replace(/##imgurl##/g,v_data.imgurl)
                    $("#initUserInfo").html(userInfo);
                }
            }
        })
    }

    var menuArr=[];
    function  topMenu() {
        $.post({
            url:"/queryMenuById",
            type:"post",
            success:function (result) {
                menuArr=result;
                initMenu(1,1);
            }
        })
    }
    var sun=""
    function initMenu(id,level){
        console.log(level)
        var v_childrens=getChildren(id);
        if( v_childrens.length>0){
            if (level==1){
                sun+="<ul class=\"nav navbar-nav\">"
            }else {
                sun+="<ul class=\"dropdown-menu\">"
            }
            for(var b=0;b<v_childrens.length;b++){
                var flag=getChi(v_childrens[b].id)
                if (flag){
                    if (level==1){
                        sun+="<li><a href='"+v_childrens[b].menuurl+"'cass='dropdown-toggle' data-toggle='dropdown'>"+v_childrens[b].name+"<span class='caret'></span></a>"
                    }
                    else {
                        sun+="<li class='dropdown-submenu'><a  href='"+v_childrens[b].menuurl+"'>"+v_childrens[b].name+"</a>"
                    }
                }else {
                    sun+=" <li><a href='"+v_childrens[b].menuurl+"'>"+v_childrens[b].name+"</a>"
                }
                initMenu(v_childrens[b].id,level+1)
                sun+="</li>"
            }
            sun+="</ul>"
            $("#sun").html(sun)

        }

    }
    function getChildren(id){
        var topChildren=[]
        for(var a=0;a<menuArr.length;a++){
            if(menuArr[a].pId==id){
                topChildren.push(menuArr[a])
            }
        }
        return topChildren;
    }
    function getChi(id) {
        for(var a=0;a<menuArr.length;a++){
            if(menuArr[a].pId==id){
                return true;
            }
        }
        return false;
    }
</script>
<%--<script >

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
</script>--%>

</html>
