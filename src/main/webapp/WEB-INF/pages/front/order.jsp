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
	<div class="modal fade bs-example-modal-lg" id="orderDetailModal" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<table class="table table-hover" id="orderdetail_tabe">
					<thead class="modal-title">
						<tr class="tr1">
							<td>游戏名</td>
							<td>图标</td>
							<td>价格</td>
							<td>分类</td>
							<td>购买数量</td>
							<td>订单号</td>
						</tr>
					</thead>
					<tbody class="modal-body">

					</tbody>
				</table>
			</div>
		</div>
	</div>
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
							<li><a href="#">订单列表</a></li>
						</ol>
					</div>
					<div class="panel-body">
						<table class="table table-hover" id="order_tabe">
						<thead>
							<tr class="tr1">
								<td>订单编号</td>
								<td>订单情况</td>
								<td>总价</td>
								<td>下单时间</td>
								<td>用户账号</td>
								<td>联系方式</td>
								<td>操作</td>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
					</div>
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
</body>
<script type="text/javascript">
	$(function() {
		to_page(1);
	});

	function to_page(pn) {
		$.ajax({
			url : "${APP_PATH}/order/orderList",
			data : "pageNum=" + pn,
			type : "GET",
			success : function(result) {
				//console.log(result);
				build_order_table(result);
				build_page_nav(result);
				build_page_info(result);
			}
		});
	}

	function build_order_table(result) {
		//清空内容
		$("#order_tabe tbody").empty();
		var orders = result.extend.pageInfo.list;
		$.each(orders, function(index, item) {
			var orderId = $("<td></td>").append(item.orderId);
			var orderStatus = $("<td></td>").append(item.orderStatus);
			var totalPrice = $("<td></td>").append(item.totalPrice);
			var orderDate = $("<td></td>").append(item.orderDate);
			var accountId = $("<td></td>").append(item.accountId);
			var phoneNum = $("<td></td>").append(item.phoneNum);
			var showBtn = $("<button></button>").addClass(
					"btn btn-primary btn-sm showBtn").append(
					$("<span></span>").addClass("glyphicon glyphicon-pencil"))
					.append("查看详细");
			showBtn.attr("order_id", item.orderId).attr("buyer_id",
					item.buyerId);
			var btnTd = $("<td></td>").append(showBtn);
			//返回元素
			$("<tr></tr>").append(orderId).append(orderStatus).append(
					totalPrice).append(orderDate).append(accountId).append(
					phoneNum).append(btnTd).appendTo("#order_tabe tbody");
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

	$(document).on("click",".showBtn",function() {
		getOrderDetail($(this).attr("order_id"),$(this).attr("buyer_id"));
		$("#orderDetailModal").modal({
			backdrop:"static"
		});
	})
	
	function buil_orderdetail_table(result){
		$("#orderdetail_tabe tbody").empty();
		var orderDetail = result.extend.orderDetailList;
		$.each(orderDetail, function(index, item) {
			var gamename = $("<td></td>").append(item.game.gameName);
			var gamepic = $("<img>").attr("src","${APP_PATH}/static/" + item.game.gamePic).attr("style","width: 80px;height: 80px;");
			var gameprice = $("<td></td>").append(item.game.gamePrice);
			var gamegenres = $("<td></td>").append(item.game.genres.className);
			var buynum = $("<td></td>").append(item.quantity);
			var orderId = $("<td></td>").append(item.orderId);
			var picTd = $("<td></td>").append(gamepic);
			$("<tr></tr>").append(gamename).append(picTd).append(gameprice)
			.append(gamegenres).append(buynum).append(orderId).appendTo(
					"#orderdetail_tabe tbody");
		})
	}
	
	function getOrderDetail(orderId,buyerId) {
		$.ajax({
			url:"${APP_PATH}/order/orderList/"+orderId,
			type:"GET",
			success : function(result) {
				buil_orderdetail_table(result);
				
			}
		});
	}
</script>



</html>

