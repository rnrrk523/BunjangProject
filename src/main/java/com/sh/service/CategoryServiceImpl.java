package com.sh.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.CategoryDao;
import com.sh.dto.CategoryListDto;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	CategoryDao cDao;
	
	@Override
	public ArrayList<CategoryListDto> getCategoryList1() {
		return cDao.getCategoryList1();
	}

	@Override
	public ArrayList<CategoryListDto> getCategoryList2(int id) {
		return cDao.getCategoryList2(id);
	}

	@Override
	public ArrayList<CategoryListDto> getCategoryList3(int id) {
		return cDao.getCategoryList3(id);
	}

	@Override
	public String getAllCategoryName(int categoryIdx) {
		return cDao.getAllCategoryName(categoryIdx);
	}

	@Override
	public String getMiddleCategoryName(int categoryIdx) {
		return cDao.getMiddleCategoryName(categoryIdx);
	}

	@Override
	public String getSubCategoryName(int categoryIdx) {
		return cDao.getSubCategoryName(categoryIdx);
	}

	@Override
	public int getMiddleCategoryParentId(int categoryIdx) {
		return cDao.getMiddleCategoryParentId(categoryIdx);
	}

	@Override
	public int getSubCategoryParentId(int categoryIdx) {
		return cDao.getSubCategoryParentId(categoryIdx);
	}
}
