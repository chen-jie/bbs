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
<title>user</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="static/js/jquery.min.js"></script>   
<script type="text/javascript" src="static/js/bootstrap.min.js"></script>   
<link href="static/css/font-awesome.css" rel="stylesheet">
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/template-style.css" rel="stylesheet">
</head>
<body>
	<!-- Left column -->
	<div class="templatemo-flex-row">
		<div class="templatemo-sidebar">
			<header class="templatemo-site-header">
			<div class="square"></div>
			<h1>欢迎你，${current_user.username }</h1>
			</header>
			<div class="profile-photo-container">
				<div class="profile-photo-overlay"></div>
			</div>

			<div class="mobile-menu-icon">
				<i class="fa fa-bars"></i>
			</div>
			<nav class="templatemo-left-nav">
			<ul>
				<li><a href="index"><i class="fa fa-home fa-fw"></i>主页</a>
				</li>
				<li><a href="admin/user" class="active"><i class="fa fa-users fa-fw"></i>用户管理</a>
				</li>
				<li><a href="admin/category"><i class="fa fa-columns fa-fw"></i>板块管理</a>
				</li>
				<li><a href="admin/category/master"><i class="fa fa-user fa-fw"></i>任命版主</a>
				</li>
				<li><a href="logout"><i class="fa fa-eject fa-fw"></i>退出</a>
				</li>
			</ul>
			</nav>
		</div>
		<!-- Main content -->
		<div class="templatemo-content col-1 light-gray-bg">
			<div class="templatemo-top-nav-container">
				<div class="row">
					<nav class="templatemo-top-nav col-lg-12 col-md-12">
					<ul class="text-uppercase">
						<li><a href="index" class="active">返回主页</a>
						</li>
					</ul>
					</nav>
				</div>
			</div>
			<div class="templatemo-content-container">
				<div class="templatemo-content-widget no-padding">
					<buton class="btn btn-primary" data-toggle="modal" 
   data-target="#myModal"><i class="fa fa-plus fa-fw"></i>添加用户</buton>
					<div class="panel panel-default table-responsive">
						<table
							class="table table-striped table-bordered templatemo-user-table">
							<thead>
								<tr>
									<td>编号</td>
									<td>用户名</td>
									<td>密码</td>
									<td>email</td>
									<td>删除</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${users}" var="user">
									<tr>
										<td>${user.id }</td>
										<td>${user.username }</td>
										<td>${user.password }</td>
										<td>${user.email }</td>
										<td><a href="javascript:void(0)" onclick="deleteUser(${user.id})"  class="templatemo-edit-btn">删除</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function deleteUser(id){
			var r = confirm("您确认想要删除此用户吗？");  
		    if (r){    
			        $.ajax({
			        	url: 'admin/user/delete',
			        	data: {id:id},
			        	success:function(data){
			        		if(data == 'success'){
				        		window.location.reload();
			        		}
			        		else{
			        			alert('删除失败！');
			        		}
			        	}
			        });
			    }    
		}
	</script>
	<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
			<form action="admin/user/add" class="templatemo-login-form">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">添加用户</h4>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label for="inputEmail">用户名</label> <input id="username"
									type="username" name="username" required="true"
									class="form-control" placeholder="输入用户名"> <span
									id="msg"></span>
							</div>
							<div class="form-group">
								<label for="inputEmail">邮箱</label> <input type="email"
									name="email" required="true" class="form-control"
									placeholder="输入邮箱">
							</div>
							<div class="form-group">
								<label for="inputEmail">密码</label> <input type="password"
									name="password" required="true" class="form-control"
									placeholder="输入密码">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="submit" class="btn btn-primary">添加</button>
						</div>
					</div>
					<!-- /.modal-content -->
			</form>
		</div><!-- /.modal -->
		<script type="text/javascript">
			var username = document.getElementById("username");
			username.addEventListener("blur",function(){
				$.ajax({
					type: "POST",
		             url: "checkusername",
		             data: {username:this.value},
		             success: function(data){
		             	$("#msg").html("");
		             	if(data=="true"){
		             		alert('用户名已经存在');
		             	}
		             }
				})
			});
		</script>
	</div>
</body>
</html>
