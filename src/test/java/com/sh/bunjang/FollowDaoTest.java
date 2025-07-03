package com.sh.bunjang;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class FollowDaoTest {
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testFollowOn() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", 1);
		map1.put("followStoreIdx", 2);
		sqlSession.insert("FollowMapper.followOn", map1);
	}
	
	@Test
	public void testFollowOff() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", 1);
		map1.put("followStoreIdx", 2);
		sqlSession.delete("FollowMapper.followOff", map1);
	}
}
