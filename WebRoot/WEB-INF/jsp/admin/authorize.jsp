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
<title>authorize</title>
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
				<li><a href="index"><i class="fa fa-home fa-fw"></i>主页</a></li>
				<li><a href="admin/user"><i class="fa fa-users fa-fw"></i>用户管理</a>
				</li>
				<li><a href="admin/category"><i class="fa fa-columns fa-fw"></i>板块管理</a>
				</li>
				<li><a href="admin/category/master" class="active"><i
						class="fa fa-user fa-fw"></i>任命版主</a></li>
				<li><a href="logout"><i class="fa fa-eject fa-fw"></i>退出</a></li>
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
				<div class="margin-bottom-70">
					<h2 style="display: inline;">
						<a href="admin/category/master"> <span
							class="label label-default">任命版主</span> </a>
					</h2>
					<h4 style="display: inline;">
						> <span class="label label-default">${category.categoryName
							}</span>
					</h4>
				</div>
				<div>
					<div class="templatemo-content-widget no-padding">
						<div class="panel panel-default table-responsive">
							<table
								class="table table-striped table-bordered templatemo-user-table">
								<thead>
									<tr>
										<td>用户名</td>
										<td>邮箱</td>
										<td>操作</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${userList }" var="user">
										<tr>
											<td>${user.username }</td>
											<td>${user.email }</td>
											<td>
											<c:choose>
												<c:when test="${ids.contains(user.id) eq true}">
													<button onclick="operate('admin/category/revoke',${category.id },${user.id})" class="btn btn-danger">撤销版主</button>
												</c:when>
												<c:otherwise>
													<button onclick="operate('admin/category/authorize',${category.id },${user.id})" class="btn btn-primary">任命版主</button>
												</c:otherwise>
											</c:choose>
											
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function operate(url,cid,uid){
			$.ajax({
					type: "POST",
		             url: url,
		             data: {
		             	cid:cid,
		             	uid:uid
		             	},
		             success: function(res){
		             	if(res=="success"){
		             		window.location.reload();
		             	}else{
		             		alert("操作失败!");
		             	}
		             }
				})
		}
	</script>
</body>
</html>
