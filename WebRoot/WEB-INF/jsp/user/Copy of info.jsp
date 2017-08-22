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
</head>
<body>
	<div class="wrapper">

		<%@include file="../common/head.jsp"%>

		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div class="panel panel-default">
						<div class="panel-heading">
							个人资料
						</div>
						<div class="panel-body">
							<h2 style="color: red;">${msg }</h2>
							<form enctype="multipart/form-data" method="post" action="user/head">
								<div class="form-group">
									<label for="head">上传头像</label> <br>
									<img id="img" alt="头像" src="${current_user.iconUrl }" style="height:120px;width:120px;">
									<input id="file" type="file" accept="image/*" name="file">
								</div>
								<script  type="text/javascript">
									var input = document.getElementById('file');
									var img = document.getElementById('img');
									input.addEventListener('change',function(evt){
										var target = evt.target;
										var src = window.URL.createObjectURL(target.files[0]);
										img.src = src;
									});
									$('#ff').form({   
										url:'user/head', 
									    onSubmit: function(){    
									    },    
									    success:function(data){  
									    	var msg='';  
									    	if(data=='true'){
									    		msg="恭喜您！上传头像成功！";
									    		$.messager.alert('警告',msg,'info'); 
									    	}else{
									    		msg="上传头像失败！请与管理员联系！";
									    		$.messager.alert('警告',msg,'warning');   
									    	}
									         
									    }    
									}); 
								</script>
								<div class="form-group">
									<label for="用户名">用户名</label>
									<input type="text"
										class="form-control" disabled="true" name="" placeholder="" value="${current_user.username }">
								</div>
								<div class="form-group">
									<label for="title">邮箱</label> 
										<input type="text"
										class="form-control" disabled="true" name="" placeholder="" value="${current_user.email }">
								</div>
								<input type="submit" class="btn btn-default" value="确认修改">
							</form>
							<div id="preview"></div>
						</div>
					</div>
				</div>
				<div class="col-md-3 hidden-sm hidden-xs hidden-sm hidden-xs">
					<div class="panel panel-default">
						<div class="panel-heading">
							<b> </b>
						</div>
						<div class="panel-body">
							<p> </p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@include file="../common/footer.jsp"%>

	</div>
</body>
</html>
