package com.sh.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sh.dto.CategoryListDto;

@Repository
public class CategoryDaoImpl implements CategoryDao {
	@Autowired
	SqlSession sqlSession;
	
	// 대분류 카테고리리스트 가져오기
	@Override
	public ArrayList<CategoryListDto> getCategoryList1() {
		List<CategoryListDto> list = sqlSession.selectList("CategoryMapper.getCategoryList1");
		ArrayList<CategoryListDto> categoryList = new ArrayList<CategoryListDto>();
		categoryList.addAll(list);
		return categoryList;
	}

	// 중분류 카테고리리스트 가져오기
	@Override
	public ArrayList<CategoryListDto> getCategoryList2(int id) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("id", id);
		List<CategoryListDto> list = sqlSession.selectList("CategoryMapper.getCategoryList2", map1);
		ArrayList<CategoryListDto> categoryList = new ArrayList<CategoryListDto>();
		categoryList.addAll(list);
		return categoryList;
	}

	// 소분류 카테고리리스트 가져오기
	@Override
	public ArrayList<CategoryListDto> getCategoryList3(int id) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("id", id);
		List<CategoryListDto> list = sqlSession.selectList("CategoryMapper.getCategoryList3", map1);
		ArrayList<CategoryListDto> categoryList = new ArrayList<CategoryListDto>();
		categoryList.addAll(list);
		return categoryList;
	}

	@Override
	public String getAllCategoryName(int categoryIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("categoryIdx", categoryIdx);
		return sqlSession.selectOne("CategoryMapper.getAllCategoryName", map1);
	}

	@Override
	public String getMiddleCategoryName(int categoryIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("categoryIdx", categoryIdx);
		return sqlSession.selectOne("CategoryMapper.getMiddleCategoryName", map1);
	}

	@Override
	public String getSubCategoryName(int categoryIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("categoryIdx", categoryIdx);
		return sqlSession.selectOne("CategoryMapper.getSubCategoryName", map1);
	}

	@Override
	public int getMiddleCategoryParentId(int categoryIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("categoryIdx", categoryIdx);
		return sqlSession.selectOne("CategoryMapper.getMiddleCategoryParentId", map1);
	}
	
	@Override
	public int getSubCategoryParentId(int categoryIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("categoryIdx", categoryIdx);
		return sqlSession.selectOne("CategoryMapper.getSubCategoryParentId", map1);
	}

}
