package com.machao.steamshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.machao.steamshop.bean.Genres;
import com.machao.steamshop.bean.Msg;
import com.machao.steamshop.service.GenresService;

public class GenresController {
	@Autowired
	private GenresService genresService;
		
		//返回所有genres信息
		
		@RequestMapping("/genres")
		@ResponseBody
		public Msg getGenres() {
			//得到genres的list
			List<Genres> list = genresService.getGenres();
			return Msg.success().add("genres",list);
		}
}
