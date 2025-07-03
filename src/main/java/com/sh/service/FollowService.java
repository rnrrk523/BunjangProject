package com.sh.service;

public interface FollowService {
	void followOn(int storeIdx, int followStoreIdx);
	void followOff(int storeIdx, int followStoreIdx);
	int followCheck(int storeIdx, int viewStoreIdx);
}
