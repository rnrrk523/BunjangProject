package com.sh.bunjang;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sh.dao.CategoryDao;
import com.sh.dto.CategoryListDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class CategoryServiceTest {
	@Autowired
	CategoryDao cDao;
	
	@Test
	public void testGetCategoryList1() throws Exception {
		ArrayList<CategoryListDto> list = cDao.getCategoryList1();
		for(CategoryListDto dto : list) {
			System.out.println(dto.getCategoryIdx() + " / " + dto.getCategoryName());
		}
	}
	
	@Test
	public void testGetCategoryList2() throws Exception {
		ArrayList<CategoryListDto> list = cDao.getCategoryList2(1);
		for(CategoryListDto dto : list) {
			System.out.println(dto.getCategoryIdx() + " / " + dto.getCategoryName());
		}
	}
	
	@Test
	public void testGetCategoryList3() throws Exception {
		ArrayList<CategoryListDto> list = cDao.getCategoryList3(3);
		for(CategoryListDto dto : list) {
			System.out.println(dto.getCategoryIdx() + " / " + dto.getCategoryName());
		}
	}
}
