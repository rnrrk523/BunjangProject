package com.sh.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.StoreDao;
import com.sh.dto.StoreInfoDto;
import com.sh.dto.StoreReviewDto;

@Service
public class StoreServiceImpl implements StoreService {
	
	@Autowired
	StoreDao sDao;

	@Override
	public StoreInfoDto getStoreInfo(int storeIdx) {
		return sDao.getStoreInfo(storeIdx);
	}

	@Override
	public String getFollowYN(int storeIdx, int productStoreIdx) {
		return sDao.getFollowYN(storeIdx, productStoreIdx);
	}

	@Override
	public ArrayList<StoreReviewDto> getStoreReview(int storeIdx) {
		return sDao.getStoreReview(storeIdx);
	}

	@Override
	public int getStoreReviewCnt(int storeIdx) {
		return sDao.getStoreReviewCnt(storeIdx);
	}

	@Override
	public int getJJimCnt(int storeIdx) {
		return sDao.getJJimCnt(storeIdx);
	}
}
