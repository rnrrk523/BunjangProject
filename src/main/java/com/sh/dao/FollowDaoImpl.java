package com.sh.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FollowDaoImpl implements FollowDao {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void followOn(int storeIdx, int followStoreIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		map1.put("followStoreIdx", followStoreIdx);
		sqlSession.insert("FollowMapper.followOn", map1);
	}

	@Override
	public void followOff(int storeIdx, int followStoreIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		map1.put("followStoreIdx", followStoreIdx);
		sqlSession.delete("FollowMapper.followOff", map1);
	}

	@Override
	public int followCheck(int storeIdx, int viewStoreIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		map1.put("viewStoreIdx", viewStoreIdx);
		
		return sqlSession.selectOne("FollowMapper.followCheck", map1);
	}
	
}
