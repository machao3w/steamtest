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
				<div class="panel panel-success" >
					<div class="panel-heading" id="panel_head">
						<ol class="breadcrumb">
							<li><a href="#">购物车列表</a></li>
							<li class="active">选购</li>
						</ol>

					</div>
					<div class="panel-body" id="cart_panel">
						<div class="col-md-4">
							<button class="btn btn-primary" id="deleteall_btn">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>清空购物车
							</button>
						</div>
						<table class="table table-hover" id="cart_table">
						<thead>
							<tr class="tr1">
								<th>游戏名</th>
								<th>图标</th>
								<th>价格</th>
								<th>分类</th>
								<th>购买数量</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
					</div>
					
				</div>
				<div align="right">
					<p>
						共计<span id="totalNum" class="label label-danger">${totalnum}</span>件
						总价¥<span id="totalPrice" class="label label-danger">${totalprice}</span>
					</p>
					<button id="toOrder" class="btn btn-success">去付款</button>
				</div>
				<div class="row">
					<div class="col-md-6 col-md-offset-4" id="page_nav"></div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-md-offset-4" id="page_info"></div>
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
			url : "${APP_PATH}/cart/cartList0",
			data : "pageNum=" + pn,
			type : "GET",
			success : function(result) {
				//console.log(result);
				build_cart_table(result);
				build_page_nav(result);
				build_page_info(result);
				var totalInfo = result.extend.totalInfo;
				$("#totalNum").text(totalInfo.totalnum);
				$("#totalPrice").text(totalInfo.totalprice);
			}
		});
	}

	function build_cart_table(result) {
		//清空内容
		$("#cart_table tbody").empty();
		var orders = result.extend.totalInfo.pageInfo.list;
		$.each(orders, function(index, item) {
			var gamename = $("<td></td>").append(item.game.gameName);
			var gamepic = $("<img>").attr("src",
					"${APP_PATH}/static/" + item.game.gamePic).attr("style",
					"width: 80px;height: 80px;");
			var gameprice = $("<td></td>").append(item.game.gamePrice);
			var gamegenres = $("<td></td>").append(item.game.genres.className);
			var cartId = $("<input>").attr({
				"type" : "hidden",
				"name" : "cartId",
				"value" : item.cartId
			});
			var buyerId = $("<input>").attr({
				"type" : "hidden",
				"name" : "buyerId",
				"value" : item.buyerId
			});
			var gameId = $("<input>").attr({
				"type" : "hidden",
				"name" : "gameId",
				"value" : item.gameId
			});
			var buynum = $("<input>").addClass("quantity").attr({
				"name" : "quantity",
				"value" : item.quantity,
				"data-game_id" : item.gameId
			});
			var form = $("<form></form>").addClass("cartform").append(cartId)
					.append(buyerId).append(gameId).append(buynum);
			var delete_btn = $("<button></button>").addClass(
					"btn btn-warning btn-sm delete_btn").append(
					$("<span></span>").addClass("glyphicon glyphicon-trash"))
					.append("删除");
			delete_btn.attr("game_id", item.gameId);
			var picTd = $("<td></td>").append(gamepic);
			var btnTd = $("<td></td>").append(delete_btn);
			var inputTd = $("<td></td>").append(form);
			//返回元素
			$("<tr></tr>").append(gamename).append(picTd).append(gameprice)
					.append(gamegenres).append(inputTd).append(btnTd).appendTo(
							"#cart_table tbody");
		});
	}

	function build_page_info(result) {
		$("#page_info").empty();
		$("#page_info").append(
				"当前" + result.extend.totalInfo.pageInfo.pageNum + "页，总"
						+ result.extend.totalInfo.pageInfo.pages + "页，总"
						+ result.extend.totalInfo.pageInfo.total + "条记录");
		totalRecord = result.extend.totalInfo.pageInfo.pages;
		currentPage = result.extend.totalInfo.pageInfo.pageNum;
	}

	function build_page_nav(result) {
		$("#page_nav").empty();
		var ul = $("<ul></ul>").addClass("pagination");
		var firstPageLi = $("<li></li>").append(
				$("<a></a>").append("首页").attr("href", "#"));
		firstPageLi.click(function() {
			to_page(1);
		});
		if (result.extend.totalInfo.pageInfo.hasPreviousPage) {
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			prePageLi.click(function() {
				to_page(result.extend.totalInfo.pageInfo.pageNum - 1);
			});
		}
		if (result.extend.totalInfo.pageInfo.hasNextPage) {
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			nextPageLi.click(function() {
				to_page(result.extend.totalInfo.pageInfo.pageNum + 1);
			});
		}
		var lastPageLi = $("<li></li>").append(
				$("<a></a>").append("末页").attr("href", "#"));
		lastPageLi.click(function() {
			to_page(result.extend.totalInfo.pageInfo.pages);
		});
		ul.append(firstPageLi).append(prePageLi);
		$.each(result.extend.totalInfo.pageInfo.navigatepageNums, function(
				index, item) {
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if (result.extend.totalInfo.pageInfo.pageNum == item) {
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

	$(document).on("change", ".quantity", function() {
		var quantity = $(this).val();
		var gameId = $(this).attr("data-game_id");
		var cartform = $(this).parent("form");
		if (parseInt(quantity) > 0 && parseInt(quantity) < 100) {
			var change = confirm("确认修改商品数量为" + quantity + "吗？(请确保为数字，否则发生错误!");
			if (change = true) {
				$.ajax({
					url : "${APP_PATH}/cart/cartList/",
					type : "POST",
					/* date:"quantity="+quantity+"&_method=PUT", */
					/* date:{_method:"PUT",quantity:quantity}, */
					data : cartform.serialize() + "&_method=PUT",
					success : function(result) {
						var totalInfo = result.extend.totalInfo;
						$("#totalNum").text(totalInfo.totalnum);
						$("#totalPrice").text(totalInfo.totalprice);
					}
				})
			}
		} else {
			alert("请输入正确数字");
		}

	})

	$(document).on("click", ".delete_btn", function() {
		var gameId = $(this).attr("game_id");
		var gameName = $(this).parents("tr").find("td:eq(0)").text();
		var cartform = $(this).parents("tr").find("td:eq(4)").find("form");
		if (confirm("确认删除游戏【" + gameName + "】?")) {
			$.ajax({
				url : "${APP_PATH}/cart/cartList/" + gameId,
				type : "POST",
				data : "_method=DELETE",
				success : function(result) {
					to_page(1);
				}
			});
		}
		;
		/* var totalprice = 0;
		var totalnum =0;
		$('#cart_table tbody tr td:nth-child(3)').each(function(i){
			var price = parseInt($(this).text());
			$('tr td:nth-child(5)').each(function(j){
				if(i==j){
					var num = parseInt($(this).find("input:eq(3)").val());
					totalprice += price*num;
					totalnum += num;
				}
			})
		});
		$("#totalNum").text(totalnum);
		$("#totalPrice").text(totalprice); */
	})

	$("#deleteall_btn").click(function() {
		if (confirm("确认清空购物车?")) {
			$.ajax({
				url : "${APP_PATH}/cart/cartList",
				type : "POST",
				data : "_method=DELETE",
				success : function(result) {
					nocart();
				}
			});
		}
	})

	function nocart() {
		$("#cart_panel").remove();
		var panel_table = $("<div></div>").addClass("panel-body").append("<h3></h3>").append("购物车空空如也");
		$("#panel_head").after(panel_table);
	}

	$("#toOrder").click(function() {
		var totalPrice = $("#totalPrice").text();
		window.location.href = "${APP_PATH}/order/confirm";

	})
</script>



</html>
