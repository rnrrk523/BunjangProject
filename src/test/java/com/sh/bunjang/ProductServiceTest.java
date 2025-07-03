package com.sh.bunjang;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sh.dao.ProductDao;
import com.sh.dto.ProductInfoDto;
import com.sh.dto.ProductListDto;
import com.sh.dto.ProductSearchListDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ProductServiceTest {
	@Autowired
	ProductDao pDao;
	
	@Test
	public void testGetProductList() {
		int pageNum = 1;
		int end = pageNum * 50;
		int start = end - 49;
		
		ArrayList<ProductListDto> list = pDao.getProductList(start, end);
		System.out.println("size : " + list.size());
		for(ProductListDto dto : list) {
			System.out.println(dto.getProductIdx() + " / " + dto.getProductName());
		}
	}
	
	@Test
	public void testGetProductInfo() {
		ProductInfoDto productInfo = pDao.getProductInfo(1, 2);
		System.out.println(productInfo.getProductIdx());
		System.out.println(productInfo.getProductName());
	}
	
	@Test
	public void testGetProductSearchList() {
		int pageNum = 1;
		int end = pageNum * 20;
		int start = end - 19;
		ArrayList<ProductSearchListDto> list = pDao.getProductSearchList(start, end, "%"+"5"+"%");
		System.out.println("size : " + list.size());
		for(ProductSearchListDto dto : list) {
			System.out.println(dto.getProductIdx() + " / " + dto.getProductName());
		}
	}
}
