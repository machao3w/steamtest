# SSM+Shiro+Bootstrap 模拟steam商城
采用的主要框架为 Spring + SpringMVC + Mybatis + shiro +Bootstrap。
本电商系统主要基于SSM搭建，页面为JSP页面，boostrap作为基础，pagehelp作为分页插件。

## 依赖
依赖|版本
---|---
Spring|4.3.17
Spring MVC|4.3.17
Mybatis|3.4.6
PageHelp 分页插件|5.0.0
c3p0 数据源|0.9.5.2
Shiro|1.4.0
Mybatis逆向工程|1.3.7

# 表设计
## 商品表
```
'CREATE TABLE `games_new` (
  `game_id` int(11) NOT NULL AUTO_INCREMENT,
  `game_name` varchar(225) DEFAULT NULL,
  `game_price` int(11) DEFAULT NULL,
  `game_class` int(11) DEFAULT NULL,
  `game_pic` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  KEY `id_idx` (`game_class`),
  CONSTRAINT `fk_class_id` FOREIGN KEY (`game_class`) REFERENCES `game_genres` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8'
```
## 商品分类表
```
'CREATE TABLE `game_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(225) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8'
```
## 用户表
```
'CREATE TABLE `user1` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `nick_name` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'
```
## 权限表
```
'CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'
```
## 用户权限关系表
```
'CREATE TABLE `user_role` (
  `ur_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` int(11) NOT NULL,
  `r_id` int(11) NOT NULL,
  PRIMARY KEY (`ur_id`),
  KEY `r_id` (`r_id`),
  KEY `u_id` (`u_id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`r_id`) REFERENCES `roles` (`role_id`),
  CONSTRAINT `user_role_ibfk_3` FOREIGN KEY (`u_id`) REFERENCES `user1` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'
```
## 购物车表
```
'CREATE TABLE `carts` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT,
  `buyer_id` int(11) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `fk_buyerid` (`buyer_id`),
  KEY `fk_gameid` (`game_id`),
  CONSTRAINT `fk_buyerid` FOREIGN KEY (`buyer_id`) REFERENCES `user1` (`user_id`),
  CONSTRAINT `fk_gameid` FOREIGN KEY (`game_id`) REFERENCES `games_new` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'
```
## 订单表
```
'CREATE TABLE `orders` (
  `order_id` varchar(255) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `order_status` int(11) NOT NULL,
  `total_price` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `account_id` varchar(255) NOT NULL,
  `phone_num` varchar(255) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_buyerid1` (`buyer_id`),
  CONSTRAINT `fk_buyerid1` FOREIGN KEY (`buyer_id`) REFERENCES `user1` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'
```

## 订单详情表
```
'CREATE TABLE `order_detail` (
  `od_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) NOT NULL,
  `game_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`od_id`),
  KEY `fk_orderid` (`order_id`),
  CONSTRAINT `fk_orderid` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'
