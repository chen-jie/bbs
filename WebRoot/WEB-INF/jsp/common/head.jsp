<%@ page language="java" pageEncoding="UTF-8"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="index"><img alt="BBS" src="static/images/bbs.png" style="max-height: 45px; "></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse header-navbar">
                <form class="navbar-form navbar-left" role="search" action="search" method="post" target="_blank">
                    <div class="form-group">
                        <input type="text" class="form-control" name="keyword" required="true" placeholder="回车搜索">
                    </div>
                </form>
            <ul class="nav navbar-nav navbar-right">
            	<c:if test="${!empty current_user }">
            		<li>
            			<img alt="BBS" src="${current_user.iconUrl }" style="max-height: 45px; ">
            		</li>
                    <li>
                        <a href="user/info">
                        	<span>${current_user.username }</span>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        		    设置
                            <span class="caret"></span>
                        </a>
                        <span class="dropdown-arrow"></span>
                        <ul class="dropdown-menu">
                            <li><a href="user/info">个人资料</a></li>
                            <li class="divider"></li>
                            <li><a href="user/edit">修改密码</a></li>
                            <li class="divider"></li>
                            <c:forEach items="${roles }" var="role">
								<c:if test="${role.name eq '系统管理员'}">
								<li><a href="admin/user">管理员设置</a></li>
                           		<li class="divider"></li>
								</c:if>
							</c:forEach>
                            <li><a href="logout">退出</a></li>
                        </ul>
                    </li>
            	</c:if>
            	<c:if test="${empty current_user }">
                    <li>
                        <a href="login.jsp">登录</a>
                    </li>
                    <li>
                        <a href="register.jsp">注册</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>