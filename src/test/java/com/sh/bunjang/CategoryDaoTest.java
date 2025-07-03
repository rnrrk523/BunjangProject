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

import com.sh.dto.CategoryListDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class CategoryDaoTest {
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testGetCategoryList1() throws Exception {
		List<CategoryListDto> list = sqlSession.selectList("CategoryMapper.getCategoryList1");
		ArrayList<CategoryListDto> categoryList = new ArrayList<CategoryListDto>();
		categoryList.addAll(list);
		System.out.println(categoryList.size());
		for(CategoryListDto dto : categoryList) {
			System.out.println(dto.getCategoryIdx() + " / " + dto.getCategoryName());
		}
	}
	
	@Test
	public void testGetCategoryList2() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("id", 1);
		List<CategoryListDto> list = sqlSession.selectList("CategoryMapper.getCategoryList2", map1);
		ArrayList<CategoryListDto> categoryList = new ArrayList<CategoryListDto>();
		categoryList.addAll(list);
		System.out.println(categoryList.size());
		for(CategoryListDto dto : categoryList) {
			System.out.println(dto.getCategoryIdx() + " / " + dto.getCategoryName());
		}
	}
	
	@Test
	public void testGetCategoryList3() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("id", 6);
		List<CategoryListDto> list = sqlSession.selectList("CategoryMapper.getCategoryList3", map1);
		ArrayList<CategoryListDto> categoryList = new ArrayList<CategoryListDto>();
		categoryList.addAll(list);
		System.out.println(categoryList.size());
		for(CategoryListDto dto : categoryList) {
			System.out.println(dto.getCategoryIdx() + " / " + dto.getCategoryName());
		}
	}
	
	@Test
	public void testGetAllCategoryName() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("categoryIdx", 8);
		String categoryName = sqlSession.selectOne("CategoryMapper.getAllCategoryName", map1);
		System.out.println(categoryName);
	}
	
	@Test
	public void testGetMiddleCategoryName() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("categoryIdx", 51);
		String categoryName = sqlSession.selectOne("CategoryMapper.getMiddleCategoryName", map1);
		System.out.println(categoryName);
	}
	
	@Test
	public void testGetSubCategoryName() throws Exception {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("categoryIdx", 175);
		String categoryName = sqlSession.selectOne("CategoryMapper.getSubCategoryName", map1);
		System.out.println(categoryName);
	}
}
