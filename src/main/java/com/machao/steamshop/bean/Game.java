package com.machao.steamshop.bean;

public class Game {
    private Integer gameId;

    private String gameName;

    private Integer gamePrice;

    private Integer gameClass;
    
    private String gamePic;
    
    private Genres genres;
    
    

    public String getGamePic() {
		return gamePic;
	}

	public void setGamePic(String gamePic) {
		this.gamePic = gamePic;
	}

	public Genres getGenres() {
		return genres;
	}

	public void setGenres(Genres genres) {
		this.genres = genres;
	}

	public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName == null ? null : gameName.trim();
    }

    public Integer getGamePrice() {
        return gamePrice;
    }

    public void setGamePrice(Integer gamePrice) {
        this.gamePrice = gamePrice;
    }

    public Integer getGameClass() {
        return gameClass;
    }

    public void setGameClass(Integer gameClass) {
        this.gameClass = gameClass;
    }
}