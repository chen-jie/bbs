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
<title>register</title>
<base href="<%=basePath%>">
<%@include file="WEB-INF/jsp/common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="static/css/form.css">
<style type="text/css">
	.red{
		color: red;
	}
	.succ{
		color: #09F;
	}
</style>
</head>
<body>
	<div class="wrapper">

		<%@include file="WEB-INF/jsp/common/head.jsp"%>

		<div class="container">
			<div class="box">
				<div class="login-box">
					<div class="login-title text-center">
						<h1>
							<small>注册</small>
						</h1>
					</div>
					<div class="login-content ">
						<div class="form">
							<form action="register" method="post">
								<div class="text-center">
									<h2 id="msg">${msg }</h2>
								</div>
								<div class="form-group">
									<div class="col-xs-12  ">
										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-user"></span>
											</span> <input type="text" required="true" name="username"
												id="username" class="form-control" placeholder="用户名">
										</div>
									</div>
								</div>
								<script type="text/javascript">
						        	var username = document.getElementById("username");
										username.addEventListener("blur",function(){
											$.ajax({
												type: "POST",
									             url: "checkusername",
									             data: {username:this.value},
									             success: function(data){
									             	$("#msg").removeClass('red');
									           	 	$("#msg").addClass('succ');
									             	$("#msg").html("");
									             	if(data=="true"){
									             		$("#msg").removeClass('succ');
									             		$("#msg").addClass('red');
									             		$("#msg").html("用户名已存在");
									             	}
									             }
											})
										});
						        </script>
								<div class="form-group">
									<div class="col-xs-12  ">
										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-envelope"></span>
											</span> <input type="email" required="true" name="email"
												class="form-control" placeholder="邮箱">
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-12  ">
										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-lock"></span>
											</span> <input type="password" id="password" required="true" name="password"
												class="form-control" placeholder="密码">
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
										<button type="submit" onclick="return check();" class="btn btn-sm btn-info">
											<span class="glyphicon glyphicon-off"></span> 注册
										</button>
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
		function check(){
			var password=document.getElementById("password").value;
			var confirm=document.getElementById("confirm-password").value;
			if(password!=confirm){
				alert("两次密码输入不一致！");
				return false;
			}
			return true;
		}
		function changeCode(){
			$('#code').attr('src','code?'+new Date());
		}
	</script>
</body>
</html>
