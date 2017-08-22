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
<title>category</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="static/js/jquery.min.js"></script>
<script type="text/javascript" src="static/js/bootstrap.min.js"></script>
<link href="static/css/font-awesome.css" rel="stylesheet">
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/template-style.css" rel="stylesheet">
	<script type="text/javascript">
		function deleteCategory(id) {
				var r = confirm("您确认想要删除此板块吗？改板块下所有的帖子和回复将会一起被删除！");
				if (r) {
					$.ajax({
						url : 'admin/category/delete',
						data : {
							id : id
						},
						success : function(data) {
							if (data == 'success') {
								window.location.reload();
							} else {
								alert('删除失败！');
							}

						}
					})
				}
			};
		function editModal(id,content){
			$('#edit_cid').val(id);
			$('#edit_cname').val(content);
			$('#Modal').modal('show');
		}
			var cname = document.getElementById("cname");
			var edit_cname = document.getElementById("edit_cname");
			cname.addEventListener("blur",function(){
				$.ajax({
					type: "POST",
		             url: "checkcategoryname",
		             data: {cname:this.value},
		             success: function(data){
		             	$("#msg").html("");
		             	if(data=="true"){
		             		alert('该板块已经存在！请勿重复添加！');
		             	}
		             }
				})
			});
			edit_cname.addEventListener("blur",function(){
				$.ajax({
					type: "POST",
		             url: "checkcategoryname",
		             data: {cname:this.value},
		             success: function(data){
		             	$("#msg").html("");
		             	if(data=="true"){
		             		alert('该板块已经存在！请勿重复添加！');
		             	}
		             }
				})
			});
		</script>
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
				<li><a href="admin/category" class="active"><i
						class="fa fa-columns fa-fw"></i>板块管理</a></li>
				<li><a href="admin/category/master"><i
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
						<li><a href="index" class="active">返回主页</a></li>
					</ul>
					</nav>
				</div>
			</div>
			<div class="templatemo-content-container">
				<div class="templatemo-content-widget no-padding">
					<buton class="btn btn-primary" data-toggle="modal"
						data-target="#myModal"> <i class="fa fa-plus fa-fw"></i>添加板块</buton>
					<div class="panel panel-default table-responsive">
						<table
							class="table table-striped table-bordered templatemo-user-table">
							<thead>
								<tr>
									<td>板块编号</td>
									<td>板块名称</td>
									<td>编辑</td>
									<td>删除</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${categories}" var="category">
									<tr>
										<td>${category.id }</td>
										<td>${category.categoryName }</td>
										<td><a href="javascript:void(0)" onclick="editModal(${category.id },'${category.categoryName }')"
											class="templatemo-edit-btn">编辑</a>
										</td>
										<td><a href="javascript:void(0)"
											onclick="deleteCategory(${category.id})"
											class="templatemo-edit-btn">删除</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<form action="admin/category/add" class="templatemo-login-form" method="post">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">添加板块</h4>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label for="cname">板块名称</label> <input id="cname" name="cname"
									required="true" class="form-control" placeholder="输入板块名称">
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
		</div>
		<!-- /.modal -->
		<!-- 模态框（Modal） -->
	</div>
	<!-- /.modal -->

<!-- 模态框（Modal） -->
<div class="modal fade" id="Modal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <form action="admin/category/edit" class="templatemo-login-form" method="post">
   <input type="hidden" name="cid" id="edit_cid">
   <div class="modal-dialog">
      <div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">编辑板块</h4>
		</div>
		<div class="modal-body">
			<div class="form-group">
				<label for="cname">板块名称</label> <input id="edit_cname" name="cname"
					required="true" class="form-control" placeholder="输入板块名称">
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default"
				data-dismiss="modal">关闭</button>
			<button type="submit" class="btn btn-primary">确认修改</button>
		</div>
	</div>
	</form>
</div><!-- /.modal -->
</div>
</body>
</html>
