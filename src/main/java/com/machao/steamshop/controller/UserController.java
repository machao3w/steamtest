package com.machao.steamshop.controller;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.machao.steamshop.bean.UserNew;
import com.machao.steamshop.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	//进入登录页面
	@RequestMapping("/loginPage")
	public String LoginPage() {
		return "login";
	}
	
	@RequestMapping("/login")
	public String test(String userName, String passWord, Model model, HttpSession session) {
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(userName, passWord);
		try {
			subject.login(token);
		} catch (AuthenticationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "login";
		}
		UserNew loginUser = userService.selectByUsername(userName);
		session.setAttribute("user", loginUser);
		return "redirect:/gameIndex";
	}
	
	//登出
	
	
	//注册
	public String register() {
		return "Register";
	}
	
	
}
