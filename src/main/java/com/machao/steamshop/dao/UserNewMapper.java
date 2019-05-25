package com.machao.steamshop.dao;

import com.machao.steamshop.bean.UserNew;
import com.machao.steamshop.bean.UserNewExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserNewMapper {
    long countByExample(UserNewExample example);

    int deleteByExample(UserNewExample example);

    int insert(UserNew record);

    int insertSelective(UserNew record);

    List<UserNew> selectByExample(UserNewExample example);

    int updateByExampleSelective(@Param("record") UserNew record, @Param("example") UserNewExample example);

    int updateByExample(@Param("record") UserNew record, @Param("example") UserNewExample example);
    
    List<UserNew> getAllUserRoleUser();
    
    List<UserNew> getAllUserRoleAdmin();
    
    public UserNew selectByPrimary(int id);
    
    UserNew selectByUsername(String userName);
    
    List<String> getRoles(String userName);
    
    long checkUser(String userName);
    
    int saveUser(UserNew user);
    
    int setUserRole(int userId);
    
    List<UserNew> selectUserWithRoleByUserName(String userName);
}