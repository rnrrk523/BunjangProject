package com.sh.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SecessionDaoImpl implements SecessionDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void delStoreSecession(int storeIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", storeIdx);
		sqlSession.delete("SecessionMapper.delStoreSecession", map1);
	}

}
