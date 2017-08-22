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
<title>search</title>
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
							<ul class="nav nav-pills">
								<li>
									帖子标题中含有 '${keyword }' 的结果
								</li>
							</ul>
						</div>
						<div class="panel-body paginate-bot">
							<c:forEach items="${atList }" var="article">
								<div class="media">
									<div class="media-left">
										<img class="avatar" src="${article.iconUrl }"></img>
									</div>
									<div class="media-body">
										<div class="title">
											<a href="show?aid=${article.id }" target="_blank">${article.title }</a>
										</div>
										<p class="gray">
											<span>${article.authorName }</span>
											<span>•</span>
											<span>${article.replyCount }个回复</span>
											<span>•</span>
											<span>${article.viewCount }次浏览</span>
											<span>•</span>
											<span>发表于<fmt:formatDate value="${article.publishTime }" pattern="yyyy-MM-dd" /></span>
											<span>•</span>
											<span>最后回复时间<fmt:formatDate value="${article.lastReplyTime }" pattern="yyyy-MM-dd HH:mm" /></span>
										</p>
									</div>
									<div class="divide mar-top-5"></div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-9">
					<div class="panel panel-default">
						<div class="panel-heading">
							<ul class="nav nav-pills">
								<li>
									回复中含有 '${keyword }' 的结果
								</li>
							</ul>
						</div>
						<div class="panel-body paginate-bot">
							<c:forEach items="${ctList }" var="comment">
								<div class="media">
									<div class="media-left">
										<img class="avatar" src="${comment.user.iconUrl }"></img>
									</div>
									<div class="media-body">
										<div class="title">
											<a href="show?aid=${comment.articleId }" target="_blank">${comment.content }</a>
										</div>
										<p class="gray">
											<span>回复于<fmt:formatDate value="${comment.commentTime }" pattern="yyyy-MM-dd" /></span>
										</p>
									</div>
									<div class="divide mar-top-5"></div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@include file="common/footer.jsp"%>

	</div>
</body>
</html>
