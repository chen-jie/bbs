<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>noauth</title>
<base href="<%=basePath%>">
<%@include file="../common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<div class="wrapper">
		<%@include file="../common/head.jsp" %>
		 <div class="container">
		 	<script type="text/javascript">
		 		alert("你无权访问!");
		 	</script>
		 </div>
	</div>
    <%@include file="../common/footer.jsp" %>
    
</body>
</html>
