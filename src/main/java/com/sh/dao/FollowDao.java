package com.sh.dao;

public interface FollowDao {
	void followOn(int storeIdx, int followStoreIdx);
	void followOff(int storeIdx, int followStoreIdx);
	int followCheck(int storeIdx, int viewStoreIdx);
}
