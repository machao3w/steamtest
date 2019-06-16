package com.machao.steamshop.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.machao.steamshop.bean.Msg;
import com.machao.steamshop.bean.Order;
import com.machao.steamshop.bean.OrderDetail;
import com.machao.steamshop.service.CartService;
import com.machao.steamshop.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	CartService cartService;
	
	@Autowired
	OrderService orderService;
	
	@RequestMapping("/confirm")
	public String confirm() {
		return "front/confirm";
	}
	
	
	@RequestMapping(value="/creation", method=RequestMethod.POST)
	public String creatOrder(Order order, Model model, HttpSession session) {
		orderService.creatOrder(order, model, session);
		cartService.deleteAll(session);
		return "redirect:/gameIndex";
	}
	
	@RequestMapping("/orderList0")
	public String showOrder() {
		return "front/order";
	}
	
	@ResponseBody
	@RequestMapping("/orderList")
	public Msg getOrder(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum, Model model, HttpSession session) {
		PageHelper.startPage(pageNum,5);
		List<Order> orderList = orderService.getAllOrder(session);
		PageInfo page = new PageInfo(orderList,5);
		return Msg.success().add("pageInfo", page);
	}
	
	@ResponseBody
	@RequestMapping(value="/orderList/{orderId}",method=RequestMethod.GET)
	public Msg getOrderDetail(@PathVariable("orderId")String orderId, Model model) {
		List<OrderDetail> orderDetailList = orderService.getAllOrderDetail(orderId);
		return Msg.success().add("orderDetailList", orderDetailList);
	}
	
}