```
# 插件
## mybatis逆向工程
用于快速生成开发中不断重复的代码，比如说实体类，映射层接口，以及Mybatis XML文件的编写，只需要提供数据库连接的jar地址，数据库名称，账号密码即可一键生成：实体类，Mapper接口，Mapper映射文件。
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>

	<context id="DB2Tables" targetRuntime="MyBatis3">
		<commentGenerator>
			<property name="suppressAllComments" value="true" />
		</commentGenerator>
		<jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
			connectionURL="jdbc:mysql://localhost/steam?useUnicode=true&amp;characterEncoding=UTF-8&amp;serverTimezone=UTC"
			userId="root" password="123456">
		</jdbcConnection>

		<javaTypeResolver>
			<property name="forceBigDecimals" value="false" />
		</javaTypeResolver>

		<!-- 指定javaBean生成的位置 -->
		<javaModelGenerator targetPackage="com.machao.steamshop.bean"
			targetProject=".\src\main\java">
			<property name="enableSubPackages" value="true" />
			<property name="trimStrings" value="true" />
		</javaModelGenerator>

		<!-- 指定sql映射文件生成的文职 -->
		<sqlMapGenerator targetPackage="mapper"
			targetProject=".\src\main\resources">
			<property name="enableSubPackages" value="true" />
		</sqlMapGenerator>

		<!-- 指定dao接口生成的位置、mapper接口 -->
		<javaClientGenerator type="XMLMAPPER"
			targetPackage="com.machao.steamshop.dao" targetProject=".\src\main\java">
			<property name="enableSubPackages" value="true" />
		</javaClientGenerator>

		<!-- table指定每个表的生成策略 -->
    <table tableName="games_new" domainObjectName="Game"></table>
		<table tableName="game_genres" domainObjectName="Genres"></table>
		<table tableName="user1" domainObjectName="UserNew"></table>
		<table tableName="roles" domainObjectName="Role"></table>
		<table tableName="carts" domainObjectName="Cart"></table>
		<table tableName="orders" domainObjectName="Order"></table>
		<table tableName="order_detail" domainObjectName="OrderDetail"></table>
	</context>
</generatorConfiguration>
```
## 分页插件
最常用的分页插件pageInfo，用法就不赘述了。
```
<dependency>
			<groupId>com.github.pagehelper</groupId>
			<artifactId>pagehelper</artifactId>
			<version>5.0.0</version>
		</dependency>
```
# 权限管理框架shiro
shiro的主要功能就是认证与授权，由于我是基于角色授权，通过前端shiro标签过滤，所以整个认证授权过程十分简单。后期升级项目会考虑添加加盐加密以及记住我功能
## 自定义realm
```
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
			throw new UnknownAccountException("账户不存在！");
		}
		SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(user.getUserName(),
		user.getUserPassword(), this.getName());
		return simpleAuthenticationInfo;
	}
}
```
## 配制shiro
### web.xml
```
    <filter>
	<filter-name>shiroFilter</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
        <async-supported>true</async-supported>
        <init-param>
            <param-name>targetFilterLifecycle</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>shiroFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
```
### shiro在上下文应用的配制
```
<!-- 自定义logouturl -->
<bean id="logout" class="org.apache.shiro.web.filter.authc.LogoutFilter">
	<property name="redirectUrl" value="/user/loginPage"/>
</bean>
<bean id="shiroFilter" class="org.apache.shiro.spring.web.ShiroFilterFactoryBean">
<!-- Shiro的核心安全接口,这个属性是必须的 -->
        <property name="securityManager" ref="securityManager" />
        <!-- 认证提交地址，如果没有认证将返回此url，请求此地址将由formAuthenticationFilter进行认证 -->
        <property name="loginUrl" value="/user/loginPage" />    
        <property name="unauthorizedUrl" value="nopermission" /> <!--当没有权限的时候，跳转到这个url-->
        <!-- <property name="filters">
        	<map>
        		<entry key="logout" value-ref="logoutFilter"/>
        	</map>
        </property> -->
        <property name="filterChainDefinitions">
            <value>
            	<!-- 对静态资源设置匿名访问 -->
            	/logout = logout
            	/static/** = anon
            	/order/** = authc
            	/cart/** = authc
            	/gameAdmin/**=authc,roles["admin"]
            	/** = anon
            	
            </value>
	</property>
</bean>
	<!-- securityManeger  -->
<bean id="securityManager" class="org.apache.shiro.web.mgt.DefaultWebSecurityManager">
	<property name="realm" ref="myRealm"></property>
</bean>
<!-- realm -->
<bean id="myRealm" class="com.machao.steamshop.shiro.UserRealm">
</bean>
```
# 前台效果展示
## 主界面
![主界面](https://github.com/machao3w/steamtest/blob/master/images/%E5%89%8D%E5%8F%B01.jpg)
## 购物车界面，jquery动态计算总计和总数
![购物车界面，jquery动态计算总计和总数](https://github.com/machao3w/steamtest/blob/master/images/%E5%89%8D%E5%8F%B02.jpg)
## post请求，补充收货信息并删除购物车
![post请求，补充收货信息并删除购物车](https://github.com/machao3w/steamtest/blob/master/images/%E5%89%8D%E5%8F%B03.jpg)
## 订单界面以及订单详情
![订单界面以及订单详情](https://github.com/machao3w/steamtest/blob/master/images/%E5%89%8D%E5%8F%B05.jpg)
## admin界面
![admin界面](https://github.com/machao3w/steamtest/blob/master/images/%E5%90%8E%E5%8F%B01.jpg)

