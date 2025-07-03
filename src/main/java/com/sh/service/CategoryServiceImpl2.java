package com.sh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sh.dao.CategoryDao2;
import com.sh.dto.CategoryDto;

@Service
public class CategoryServiceImpl2 implements CategoryService2 {

    private CategoryDao2 categoryDao2;

    public CategoryServiceImpl2(CategoryDao2 categoryDao2) {
        this.categoryDao2 = categoryDao2;
    }

    @Override
    public List<CategoryDto> getAllCategoryInfo() {
        return categoryDao2.getAllCategoryDetail();
    }
    @Override
    public List<CategoryDto> getMiddleCategoryInfo(int pno) {
    	return categoryDao2.getMiddleCategoryDetail(pno);
    }
    @Override
    public List<CategoryDto> getSmallCategoryInfo(int pno) {
    	return categoryDao2.getSmallCategoryDetail(pno);
    }
}
