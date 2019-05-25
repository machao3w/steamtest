<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<nav class="navbar navbar-inverse" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Steam商店</a>
		</div>
		<div id="navbar">
			<ul class="nav navbar-nav navbar-right">
			<shiro:notAuthenticated>
				<li><a href="${APP_PATH}/user/loginPage" id="login">登录</a></li>
				<li><a href="${APP_PATH}/user/registerPage" id="register">注册</a></li>
			</shiro:notAuthenticated>
			<shiro:authenticated>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">欢迎登录 <span class="hidden-xs">${user.nickName}</span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="#" class="btn btn-default btn-flat">个人中心</a></li>
						<li><a href="#" class="btn btn-default btn-flat">修改密码</a></li>
						<li><a href="/user/logOut" class="btn btn-default btn-flat">注销</a></li>
					</ul></li>
			</shiro:authenticated>
			</ul>
			<form class="navbar-form navbar-right">
				<input type="text" class="form-control" placeholder="Search...">
			</form>
		</div>
	</div>
</nav>