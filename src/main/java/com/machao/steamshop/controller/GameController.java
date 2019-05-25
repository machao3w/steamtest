package com.machao.steamshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.machao.steamshop.bean.Game;
import com.machao.steamshop.bean.Msg;
import com.machao.steamshop.service.GameService;

@Controller
public class GameController {
	
	@Autowired
	GameService gameService;
	
	@RequestMapping("/gameIndex")
	public String toIndex() {
		return "front/GameList";
	}
	
	@RequestMapping("/gameList")
	@ResponseBody
	public Msg getGamesWithJson(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum, Model model) {
		PageHelper.startPage(pageNum,5);
		List<Game> gameList = gameService.getAll();
		PageInfo page = new PageInfo(gameList,5);
		return Msg.success().add("pageInfo", page);
	
	}
	
	@RequestMapping("/gameList0")
	public String getGames(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum, Model model) {
		//引入pageHelper,传入页码和显示条数
		PageHelper.startPage(pageNum,5);
		List<Game> gameList = gameService.getAll();
		PageInfo page = new PageInfo(gameList,5);
		model.addAttribute("pageInfo", page);
		return "GameList";
		
	}
	
	@RequestMapping(value="/gameList", method=RequestMethod.POST)
	@ResponseBody
	public Msg addGame(Game game) {
		gameService.addGame(game);
		return Msg.success();
	}
	
	//检查游戏名是否可用
	@ResponseBody
	@RequestMapping("/checkgame")
	public Msg checkgame(@RequestParam("gameName")String gameName) {
		boolean g = gameService.checkgame(gameName);
		if(g) {
			return Msg.success();
		}else {
			return Msg.fail();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/gameList/{gameId}",method=RequestMethod.GET)
	public Msg getGame(@PathVariable("gameId")Integer gameId) {
		Game game = gameService.getGame(gameId);
		return Msg.success().add("game", game);
	}
	
	@ResponseBody
	@RequestMapping(value="/gameList/{gameId}",method=RequestMethod.PUT)
	public Msg updateGame(Game game,HttpServletRequest request) {
		System.out.println("请求体中的至"+request.getParameter("gameName"));
		System.out.println("更新的game"+game);
		gameService.updateGame(game);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value="/gameList/{gameId}",method=RequestMethod.DELETE)
	public Msg deleteGame(@PathVariable("gameId")Integer gameId) {
		gameService.deleteGame(gameId);
		return Msg.success();
	}
}
