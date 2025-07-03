package com.sh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.FollowDao;

@Service
public class FollowServiceImpl implements FollowService {
	
	@Autowired
	FollowDao fDao;
	
	@Override
	public void followOn(int storeIdx, int followStoreIdx) {
		fDao.followOn(storeIdx, followStoreIdx);
	}

	@Override
	public void followOff(int storeIdx, int followStoreIdx) {
		fDao.followOff(storeIdx, followStoreIdx);
	}

	@Override
	public int followCheck(int storeIdx, int viewStoreIdx) {
		return fDao.followCheck(storeIdx, viewStoreIdx);
	}

}
