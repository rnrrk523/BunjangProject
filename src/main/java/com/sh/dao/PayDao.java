package com.sh.dao;

public interface PayDao {
	void pay(int sellerIdx, int buyerIdx, int productIdx, String stateStr);
}
