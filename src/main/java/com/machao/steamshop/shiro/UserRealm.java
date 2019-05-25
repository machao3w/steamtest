package com.machao.steamshop.shiro;

import java.util.HashSet;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.machao.steamshop.bean.UserNew;
import com.machao.steamshop.service.UserService;

public class UserRealm extends AuthorizingRealm {
	
	@Autowired
	private UserService userService;
	@Override
	public void setName(String name) {
		// TODO Auto-generated method stub
		super.setName("myRealm");
	}

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String userName = (String) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo simpleAuthorization = new SimpleAuthorizationInfo();
		Set<String> roles = new HashSet<String>(userService.getRoles(userName));
		simpleAuthorization.setRoles(roles);
		return simpleAuthorization;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String userName = (String) token.getPrincipal();
		UserNew user = userService.selectByUsername(userName);
		if(user == null) {
			throw new UnknownAccountException("’Àªß≤ª¥Ê‘⁄£°");
		}
		SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(user.getUserName(), user.getUserPassword(), this.getName());
		return simpleAuthenticationInfo;
	}
}
