package com.sh.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sh.dto.StoreInfoDto;
import com.sh.dto.StoreReviewDto;

@Repository
public class StoreDaoImpl implements StoreDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public StoreInfoDto getStoreInfo(int storeIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		StoreInfoDto storeInfo = sqlSession.selectOne("StoreMapper.getStoreInfo", map1);
		storeInfo.setProductCnt(sqlSession.selectOne("StoreMapper.getProductCnt", map1));
		storeInfo.setFollowCnt(sqlSession.selectOne("StoreMapper.getFollowCnt", map1));
		return storeInfo;
	}

	@Override
	public String getFollowYN(int storeIdx, int productStoreIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		map1.put("productStoreIdx", productStoreIdx);
		String followYN = sqlSession.selectOne("StoreMapper.getFollowYN", map1);
		return followYN;
	}

	@Override
	public ArrayList<StoreReviewDto> getStoreReview(int storeIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		 List<StoreReviewDto> list = sqlSession.selectList("StoreMapper.getStoreReview", map1);
		 ArrayList<StoreReviewDto> reviews = new ArrayList<StoreReviewDto>();
		 reviews.addAll(list);
		return reviews;
	}

	@Override
	public int getStoreReviewCnt(int storeIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		return sqlSession.selectOne("StoreMapper.getStoreReviewCnt", map1);
	}

	@Override
	public int getJJimCnt(int storeIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		return sqlSession.selectOne("JJimMapper.getJJimCnt", map1);
	}

}
