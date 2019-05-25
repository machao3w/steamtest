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
	<!-- 修改事件模态框 -->
	<div class="modal fade" id="gameupdatemodal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">修改游戏</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="game_name_input" class="col-sm-2 control-label">游戏名：</label>
							<input type="text" name="gameName" class="form-control" id="game_name_update">
							<span class="help-block"></span>
						</div>
						<div class="form-group">
							<label for="game_price_input" class="col-sm-2 control-label">价格：</label>
							<input type="text" name="gamePrice" class="form-control" id="game_price_update">
							<span class="help-block"></span>
						</div>
						<div class="form-group">
							<label for="game_genres_input" class="col-sm-2 control-label">分类：</label>
							<select class="form-control" name="gameClass" id="game_class_select_update">
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="game_update">更新</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 新增事件模态框 -->
	<div class="modal fade" id="gameaddmodal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">添加游戏</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="game_name_input" class="col-sm-2 control-label">游戏名：</label>
							<input type="text" name="gameName" class="form-control" id="game_name_input">
							<span class="help-block"></span>
						</div>
						<div class="form-group">
							<label for="game_price_input" class="col-sm-2 control-label">价格：</label>
							<input type="text" name="gamePrice" class="form-control" id="game_price_input">
							<span class="help-block"></span>
						</div>
						<div class="form-group">
							<label for="game_genres_input" class="col-sm-2 control-label">分类：</label>
							<select class="form-control" name="gameClass" id="game_class_select">
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="game_save">保存</button>
				</div>
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
							<li><a href="#">游戏列表</a></li>
							<li class="active">管理</li>
						</ol>
					</div>
					<div class="panel-body">
						<div class="col-md-4">
							<button class="btn btn-primary" id="game_add">
								<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增游戏
							</button>
						</div>
					</div>
					<table class="table table-hover" id="game_tabe">
						<thead>
							<tr class="tr1">
								<td>游戏名</td>
								<td>价格</td>
								<td>分类</td>
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
			var gameprice = $("<td></td>").append(item.gamePrice);
			var gamegenres = $("<td></td>").append(item.genres.className);
			var editBtn = $("<button></button>").addClass(
					"btn btn-primary btn-sm edit_btn").append(
					$("<span></span>").addClass("glyphicon glyphicon-pencil"))
					.append("修改");
			editBtn.attr("edit_id", item.gameId);
			var delBtn = $("<button></button>").addClass(
					"btn btn-primary btn-sm edit_btn").append(
					$("<span></span>").addClass("glyphicon glyphicon-pencil"))
					.append("删除");
			delBtn.attr("edit_id", item.gameId);
			var btnTd = $("<td></td>").append(editBtn).append(" ").append(
					delBtn);
			//返回元素
			$("<tr></tr>").append(gamename).append(gameprice)
					.append(gamegenres).append(btnTd).appendTo(
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
	//清空表单样式及内容
	function reset_form(arg){
		$(arg)[0].reset();
		$(arg).find("*").removeClass("has-error has-success");
		$(arg).find(".help-block").text("");
	}

	//新增单机事件弹出模态框
	$("#game_add").click(function(){
		reset_form("#gameaddmodal form");
	    //发送ajax请求，查出部门信息，显示在下拉列表中
		getGenres("#gameaddmodal select");
		$("#gameaddmodal").modal({
			backdrop:"static"
		});
	});
	//发送AJAX请求，获取所有GameGenres信息 
	function getGenres(arg){
		$(arg).empty();
		$.ajax({
			url:"${APP_PATH}/genres",
			type:"GET",
			success:function(result){
				$.each(result.extend.genres,function(){
					var optionEle = $("<option></option>").append(this.className).attr("value",this.id);
					optionEle.appendTo(arg);
				});
			}
		});
	}
	//验证价格
	function validate_add_form(){
		var gamePrice = $("#game_price_input").val();
		var regPrice = /(^[1-9]\d*|0$)/;
		if(!regPrice.test(gamePrice)){
			$("#game_price_input").parent().removeClass("has-success has-error");
			$("#game_price_input").next("span").text("");
			$("#game_price_input").parent().addClass("has-error");
			$("#game_price_input").next("span").text("价格只为非负整数");
			return false;
		}else{
			$("#game_price_input").parent().removeClass("has-success has-error");
			$("#game_price_input").next("span").text("");
			$("#game_price_input").parent().addClass("has-success");
			$("#game_price_input").next("span").text("");
		}
		return true;
	}
	//校验游戏名是否重复
	$("#game_name_input").change(function(){
		var gameName = this.value;
		$.ajax({
			url:"${APP_PATH}/checkgame",
			data:"gameName"+gameName,
			type:"POST",
			success:function(result){
				alert(result.code);
				if(result.code==100){
					$("#game_name_input").parent().removeClass("has-success has-error");
					$("#game_name_input").next("span").text("");
					$("#game_name_input").parent().addClass("has-success");
					$("#game_name_input").next("span").text("游戏可添加");
				}else{
					alert(result.message);
					$("#game_name_input").parent().removeClass("has-success has-error");
					$("#game_name_input").next("span").text("");
					$("#game_name_input").parent().addClass("has-error");
					$("#game_name_input").next("span").text("游戏已存在");
				}
			}
		});
	});

	$("#game_save").click(function(){
		if(!validate_add_form()){
			return false;
		}
		
		$.ajax({
			url:"${APP_PATH}/gameList",
			type:"POST",
			data:$("#gameaddmodal form").serialize(),
			success:function(result){
				//alert(result.message);
				 if(result.code == 100){
					$("#gameaddmodal").modal('hide');
					to_page(totalRecord);
				}else{
					console.log(result);
					
				}
			}
		});
	});

	$(document).on("click",".edit_btn",function(){
		getGenres("#gameupdatemodal select");
		getGame($(this).attr("edit_id"));
		$("#game_update").attr("edit_id",$(this).attr("edit_id"));
		$("#gameupdatemodal").modal({
			backdrop:"static"
		});
	});

	function getGame(gameId){
		$.ajax({
			url:"${APP_PATH}/gameList/"+gameId,
			type:"GET",
			success:function(result){
				var gameData = result.extend.game;
				$("#game_name_update").val(gameData.gameName);
				$("#game_price_update").val(gameData.gamePrice);
				$("#gameupdatemodal select").val(gameData.gameClass);
			}
		});
	}

	$("#game_update").click(function(){
		var gamePrice = $("#game_price_update").val();
		var regPrice = /(^[1-9]\d*|0$)/;
		if(!regPrice.test(gamePrice)){
			$("#game_price_update").parent().removeClass("has-success has-error");
			$("#game_price_update").next("span").text("");
			//$("#game_class_select").empty();
			//show_validate_msg("#game_price_input","error","价格只为非负整数")；
			$("#game_price_update").parent().addClass("has-error");
			$("#game_price_update").next("span").text("价格只为非负整数");
			return false;
		}else{
			$("#game_price_update").parent().removeClass("has-success has-error");
			$("#game_price_update").next("span").text("");
			//$("#game_class_select").empty();
			//show_validate_msg("#game_price_input", "success", "");
			$("#game_price_update").parent().addClass("has-success");
			$("#game_price_update").next("span").text("");
		}
		
		$.ajax({
			url:"${APP_PATH}/gameList/"+$(this).attr("edit_id"),
			type:"PUT",
			data:$("#gameupdatemodal form").serialize(),
			success:function(result){
				alert(result.message);
				$("#gameupdatemodal").modal("hide");
				to_page(currentPage);
			}
		});
	});
	
	$(document).on("click",".del_btn",function(){
		var gameName = $(this).parents("tr").find("td:eq(0)").text();
		//alert($(this).parents("tr").find("td:eq(0)").text());
		var gameId = $(this).attr("del_id");
		if(confirm("确认删除【"+gameName+"】?")){
			$.ajax({
				url:"${APP_PATH}/gameList/"+gameId,
				type:"DELETE",
				success:function(result){
					alert(result.message);
					to_page(currentPage);
				}
			});
		}
		
	});
</script>



</html>
