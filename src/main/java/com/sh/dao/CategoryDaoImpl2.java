package com.sh.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.dto.CategoryDto;

public class CategoryDaoImpl2 implements CategoryDao2 {
	@Autowired
    SqlSession sqlSession;

    @Override
    public List<CategoryDto> getAllCategoryDetail() {
    	 return sqlSession.selectList("NewMapper.getAllCategoryInfo");
    }
    @Override
    public List<CategoryDto> getMiddleCategoryDetail(int pno) {
    	return sqlSession.selectList("NewMapper.getMiddleCategoryInfo",pno);
    }
    @Override
    public List<CategoryDto> getSmallCategoryDetail(int pno) {
    	return sqlSession.selectList("NewMapper.getSmallCategoryInfo",pno);
    }
}
