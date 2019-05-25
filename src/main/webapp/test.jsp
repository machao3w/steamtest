<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>

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
				<div class="panel panel-success">
					<div class="panel-heading">
						<ol class="breadcrumb">
							<li><a href="#">游戏列表</a></li>
							<li class="active">选购</li>
						</ol>
					</div>
					<div class="panel-body">
						<div class="col-md-4">
							<button class="btn btn-primary" id="game_add">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>加入购物车
							</button>
						</div>
					</div>
					<table class="table table-hover" id="game_tabe">
						<thead>
							<tr class="tr1">
								<td>游戏名</td>
								<td>价格</td>
								<td>分类</td>
								<td>购买数量</td>
								<td>操作</td>
							</tr>
						</thead>
						<tbody>
						
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	to_page(1);
});

function to_page(pn){
	$.ajax({
		url:"${APP_PATH}/gameList",
		data:"pageNum="+pn,
		type:"GET",
		success:function(result){
		//console.log(result);
			build_game_table(result);
			build_page_nav(result);
			build_page_info(result);
		}
	});
}

function build_game_table(result){
	//清空内容
	$("#game_tabe tbody").empty();
	var games = result.extend.pageInfo.list;
	$.each(games,function(index,item){
		var gamename = $("<td></td>").append(item.gameName);
		var gameprice = $("<td></td>").append(item.gamePrice);
		var gamegenres = $("<td></td>").append(item.genres.className);
		var buynum = $("<input>").addClass("quantity").val("1");
		var delBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
		.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("删除");
		delBtn.attr("edit_id",item.gameId);
		var inputTd = $("<td></td>").append(buynum)
		var btnTd = $("<td></td>").append(delBtn);
		//返回元素
		$("<tr></tr>")
		.append(gamename)
		.append(gameprice)
		.append(gamegenres)
		.append(inputTd)
		.append(btnTd)
		.appendTo("#game_tabe tbody");
	});
}
</script>



</html>
