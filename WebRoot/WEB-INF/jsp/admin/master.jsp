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
<title>master</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="static/js/jquery.min.js"></script>
<script type="text/javascript" src="static/js/bootstrap.min.js"></script>
<link href="static/css/font-awesome.css" rel="stylesheet">
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/template-style.css" rel="stylesheet">
<style type="text/css">
.templatemo-content-widget:hover {
	background-color: gray;
}
</style>
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
				<li><a href="admin/user"><i class="fa fa-users fa-fw"></i>用户管理</a>
				</li>
				<li><a href="admin/category"><i class="fa fa-columns fa-fw"></i>板块管理</a>
				</li>
				<li><a href="admin/category/master" class="active"><i
						class="fa fa-user fa-fw"></i>任命版主</a>
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
						<li><a href="index" class="active">返回主页</a></li>
					</ul>
					</nav>
				</div>
			</div>
			<div class="templatemo-content-container">
				<div class="margin-bottom-70">
					<h2 style="display: inline;">
						<a href="admin/category/master"> <span class="label label-default">任命版主</span> </a>
					</h2>
				</div>
				<div>
					<c:forEach items="${categories }" var="category">
					<a href="admin/category/master?cid=${category.id }">
						<div
							class="templatemo-content-widget white-bg text-center templatemo-position-relative"
							style="max-width:200px;float:left;min-height:200px;">
							<h2 class="blue-text margin-bottom-5">${category.categoryName }</h2>
						</div> 
					</a>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
