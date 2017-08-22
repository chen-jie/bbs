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
<title>index</title>
<base href="<%=basePath%>">
<%@include file="common/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="static/css/index.css" type="text/css"></link>
</head>
<body style="padding:10px;background-image: url('static/images/bg.jpg');" >
<div style="width:100%px;height:100%;">
	
	<%@include file="common/head.jsp" %>
	 
	<script type="text/javascript">
		$.messager.alert('警告','无效操作！','error');
	</script>
	    
    <%@include file="common/footer.jsp" %>
    
</div>
</body>
</html>
