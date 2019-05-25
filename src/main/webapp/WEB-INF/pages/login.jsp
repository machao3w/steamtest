<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<title>My JSP 'test.jsp' starting page</title>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style>
body {
	background: url("./static/img/1.jpg");
	animation-name: myfirst;
	animation-duration: 12s;
	/*变换时间*/
	animation-delay: 2s;
	/*动画开始时间*/
	animation-iteration-count: infinite;
	/*下一周期循环播放*/
	animation-play-state: running;
	/*动画开始运行*/
}

@keyframes myfirst { 
	0% {background: url("${APP_PATH }/static/img/1.jpg");}
	34%{background:url("${APP_PATH }/static/img/2.jpg");}
	67%{background:url("${APP_PATH }/static/img/3.jpeg");}
	100%{background:url("${APP_PATH }/static/img/1.jpg");}
}

.form {
	background: rgba(255, 255, 255, 0.2);
	width: 400px;
	margin: 120px auto;
}
/*阴影*/
.fa {
	display: inline-block;
	top: 27px;
	left: 6px;
	position: relative;
	color: #ccc;
}

input[type="text"], input[type="password"] {
	padding-left: 26px;
}

.checkbox {
	padding-left: 21px;
}
</style>
</head>

<body>
	<div class="container">
		<div class="form row">
			<div class="form-horizontal col-md-offset-3" id="login_form">
				<h3 class="form-title">登录界面</h3>
					<div class="col-md-9">
						<form action="${APP_PATH }/user/login" method="post">
						<div class="form-group">
							<i class="fa fa-user fa-lg"></i> <input
								class="form-control required" type="text" placeholder="Username"
								id="userName" name="userName" autofocus="autofocus"
								maxlength="20" />
						</div>
						<div class="form-group">
							<i class="fa fa-lock fa-lg"></i> <input
								class="form-control required" type="password"
								placeholder="Password" id="passWord" name="passWord"
								maxlength="8" />
						</div>
						<div class="form-group">
							<label class="checkbox"> <input type="checkbox"
								name="remember" value="1" />记住我
							</label>
						</div>
						<div class="form-group col-md-offset-9">
							<button type="submit" class="btn btn-success pull-right"
								name="submit">登录</button>
						</div>
						</form>
					</div>
				

			</div>
		</div>
	</div>
	<script type="text/javascript"></script>
</body>
</html>
