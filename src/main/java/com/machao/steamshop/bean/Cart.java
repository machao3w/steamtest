package com.machao.steamshop.bean;

public class Cart {
    private Integer cartId;

    private Integer buyerId;

    private Integer gameId;

    private Integer quantity;
    
    private Game game;
    
    private UserNew user;
    

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
	}

	public UserNew getUser() {
		return user;
	}

	public void setUser(UserNew user) {
		this.user = user;
	}

	public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public Integer getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(Integer buyerId) {
        this.buyerId = buyerId;
    }

    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}