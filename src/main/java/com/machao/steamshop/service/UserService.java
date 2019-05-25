package com.machao.steamshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.machao.steamshop.bean.Role;
import com.machao.steamshop.bean.UserNew;
import com.machao.steamshop.dao.UserNewMapper;

@Service
public class UserService {
	
	@Autowired
	private UserNewMapper userNewMapper;
	
	public UserNew selectByUsername(String userName) {
		// TODO Auto-generated method stub
		return userNewMapper.selectByUsername(userName);
	}

	public List<String> getRoles(String userName) {
		// TODO Auto-generated method stub
		return userNewMapper.getRoles(userName);
	}

}
