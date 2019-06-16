<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="col-md-2">
	<ul class="nav nav-sidebar">
		<shiro:hasAnyRoles name="customer">
		<li><a href="${APP_PATH}/cart/cartList">我的购物车</a></li>
		<li><a href="${APP_PATH}/order/orderList0">我的订单</a></li>
		</shiro:hasAnyRoles>
		<shiro:hasRole name="admin">
		<li><a href="#">游戏管理</a></li>
		</shiro:hasRole>
	</ul>
</div>
<script>
	
</script>