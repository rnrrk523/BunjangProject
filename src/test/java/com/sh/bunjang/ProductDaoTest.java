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

import com.sh.dto.ProductInfoDto;
import com.sh.dto.ProductListDto;
import com.sh.dto.ProductSearchListDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ProductDaoTest {
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testGetProductList() {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("rnum1", 1);
		map1.put("rnum2", 25);
		
		List<ProductListDto> list = sqlSession.selectList("ProductMapper.getProductList", map1);
		ArrayList<ProductListDto> aList = new ArrayList<ProductListDto>();
		aList.addAll(list);
		
		for(ProductListDto dto : aList) {
			System.out.println(dto.getProductIdx() + " / " + dto.getProductName());
		}
	}
	
	@Test
	public void testGetProductInfo() {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("productIdx", 2);
		ProductInfoDto product = sqlSession.selectOne("ProductMapper.getProductInfo", map1);
		
		product.setJjimCnt(sqlSession.selectOne("ProductMapper.getProductJJimCnt", map1));
		product.setCheckCnt(sqlSession.selectOne("ProductMapper.getProductCheckCnt", map1));
		
		map1.put("storeIdx", product.getStoreIdx());
		product.setJjimYN(sqlSession.selectOne("ProductMapper.getProductJJimYN", map1));
		
		System.out.println(product.getProductIdx());
		System.out.println(product.getStoreIdx());
		System.out.println(product.getProductName());
	}
	
	@Test
	public void testGetProductSearchList() throws Exception{
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("rnum1", 1);
		map1.put("rnum2", 25);
		map1.put("str", "%"+"5"+"%");
		List<ProductSearchListDto> list = sqlSession.selectList("ProductMapper.getProductSearchList", map1);
		ArrayList<ProductSearchListDto> productList = new ArrayList<ProductSearchListDto>();
		productList.addAll(list);
		for(ProductSearchListDto dto : productList) {
			System.out.println(dto.getProductIdx() + " / " + dto.getProductName());
		}
	}
}
