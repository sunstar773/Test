<!doctype html>
<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>Document</title>
</head>
<body>


</body>
<script src="/js/jquery-3.3.1.js"></script>
<script>
    $(function () {
        topMenu();
    })

    var menuArr;
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
        var v_childrens=getChildren(id)
        console.log(v_childrens)
        if( v_childrens.length>0){
            if (level==1){
                sun+="<ul class=\"nav navbar-nav\">"
            }else {
                sun+="<ul class=\"dropdown-menu\">"
            }
            for(var b=0;b<v_childrens.length;b++){
                  var flag=getChi(v_childrens[b].id)
                if (level==1){
                      sun+="<li><a href='"+v_childrens[b].url+"' data-toggle=\"dropdown\">"+v_childrens[b].name+"<span class=\"caret\"></span></a>"
                }
                else {
                      sun+="<li class=\"dropdown-submenu\"><a  href='\"+v_childrens[b].url+\"'>"+v_childrens[b].name+"</a>"
                }
                initMenu(v_childrens[b].id,level+1)
                sun+="</li>"
            }
            sun+="</ul>"
            $("#da").html(sun)
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
            }else {
                return false;
            }
        }
    }





</script>

</html>
