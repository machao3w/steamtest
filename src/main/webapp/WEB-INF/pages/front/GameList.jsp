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
				<div class="panel panel-success">
					<div class="panel-heading">
						<ol class="breadcrumb">
							<li><a href="#">游戏列表</a></li>
							<li class="active">选购</li>
						</ol>

					</div>
					<div class="panel-body">
						<!-- <div class="col-md-4">
							<button class="btn btn-primary" id="game_add">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>加入购物车
							</button>
						</div> -->
						<table class="table table-hover" id="game_tabe">
							<thead>
								<tr class="tr1">
									<td>游戏名</td>
									<td>图标</td>
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
				<div class="row">
					<div class="col-md-6 col-md-offset-4" id="page_nav"></div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-md-offset-4" " id="page_info"></div>
				</div>
			</div>

		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		to_page(1);
	});

	function to_page(pn) {
		$.ajax({
			url : "${APP_PATH}/gameList",
			data : "pageNum=" + pn,
			type : "GET",
			success : function(result) {
				//console.log(result);
				build_game_table(result);
				build_page_nav(result);
				build_page_info(result);
			}
		});
	}

	function build_game_table(result) {
		//清空内容
		$("#game_tabe tbody").empty();
		var games = result.extend.pageInfo.list;
		$.each(games, function(index, item) {
			var gamename = $("<td></td>").append(item.gameName);
			var gamepic = $("<img>").attr("src",
					"${APP_PATH}/static/" + item.gamePic).attr("style",
					"width: 80px;height: 80px;");
			var gameprice = $("<td></td>").append(item.gamePrice);
			var gamegenres = $("<td></td>").append(item.genres.className);
			var buynum = $("<input>").attr({
				id : "quantity",
				value : "1"
			});
			var addCartBtn = $("<button></button>").addClass(
					"btn btn-primary btn-sm addCartBtn").append(
					$("<span></span>").addClass("glyphicon glyphicon-pencil"))
					.append("加入购物车");
			//addCartBtn.attr({game_id:item.gameId,quantity:$("#quantity").val()});
			addCartBtn.attr("game_id", item.gameId);
			var picTd = $("<td></td>").append(gamepic);
			var inputTd = $("<td></td>").append(buynum)
			var btnTd = $("<td></td>").append(addCartBtn);
			//返回元素
			$("<tr></tr>").append(gamename).append(picTd).append(gameprice)
					.append(gamegenres).append(inputTd).append(btnTd).appendTo(
							"#game_tabe tbody");
		});
	}

	function build_page_info(result) {
		$("#page_info").empty();
		$("#page_info").append(
				"当前" + result.extend.pageInfo.pageNum + "页，总"
						+ result.extend.pageInfo.pages + "页，总"
						+ result.extend.pageInfo.total + "条记录");
		totalRecord = result.extend.pageInfo.pages;
		currentPage = result.extend.pageInfo.pageNum;
	}

	function build_page_nav(result) {
		$("#page_nav").empty();
		var ul = $("<ul></ul>").addClass("pagination");
		var firstPageLi = $("<li></li>").append(
				$("<a></a>").append("首页").attr("href", "#"));
		firstPageLi.click(function() {
			to_page(1);
		});
		if (result.extend.pageInfo.hasPreviousPage) {
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			prePageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum - 1);
			});
		}
		if (result.extend.pageInfo.hasNextPage) {
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			nextPageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum + 1);
			});
		}
		var lastPageLi = $("<li></li>").append(
				$("<a></a>").append("末页").attr("href", "#"));
		lastPageLi.click(function() {
			to_page(result.extend.pageInfo.pages);
		});
		ul.append(firstPageLi).append(prePageLi);
		$.each(result.extend.pageInfo.navigatepageNums, function(index, item) {
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if (result.extend.pageInfo.pageNum == item) {
				numLi.addClass("active");
			}
			numLi.click(function() {
				to_page(item);
			});
			ul.append(numLi);
		});
		ul.append(nextPageLi).append(lastPageLi);
		var navEle = $("<nav></nav>").append(ul);
		navEle.appendTo("#page_nav");
	}

	$(document).on(
			"click",
			".addCartBtn",
			function() {
				var gameId = $(this).attr("game_id");
				var quantity = $(this).parents("tr").find("td:eq(4)").find(
						"input").val();
				$.ajax({
					url : "${APP_PATH}/cart/add/" + gameId + "/" + quantity,
					type : "GET",
					success : function(result) {
						window.location.href = "${APP_PATH}/cart/add/success";
					}
				})

			})
</script>



</html>

