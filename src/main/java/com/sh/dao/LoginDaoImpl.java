package com.sh.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDaoImpl implements LoginDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Integer getLoginCheckResult(String id) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("id", id);
		return sqlSession.selectOne("LoginMapper.getLoginCheckResult", map1);
	}

	@Override
	public void setStoreInsert(String name, String id) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("name", name);
		map1.put("id", id);
		sqlSession.insert("LoginMapper.setStoreInsert", map1);
	}

}
