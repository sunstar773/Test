<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${!empty p}">
		<c:choose>
			<c:when test="${p.pageNum == 1}">
				首页，上一页,
			</c:when>
			<c:otherwise>
				<a href = "javaScript:;" onclick = "initShopPage(1)">首页</a>，
				<a href = "javaScript:;" onclick = "initShopPage(${p.pageNum-1})">上一页</a>，
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${p.pageNum==p.pageSum}">
				下一页，尾页
			</c:when>
			<c:otherwise>
				<a href = "javaScript:;" onclick = "initShopPage(${p.pageNum+1})">下一页</a>，
				<a href = "javaScript:;" onclick = "initShopPage(${p.pageSum})">尾页</a>，
			</c:otherwise>
		</c:choose>
	
	

   ，共 ${p.totalCount}条，共  ${p.pageSum}页，当前第 ${p.pageNum}页
</c:if>
</body>
</html>