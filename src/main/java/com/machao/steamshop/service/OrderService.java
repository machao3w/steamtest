package com.machao.steamshop.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.machao.steamshop.bean.Cart;
import com.machao.steamshop.bean.Game;
import com.machao.steamshop.bean.Order;
import com.machao.steamshop.bean.OrderDetail;
import com.machao.steamshop.bean.UserNew;
import com.machao.steamshop.dao.CartMapper;
import com.machao.steamshop.dao.OrderDetailMapper;
import com.machao.steamshop.dao.OrderMapper;

@Service
public class OrderService {
	
	@Autowired
	OrderMapper orderMapper;
	
	@Autowired
	OrderDetailMapper orderDetailMapper;
	
	@Autowired
	CartMapper cartMapper;
	
	public void creatOrder(Order order, Model model, HttpSession session) {
		String orderId = new Date().getTime() + UUID.randomUUID().toString().substring(0, 5);
		UserNew user = (UserNew) session.getAttribute("user");
		List<Cart> cartList = cartMapper.selectByUserId(user.getUserId());
		order.setOrderId(orderId);
		order.setBuyerId(user.getUserId());
		order.setOrderStatus(0);
		Integer totalprice = 0;
		for(Cart item : cartList) {
			totalprice = totalprice + item.getQuantity() * item.getGame().getGamePrice();
		}
		order.setTotalPrice(totalprice);
		orderMapper.insert(order);
		for(Cart item : cartList) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrderId(orderId);
			orderDetail.setGameId(item.getGameId());
			orderDetail.setQuantity(item.getQuantity());
			orderDetailMapper.insert(orderDetail);
		}
	}

	public List<Order> getAllOrder(HttpSession session) {
		UserNew user = (UserNew) session.getAttribute("user");
		return orderMapper.selectByUserId(user.getUserId());
		
	}

	public List<OrderDetail> getAllOrderDetail(String orderId) {
		// TODO Auto-generated method stub
		List<OrderDetail> OrderDetailList = orderMapper.selectByOrderIdForDetail(orderId).getOrderDetails();
		return OrderDetailList;
	}

}
