package com.sh.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JJimDaoImpl implements JJimDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void jjimOn(int storeIdx, int productIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		map1.put("productIdx", productIdx);
		sqlSession.insert("JJimMapper.jjimOn", map1);
	}

	@Override
	public void jjimOff(int storeIdx, int productIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		map1.put("productIdx", productIdx);
		sqlSession.delete("JJimMapper.jjimOff", map1);
	}

}
