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
		
		//��������genres��Ϣ
		
		@RequestMapping("/genres")
		@ResponseBody
		public Msg getGenres() {
			//�õ�genres��list
			List<Genres> list = genresService.getGenres();
			return Msg.success().add("genres",list);
		}
}
