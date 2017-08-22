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
<title>edit</title>
<base href="<%=basePath%>">
<%@include file="../common/common.jsp"%>
<link rel="stylesheet" href="static/css/form.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<div class="wrapper">

		<%@include file="../common/head.jsp"%>

		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div class="panel panel-default">
						<div class="panel-heading">
							修改密码
						</div>
						<div class="panel-body">
							<form  action="user/editSubmit" method="post">
								<div class="text-center">
									<h2 style="color: #09F;">${msg }</h2>
									<div class="form-group">
									<div class="col-xs-12  ">
										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-lock"></span>
											</span> <input type="password" required="true" name="old"
												class="form-control" placeholder="原密码">
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-12  ">
										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-lock"></span>
											</span> <input type="password" id="password" required="true" name="password"
												class="form-control" placeholder="新密码">
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-12  ">
										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-lock"></span>
											</span> <input type="password" id="confirm-password" required="true" name="password2"
												class="form-control" placeholder="确认密码">
										</div>
									</div>
								</div>
								<input type="submit" onclick="return check();" class="btn btn-default" value="确认修改">
								</div>
							</form>
							<div id="preview"></div>
						</div>
					</div>
				</div>
				<div class="col-md-3 hidden-sm hidden-xs hidden-sm hidden-xs">
					<div class="panel panel-default">
						<div class="panel-heading">
							<b> </b>
						</div>
						<div class="panel-body">
							<p> </p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
		function check(){
			var password=document.getElementById("password").value;
			var confirm=document.getElementById("confirm-password").value;
			if(password!=confirm){
				alert("两次密码输入不一致！");
				return false;
			}
			return true;
		}
	</script>
		<%@include file="../common/footer.jsp"%>

	</div>
</body>
</html>
