<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>

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
</head>
<body>
	<!-- 添加顶部导航栏 -->
	<%@ include file="/WEB-INF/pages/common/nav_head.jsp"%>
	<div class="container-fluid">
		<div class="test">
			<!-- 添加左侧导航栏 -->
			<%@ include file="/WEB-INF/pages/common/nav_left.jsp"%>
			<div class="col-md-10">
				<h2>确认并补充收货信息</h2>
				<form id="orderForm" action="${APP_PATH}/order/creation" method="post">
					<div class="row">
						<div class="form-group col-md-6">
							<label for="account_input" class="col-sm-4 control-label">您的账号id：</label>
							<input type="text" name="accountId" class="form-control"
								id="account_input"> <span class="help-block"></span>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-6">
							<label for="phonenum_input" class="col-sm-4 control-label">您的联系方式：</label>
							<input type="text" name="phoneNum" class="form-control"
								id="phonenum_input"> <span class="help-block"></span>
						</div>
					</div>
					<button class="btn btn-success" id="order-submit">提交订单</button>
				</form>
				
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$("#order-submit").click(function() {
		var phoneNum = $("#phonenum_input").val();
		//检验电话
		var regnickname = /(^[a-zA-Z0-9_-]{11}$)/;
		if (!regnickname.test(phoneNum)) {
			$("#phonenum_input").parent().removeClass("has-success has-error");
			$("#phonenum_input").next("span").text("");
			$("#phonenum_input").parent().addClass("has-error");
			$("#phonenum_input").next("span").text("接收电话不符合格式");
			return false;
		} else {
			$("#phonenum_input").parent().removeClass("has-success has-error");
			$("#phonenum_input").next("span").text("");
			//$("#game_class_select").empty();
			//show_validate_msg("#game_price_input", "success", "");
			$("#phonenum_input").parent().addClass("has-success");
			$("#phonenum_input").next("span").text("");
		}
		$('#orderForm').submit();
	});

	/* $("#order-submit").click(function() {
		//alert($("#orderForm").serialize());
		if (!validate_phonenum()) {
			return false;
		}
		$.ajax({
			url:"${APP_PATH}/order/creation",
			type:"POST",
			data:$("#orderForm").serialize(),
			success:function(result){
			}
		});
		success();
	}); */
	
	/* function success(){
		$("#orderForm").remove();
		$("h2").html("提交成功");
	} */
</script>
</html>