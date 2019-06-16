package com.machao.steamshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.machao.steamshop.bean.Game;
import com.machao.steamshop.bean.GameExample;
import com.machao.steamshop.bean.GameExample.Criteria;
import com.machao.steamshop.dao.GameMapper;

@Service
public class GameService {
	
	@Autowired
	GameMapper gameMapper;
	//查询所有游戏
	public List<Game> getAll() {
		// TODO Auto-generated method stub
		return gameMapper.selectByExampleAndGenres(null);
	}
	public void addGame(Game game) {
		// TODO Auto-generated method stub
		gameMapper.insertSelective(game);
	}
	public boolean checkgame(String gameName) {
		// TODO Auto-generated method stub
		GameExample example = new GameExample();
		Criteria criteria = example.createCriteria();
		criteria.andGameNameEqualTo(gameName);
		long count = gameMapper.countByExample(example);
		return count == 0;
	}
	public Game getGame(Integer gameId) {
		// TODO Auto-generated method stub
		Game game = gameMapper.selectByPrimaryKey(gameId);
		return game;
	}
	public void updateGame(Game game) {
		// TODO Auto-generated method stub
		gameMapper.updateByPrimaryKeySelective(game);
	}
	public void deleteGame(Integer gameId) {
		// TODO Auto-generated method stub
		gameMapper.deleteByPrimaryKey(gameId);
	}

}
