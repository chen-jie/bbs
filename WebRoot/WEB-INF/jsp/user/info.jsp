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
<title>info</title>
<base href="<%=basePath%>">
<%@include file="../common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="static/js/cropbox-min.js"></script>
<style>
.cnt {
	position: absolute;
	top: 10%;
	left: 10%;
	right: 0;
	bottom: 0;
}

.action {
	width: 400px;
	height: 30px;
	margin: 10px 0;
}

.cropped>img {
	margin-right: 10px;
}

.imageBox {
	position: relative;
	height: 400px;
	width: 400px;
	border: 1px solid #aaa;
	background: #fff;
	overflow: hidden;
	background-repeat: no-repeat;
	cursor: move;
}

.imageBox .thumbBox {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 200px;
	height: 200px;
	margin-top: -100px;
	margin-left: -100px;
	box-sizing: border-box;
	border: 1px solid rgb(102, 102, 102);
	box-shadow: 0 0 0 1000px rgba(0, 0, 0, 0.5);
	background: none repeat scroll 0% 0% transparent;
}

.imageBox .spinner {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	text-align: center;
	line-height: 400px;
	background: rgba(0, 0, 0, 0.7);
}
</style>
</head>
<body>
	<div class="wrapper">

		<%@include file="../common/head.jsp"%>

		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div class="panel panel-default">
						<div class="panel-heading">个人资料</div>
						<div class="panel-body">
							<h2>上传头像</h2>
							<form enctype="multipart/form-data" method="post"
								action="user/head">
								<div class="ctn">
									<div style="float:left;">
										<div class="imageBox">
											<div class="thumbBox"></div>
											<div class="spinner" style="display: none">Loading...</div>
										</div>
										<div class="action">
											<input type="file" id="file" style="float:left; width: 250px">
											<input class="btn btn-primary" type="button" id="btnCrop" value="确定裁剪" style="float: right"> 
											<input class="btn btn-default" type="button" id="btnZoomIn" value="+" style="float: right"> 
											<input class="btn btn-default" type="button" id="btnZoomOut" value="-" style="float: right">
										</div>
									</div>
									<div style="float:left;">
												　　　　预览
										<div class="cropped"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
								<script type="text/javascript">
									$(window).load(
										function() {
											var options = {
												thumbBox : '.thumbBox',
												spinner : '.spinner',
												imgSrc : '${current_user.iconUrl}'
											}
											var cropper = $('.imageBox').cropbox(options);
											$('#file').on('change',function() {
												var reader = new FileReader();
												reader.onload = function(
														e) {
													options.imgSrc = e.target.result;
													cropper = $('.imageBox').cropbox(options);
												}
												reader.readAsDataURL(this.files[0]);
												this.files = [];
											})
											$('#btnCrop').on('click',function() {
												var img = cropper.getDataURL();
												$('.cropped').html('');
												$('.cropped').append('<img src="'+img+'">');
											})
											$('#btnZoomIn').on('click',function() {
																cropper.zoomIn();
															})
											$('#btnZoomOut').on('click',function() {
																cropper.zoomOut();
															})
											$('#upbtn').on('click',function() {
												var blob = cropper.getBlob();
												var fd = new FormData();

												fd.append('file',blob);
												$.ajax({
															url : "user/head",
															type : "POST",
															data : fd,
															processData : false,
															contentType : false,
															success : function(
																	res) {
																if (res == 'success') {
																	alert("上传成功！");
																	window.location.reload();
																} else {
																	alert("上传失败！");
																}
															}
														});
											})
										});
								</script>
<!-- 								<div class="form-group"> -->
<!-- 									<label for="用户名">用户名</label> <input type="text" -->
<!-- 										class="form-control" disabled="true" name="" placeholder="" -->
<!-- 										value="${current_user.username }"> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label for="title">邮箱</label> <input type="text" -->
<!-- 										class="form-control" disabled="true" name="" placeholder="" -->
<!-- 										value="${current_user.email }"> -->
<!-- 								</div> -->
							<div class="divide mar-top-5"></div>
								<input type="button" id="upbtn" class="btn btn-success" value="确认上传">
							</form>
							<div id="preview"></div>
						</div>
					</div>
				</div>
				<div class="col-md-3 hidden-sm hidden-xs hidden-sm hidden-xs">
					<div class="panel panel-default">
						<div class="panel-heading">
							<b>个人信息</b>
						</div>
						<div class="panel-body">
									<div class="form-group">
									<label for="用户名">用户名</label> <input type="text"
										class="form-control" disabled="true" name="" placeholder=""
										value="${current_user.username }">
								</div>
								<div class="form-group">
									<label for="title">邮箱</label> <input type="text"
										class="form-control" disabled="true" name="" placeholder=""
										value="${current_user.email }">
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@include file="../common/footer.jsp"%>

	</div>
</body>
</html>
