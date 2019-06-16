package com.machao.steamshop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.machao.steamshop.bean.Cart;
import com.machao.steamshop.bean.UserNew;
import com.machao.steamshop.dao.CartMapper;

@Service
public class CartService {

	@Autowired
	CartMapper cartMapper;

	public void putCart(Model model, Integer gameId, Integer quantity, HttpSession session) {
		Map<String, Object> cartItem = new HashMap<String, Object>(); 
		UserNew user = (UserNew) session.getAttribute("user");
		cartItem.put("buyer_id", user.getUserId());
		cartItem.put("game_id", gameId);
		cartItem.put("quantity", quantity);
		List<Map<String, Object>> list = cartMapper.isPutCart(cartItem);
		if(list.size() > 0) {
			cartMapper.updateCart(cartItem);
		}else {
			cartMapper.putCart(cartItem);
		}
	}

	
	public List<Cart> getCartItems(Model model, HttpSession session) { 
		UserNew user = (UserNew) session.getAttribute("user");
		Integer userId = user.getUserId(); 
		return cartMapper.selectByUserId(userId); 
	
	}
	
	public void resetCartQuantity(Model model, Integer gameId, Integer quantity, HttpSession session) {
		Map<String, Object> cartItem = new HashMap<String, Object>(); 
		UserNew user = (UserNew) session.getAttribute("user");
		cartItem.put("buyer_id", user.getUserId());
		cartItem.put("game_id", gameId);
		cartItem.put("quantity", quantity);
		cartMapper.resetCartQuantity(cartItem);
	}


	public void deleteCartItem(Integer gameId, HttpSession session) {
		Map<String, Object> cartItem = new HashMap<String, Object>();
		UserNew user = (UserNew) session.getAttribute("user");
		cartItem.put("buyer_id", user.getUserId());
		cartItem.put("game_id", gameId);
		cartMapper.deleteByGameId(cartItem);
	}


	public void deleteAll(HttpSession session) {
		UserNew user = (UserNew) session.getAttribute("user");
		cartMapper.deleteByBuyerId(user.getUserId());
	}


}
