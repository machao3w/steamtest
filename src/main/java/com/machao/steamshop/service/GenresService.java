package com.machao.steamshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.machao.steamshop.bean.Genres;
import com.machao.steamshop.dao.GenresMapper;

public class GenresService {
	@Autowired
	private GenresMapper genresMapper;
	public List<Genres> getGenres() {
		List<Genres> list = genresMapper.selectByExample(null);
		return list;
	}
}
