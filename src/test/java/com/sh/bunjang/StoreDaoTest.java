package com.sh.bunjang;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sh.dto.StoreInfoDto;
import com.sh.dto.StoreReviewDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class StoreDaoTest {
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testGetStoreInfo() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", 1);
		StoreInfoDto storeInfo = sqlSession.selectOne("StoreMapper.getStoreInfo", map1);
		System.out.println(storeInfo.getStoreIdx());
		System.out.println(storeInfo.getStoreName());
	}
	
	@Test
	public void testGetProductCnt() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", 1);
		int productCnt = sqlSession.selectOne("StoreMapper.getProductCnt", map1);
		System.out.println(productCnt);
	}
	
	@Test
	public void testGetFollowCnt() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", 1);
		int followCnt = sqlSession.selectOne("StoreMapper.getFollowCnt", map1);
		System.out.println(followCnt);
	}
	
	@Test
	public void testGetFollowYN() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("productStoreIdx", 1);
		map1.put("storeIdx", 2);
		String followYN = sqlSession.selectOne("StoreMapper.getFollowYN", map1);
		System.out.println(followYN);
	}
	
	@Test
	public void testGetStoreReview() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("storeIdx", 1);
		 List<StoreReviewDto> list = sqlSession.selectList("StoreMapper.getStoreReview", map1);
		 ArrayList<StoreReviewDto> reviews = new ArrayList<StoreReviewDto>();
		 reviews.addAll(list);
		 for(StoreReviewDto dto : reviews) {
			 System.out.println(dto.getWriterName() + " / " + dto.getStartCnt() + " / " + dto.getReviewText());
		 }
	}
}
