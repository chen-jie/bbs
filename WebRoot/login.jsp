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
<title>login</title>
<base href="<%=basePath%>">
<%@include file="WEB-INF/jsp/common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="static/css/form.css">
</head>
<body>
	<div class="wrapper">

		<%@include file="WEB-INF/jsp/common/head.jsp"%>

		<div class="container">
			<div class="box">
		<div class="login-box">
			<div class="login-title text-center">
				<h1><small>登录</small></h1>
			</div>
			<div class="login-content ">
			<div class="form">
			<form action="login" method="post">
				<div class="text-center">
					<h2 style="color: red">${msg }</h2>
					<% session.removeAttribute("msg"); %>
				</div>
				<div class="form-group">
					<div class="col-xs-12  ">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
							<input type="text" required="true" name="username" class="form-control" placeholder="用户名">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12  ">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
							<input type="password" required="true" name="password" class="form-control" placeholder="密码">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-6">
						<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-bell"></span></span>
						<input required="true" name="code" class="form-control" placeholder="验证码">
						</div>
					</div>
					<div class="col-xs-6">
						<a href="javascript:void(0)" onclick="changeCode()">
							<img id="code" src="code"></img>
							看不清，换一张
						</a>
					</div>
				</div>
				<div class="form-group form-actions">
					<div class="col-xs-4 col-xs-offset-4 ">
						<button type="submit" class="btn btn-sm btn-info"><span class="glyphicon glyphicon-off"></span> 登录</button>
					</div>
				</div>
			</form>
			</div>
		</div>
	</div>
</div>
		</div>
		<%@include file="WEB-INF/jsp/common/footer.jsp"%>

	</div>
	
	<script type="text/javascript">
		function changeCode(){
			$('#code').attr('src','code?'+new Date());
		}
	</script>
</body>
</html>
