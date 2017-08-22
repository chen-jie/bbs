<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="cn.max.vo.Comment"%>
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
<title>show</title>
<base href="<%=basePath%>">
<%@include file="common/common.jsp"%>
<link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">   
<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script> 
<script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	function del(url,id){
		$.ajax({
			url : url,
			data : {id:id},
			success : function(res){
				if(res == 'success'){
					alert('删除成功!');
					window.close();
				}else{
					alert('删除失败!');
				}
			}
		});
	}
	function delCmt(url,id,aid){
		$.ajax({
			url : url,
			data : {id:id,aid:aid},
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
</head>
<body>
	<c:forEach items="${roles }" var="role">
		<c:if test="${role.name eq '系统管理员'}">
			<c:set var="hasPermission" value="true"></c:set>
		</c:if>
	</c:forEach>
	<c:if test="${hasPermission ne true and !empty current_user}">
		<c:forEach items="${masterin }" var="mi">
			<c:if test="${mi.categoryId eq category.id}">
				<c:set var="hasPermission" value="true"></c:set>
			</c:if>
		</c:forEach>
	</c:if>
	<c:if test="${article.userId eq current_user.id }">
		<c:set var="isOwn" value="true"/>
	</c:if>
	<div class="wrapper">
		<%@include file="common/head.jsp"%>
		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div class="panel panel-default">
						<div class="panel-body topic-detail-header">
							<div class="media">
								<div class="media-body">
									<h2 class="topic-detail-title">${article.title}</h2>
									<p class="gray">
										 <span><a href="/user/${author.username}">${author.username}</a>
										</span> <span>•</span> <span>发表于<fmt:formatDate value="${article.publishTime }" pattern="yyyy-MM-dd" /></span>
										<span>•</span> <span>${article.viewCount}次点击</span> <span>•</span>
										<span>来自 <a href="index?cid=${category.id}">${category.categoryName}</a>
										</span>
										<c:if test="${isOwn eq true }">
											<span>•</span>
											<span><a href="article/edit?id=${article.id }">编辑</a> </span>
										</c:if>
										<c:choose>
											<c:when test="${isOwn eq true }">
												<span>•</span> 
												<span>
													<a href="javascript:if(confirm('确定要删除吗？'))del('article/delown',${article.id })">删除</a>
												</span>
											</c:when>
											<c:when test="${hasPermission eq true }">
												<span>•</span> 
												<span>
													<a href="javascript:if(confirm('确定要删除吗？'))del('article/delete',${article.id })">删除</a>
												</span>
											</c:when>
										</c:choose>
									</p>
								</div>
								<div class="media-right">
									<img src="${author.iconUrl}" alt=""
										class="avatar-lg" />
								</div>
							</div>
						</div>
						<div class="divide"></div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">${article.replyCount} 条回复</div>
						<div class="panel-body paginate-bot">
							<c:forEach items="${ctList }" var="comment">
								<div class="media">
									<div class="media-left">
										<img src="${comment.user.iconUrl }" class="avatar" alt="">
									</div>
									<div class="media-body reply-content">
										<div class="media-heading gray">
							                ${comment.user.username } 
							                <span>•</span>
							                <c:if test="${comment.user.id eq author.id }">
							                	<span class="badge" id="badge">楼主</span>
							                	 <span>•</span>
							                </c:if>
							                <fmt:formatDate value="${comment.commentTime }" pattern="yyyy-MM-dd HH:mm"/> 　
							                    <span class="pull-right">
							                        #${comment.num }楼
							                        <c:if test="${!empty current_user }">
							                        |<a href="javascript:reply('${comment.content }',${comment.id },'${comment.user.username }');">回复</a>
							                        </c:if>
							                      	<c:if test="${comment.num ne 1 }">
							                      		<c:choose>
															<c:when test="${isOwn eq true }">
																|<a href="javascript:if(confirm('确定要删除吗？'))delCmt('article/delowncmt',${comment.id },${article.id })">删除</a>
															</c:when>
															<c:when test="${hasPermission eq true }">
																|<a href="javascript:if(confirm('确定要删除吗？'))delCmt('comment/delete',${comment.id },${article.id })">删除</a>
															</c:when>
															<c:when test="${comment.userId eq current_user.id }">
																|<a href="javascript:if(confirm('确定要删除吗？'))delCmt('comment/delown',${comment.id },${article.id })">删除</a>
															</c:when>
														</c:choose>
							                      	</c:if>
							                    </span>
							            </div>
							            <p></p>
							            <p>
							            <%
							            	Stack stack = new Stack();
							            	Comment comment = (Comment)pageContext.getAttribute("comment");
							            	Comment temp = comment;
											while(temp.getParent()!=null){
												temp = temp.getParent();
												stack.push(temp);
											}
											int size = stack.size();
											while(size>0){
												size--;
											%>
												<div class="well">
											<% 
											}
											while(!stack.empty()){
												Comment c= (Comment)stack.pop();
							             %>
							            		
							            			<p class="gray">#<%=c.getNum() %>楼　<%=c.getUser().getUsername() %>:</p>
							            			<%=c.getContent() %>
							            		</div>
							            		<%} %>
							            <%=comment.getContent()  %></p>
							            <p></p>
									</div>
								</div>
								<div class="divide mar-top-5"></div>
							</c:forEach>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							添加一条新回复 <a href="javascript:goTop();" class="pull-right">回到顶部</a>
						</div>
						<div class="panel-body">
							<form action="comment/add" requried="true" method="post" id="replyForm">
								<input type="hidden" name="aid" value="${article.id }">
								<input type="hidden" name="pid" id="pid">
								<div class="form-group hidden" id="reply">
									<label for="">正在回复:<span id="replyname"></span></label>
									<input type="text" id="pcontent"
										class="form-control" disabled="true">
								</div>
								<c:if test="${empty current_user }">
										<div
											style="height:200px;background-color: #F0F0F0;border: 1px solid #D9D9D9;line-height: 200px;text-align: center;">
											您需要登录后才能发表回复 <a href="login.jsp">登录</a> ｜ <a href="register.jsp">立即注册</a>
										</div>
									</c:if>
								<c:if test="${!empty current_user }">
									<div class="form-group">
									<textarea name="content" required="true" id="content"
										rows="5" class="form-control"></textarea>
									</div>
									<input type="submit" class="btn btn-default" value="回复"></input>
									<button onclick="cancelReply();" class="btn btn-danger pull-right">取消</button>
								</c:if>
								
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-3 hidden-sm hidden-xs hidden-sm hidden-xs">
					
				</div>
		</div>
		<%@include file="common/footer.jsp"%>
	</div>
	<script type="text/javascript">
		function reply(content,pid,username){
			$('#reply').removeClass("hidden");
			$('#pid').val(pid);
			$('#pcontent').val(content);
			$('#content').focus();
			$('#replyname').html(username);
		}
		function cancelReply(){
			$('#reply').addClass("hidden");
			$('#pid').val('');
			$('#content').val('');
			$('#pcontent').val('');
		}
	</script>
</body>
</html>
