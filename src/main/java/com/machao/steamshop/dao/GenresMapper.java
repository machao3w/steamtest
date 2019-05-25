package com.machao.steamshop.dao;

import com.machao.steamshop.bean.Genres;
import com.machao.steamshop.bean.GenresExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface GenresMapper {
    long countByExample(GenresExample example);

    int deleteByExample(GenresExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Genres record);

    int insertSelective(Genres record);

    List<Genres> selectByExample(GenresExample example);

    Genres selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Genres record, @Param("example") GenresExample example);

    int updateByExample(@Param("record") Genres record, @Param("example") GenresExample example);

    int updateByPrimaryKeySelective(Genres record);

    int updateByPrimaryKey(Genres record);
}