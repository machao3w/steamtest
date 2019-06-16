package com.machao.steamshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.machao.steamshop.bean.Cart;
import com.machao.steamshop.bean.Msg;
import com.machao.steamshop.bean.Order;
import com.machao.steamshop.service.CartService;

@Controller
@RequestMapping("/cart")
public class CartController {

	@Autowired
	CartService cartService;

	@RequestMapping("/add/success")
	public String success() {
		return "front/success";
	}

	@ResponseBody
	@RequestMapping(value="/add/{gameId}/{quantity}",method=RequestMethod.GET)
	public Msg putCart(@PathVariable Map<String, String> map,Model model, HttpSession session) {
		Integer gameId = Integer.valueOf(map.get("gameId"));
		Integer quantity = Integer.valueOf(map.get("quantity"));
		cartService.putCart(model, gameId, quantity, session);
		return Msg.success();
	}
	
	
	@RequestMapping("/cartList")
	public String toCart(Model model, HttpSession session) {
		return "front/cart";
	}
	
	
	@ResponseBody
	@RequestMapping("/cartList0")
	public Msg showCart(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum, Model model, HttpSession session) {
		PageHelper.startPage(pageNum,5);
		List<Cart> cartList = cartService.getCartItems(model,session);
		PageInfo page = new PageInfo(cartList,5);
		double totalprice = 0;
		double totalnum = 0;
		for(Cart item : cartList) {
			totalnum = totalnum + item.getQuantity();
			totalprice = totalprice + item.getQuantity() * item.getGame().getGamePrice();
		}
		Map<String,Object> totalInfo = new HashMap<String,Object>();
		totalInfo.put("totalnum", totalnum);
		totalInfo.put("totalprice", totalprice);
		totalInfo.put("pageInfo", page);
		return Msg.success().add("totalInfo", totalInfo);
	}
	
	@ResponseBody
	@RequestMapping(value="/cartList", method=RequestMethod.PUT)
	public Msg updateCart(Cart cart, HttpSession session, Model model,HttpServletRequest request) {
		System.out.println("gameId="+request.getParameter("gameId"));
		//System.out.println("quantity="+quantity);
		cartService.resetCartQuantity(model, cart.getGameId(), cart.getQuantity(), session);
		List<Cart> cartList = cartService.getCartItems(model,session);
		double totalprice = 0;
		double totalnum = 0;
		for(Cart item : cartList) {
			totalnum = totalnum + item.getQuantity();
			totalprice = totalprice + item.getQuantity() * item.getGame().getGamePrice();
		}
		Map<String,Double> totalInfo = new HashMap<String,Double>();
		totalInfo.put("totalnum", totalnum);
		totalInfo.put("totalprice", totalprice);
		return Msg.success().add("totalInfo", totalInfo);
	}
	
	@ResponseBody
	@RequestMapping(value="/cartList/{gameId}", method=RequestMethod.DELETE)
	public Msg deleteCartItem(@PathVariable("gameId")Integer gameId, HttpSession session) {
		cartService.deleteCartItem(gameId,session);
		return Msg.success();
	}
	
	@RequestMapping(value="/clearAll", method=RequestMethod.DELETE)
	public Msg deleteAll(HttpSession session) {
		cartService.deleteAll(session);
		return Msg.success();
	}
}
