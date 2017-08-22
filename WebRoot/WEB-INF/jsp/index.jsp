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
<title>index</title>
<base href="<%=basePath%>">
<%@include file="common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<c:forEach items="${roles }" var="role">
		<c:if test="${role.name eq '系统管理员'}">
			<c:set var="hasPermission" value="true"></c:set>
		</c:if>
	</c:forEach>
	<c:if test="${!empty ct }">
		<c:forEach items="${masterin }" var="mi">
			<c:if test="${mi.categoryId eq ct.id}">
				<c:set var="hasPermission" value="true"></c:set>
			</c:if>
		</c:forEach>
	</c:if>
	<div class="wrapper">

		<%@include file="common/head.jsp"%>

		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div class="panel panel-default">
						<div class="panel-heading">
							<ul class="nav nav-pills">
								<li>
									<a href="index">全部</a>
								</li>
								<li class="dropdown" style="margin-right: 8px;">
									<a class="dropdown-toggle" data-toggle="dropdown" href="#"
									data-target="#"> 
										<c:if test="${empty ct }">板块</c:if>
										<c:if test="${!empty ct }">${ct.categoryName }</c:if>
									<span class="caret"></span>
									</a>
									<ul class="dropdown-menu">
										<c:forEach items="${cgList }" var="category">
											<li><a href="index?cid=${category.id }">${category.categoryName }</a>
										</li>
										</c:forEach>
									</ul>
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
											<c:if test="${hasPermission eq true }">
												<div class="pull-right">
													<a href="javascript:if(confirm('确定要删除吗？'))del('article/delete',${article.id })">删除</a>
												</div>
											</c:if>
											<script type="text/javascript">
												function del(url,id){
													$.ajax({
														url : url,
														data : {id:id},
														success : function(res){
															if(res == 'success'){
																window.location.reload();
															}else{
																alert('删除失败!');
															}
														}
													});
												}
											</script>
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
							<ul class="pagination">
							  <li><a href="index?page=1<c:if test='${!empty ct }'>&cid=${ct.id }</c:if>">首页</a></li>
							  <c:choose>
							  	<c:when test="${page-2>=1}">
							  		<li><a href="index?page=${page-2}<c:if test='${!empty ct }'>&cid=${ct.id }</c:if>">${page-2}</a></li>
							  		<li><a href="index?page=${page-1}<c:if test='${!empty ct }'>&cid=${ct.id }</c:if>">${page-1}</a></li>
							  	</c:when>
							  	<c:when test="${page-2==0}">
							  		<li><a href="index?page=${page-1}<c:if test='${!empty ct }'>&cid=${ct.id }</c:if>">${page-1}</a></li>
							  	</c:when>
							  </c:choose>
							  <li class="active disable"><a href="">${page}</a></li>
							  <c:choose>
							  	<c:when test="${totalPage-page>=2}">
							  		<li><a href="index?page=${page+1}<c:if test='${!empty ct }'>&cid=${ct.id }</c:if>">${page+1}</a></li>
							  		<li><a href="index?page=${page+2}<c:if test='${!empty ct }'>&cid=${ct.id }</c:if>">${page+2}</a></li>
							  	</c:when>
							  	<c:when test="${totalPage-page==1}">
							  		<li><a href="index?page=${page+1}<c:if test='${!empty ct }'>&cid=${ct.id }</c:if>">${page+1}</a></li>
							  	</c:when>
							  </c:choose>
							  <li><a href="index?page=${totalPage }<c:if test='${!empty ct }'>&cid=${ct.id }</c:if>">末页</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-md-3 hidden-sm hidden-xs hidden-sm hidden-xs">
					<c:if test="${!empty current_user }">
						<div class="panel panel-default">
						    <div class="panel-heading">
						        个人信息
						    </div>
						    <div class="panel-body">
						        <div class="media">
						            <div class="media-left">
						                <a href="/user/">
						                    <img src="${current_user.iconUrl }" title="${current_user.username }"" class="avatar"/>
						                </a>
						            </div>
						            <div class="media-body">
						                <div class="media-heading">
						                    <a href="user/info">${current_user.username }</a>
						                </div>
										<c:forEach items="${current_user.roles }" var="role">
											<c:if test="${role.name eq '系统管理员' }">
												<span class="badge">系统管理员</span>
											</c:if>
											<c:if test="${role.name eq '板块管理员' }">
												<c:forEach items="${masterin }" var="mi">
													<c:forEach items="${cgList }" var="ct">
														<c:if test="${mi.categoryId eq ct.id }">
															<div>
																<span class="badge">版主</span>:
																<a href="index?cid=${ct.id }">${ct.categoryName }</a>
															</div>
														</c:if>
													</c:forEach>
												</c:forEach>
											</c:if>
										</c:forEach>
						            </div>
						        </div>
						    </div>
						</div>
				        <div class="panel panel-default">
				        	<a href="create" class="btn btn-default btn-block">发布帖子</a>
				        </div>
					</c:if>
			    </div>
			</div>
		</div>
		<%@include file="common/footer.jsp"%>

	</div>
</body>
</html>
