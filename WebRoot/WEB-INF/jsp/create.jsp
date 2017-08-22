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
<title>create</title>
<base href="<%=basePath%>">
<%@include file="common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<div class="wrapper">

		<%@include file="common/head.jsp"%>

		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div class="panel panel-default">
						<div class="panel-heading">
							<a href="index">主页</a> / 发布话题
						</div>
						<div class="panel-body">
							<form method="post" action="article/publish" id="topicForm">
								<div class="form-group">
									<label for="title">标题</label> <input required="true" type="text"
										class="form-control" id="title" name="title" placeholder="标题">
								</div>
								<div class="form-group">
									<label for="title">内容</label>
									<textarea required="true" name="content" id="content" rows="15"
										class="form-control" placeholder="在此输入内容~"></textarea>
								</div>
								<div class="form-group">
									<label for="title">版块</label> 
									<select name="cid" id="tab" class="form-control"> 
										<c:forEach items="${ctList }" var="category">
											<option value="${category.id }">${category.categoryName }</option>
										</c:forEach>
									</select>
								</div>
								<input type="submit" class="btn btn-default" value="发布">
							</form>
							<div id="preview"></div>
						</div>
					</div>
				</div>
				<div class="col-md-3 hidden-sm hidden-xs hidden-sm hidden-xs">
					<div class="panel panel-default">
						<div class="panel-heading">
							<b>话题发布指南</b>
						</div>
						<div class="panel-body">
							<p>• 请勿重复发表相同内容</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@include file="common/footer.jsp"%>

	</div>
</body>
</html>
