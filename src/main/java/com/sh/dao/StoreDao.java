package com.sh.dao;

import java.util.ArrayList;

import com.sh.dto.StoreInfoDto;
import com.sh.dto.StoreReviewDto;

public interface StoreDao {
	StoreInfoDto getStoreInfo(int storeIdx);
	String getFollowYN(int storeIdx, int productStoreIdx);
	ArrayList<StoreReviewDto> getStoreReview(int storeIdx);
	int getStoreReviewCnt(int storeIdx);
	int getJJimCnt(int storeIdx);
}
