package com.machao.steamshop.dao;

import com.machao.steamshop.bean.Cart;
import com.machao.steamshop.bean.CartExample;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface CartMapper {
    long countByExample(CartExample example);

    int deleteByExample(CartExample example);

    int deleteByPrimaryKey(Integer cartId);

    int insert(Cart record);

    int insertSelective(Cart record);

    List<Cart> selectByExample(CartExample example);

    Cart selectByPrimaryKey(Integer cartId);

    int updateByExampleSelective(@Param("record") Cart record, @Param("example") CartExample example);

    int updateByExample(@Param("record") Cart record, @Param("example") CartExample example);

    int updateByPrimaryKeySelective(Cart record);

    int updateByPrimaryKey(Cart record);
    
    List<Cart> selectByUserId(Integer userId);
    
    List<Map<String, Object>> isPutCart(Map<String, Object> cartItem);
    
    int updateCart(Map<String, Object> cartItem);
    
    int putCart(Map<String, Object> cartItem);
    
    int resetCartQuantity(Map<String, Object> cartItem);
    
    int deleteByBuyerId(Integer userId);
    
    int deleteByGameId(Map<String, Object> cartItem);
    
}