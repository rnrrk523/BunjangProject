package com.sh.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sh.dto.ProductInfoDto;
import com.sh.dto.ProductListDto;
import com.sh.dto.ProductSearchListDto;

@Repository
public class ProductDaoImpl implements ProductDao {
	@Autowired
	SqlSession sqlSession;
	
	// 메인 홈 추천상품리스트 뽑기
	@Override
	public ArrayList<ProductListDto> getProductList(int rnum1, int rnum2) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("rnum1", rnum1);
		map1.put("rnum2", rnum2);
		List<ProductListDto> list = sqlSession.selectList("ProductMapper.getProductList", map1);
		ArrayList<ProductListDto> aList = new ArrayList<ProductListDto>();
		aList.addAll(list);
		return aList;
	}
	
	// 선택한 상품의 정보 가져오기
	@Override
	public ProductInfoDto getProductInfo(Integer storeIdx, int productIdx) {
		HashMap<String, Integer> map1 = new HashMap<String, Integer>();
		map1.put("productIdx", productIdx);
		map1.put("storeIdx", storeIdx);
		ProductInfoDto product = sqlSession.selectOne("ProductMapper.getProductInfo", map1);
		if(product == null) {
			return null;
		}
		product.setJjimCnt(sqlSession.selectOne("ProductMapper.getProductJJimCnt", map1));
		product.setCheckCnt(sqlSession.selectOne("ProductMapper.getProductCheckCnt", map1));
		product.setJjimYN(sqlSession.selectOne("ProductMapper.getProductJJimYN", map1));
		
		return product;
	}
	
	// 검색리스트 페이지의 상품리스트 뽑기
	@Override
	public ArrayList<ProductSearchListDto> getProductSearchList(int rnum1, int rnum2, String str) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("rnum1", rnum1);
		map1.put("rnum2", rnum2);
		map1.put("str", str);
		List<ProductSearchListDto> list = sqlSession.selectList("ProductMapper.getProductSearchList", map1);
		ArrayList<ProductSearchListDto> productList = new ArrayList<ProductSearchListDto>();
		productList.addAll(list);
		return productList;
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductSearchSortList1(String str) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("str", str);
		List<ProductSearchListDto> list = sqlSession.selectList("ProductMapper.getProductSearchSortList1", map1);
		ArrayList<ProductSearchListDto> productList = new ArrayList<ProductSearchListDto>();
		productList.addAll(list);
		return productList;
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductSearchSortList2(String str) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("str", str);
		List<ProductSearchListDto> list = sqlSession.selectList("ProductMapper.getProductSearchSortList2", map1);
		ArrayList<ProductSearchListDto> productList = new ArrayList<ProductSearchListDto>();
		productList.addAll(list);
		return productList;
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductSearchSortList3(String str) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("str", str);
		List<ProductSearchListDto> list = sqlSession.selectList("ProductMapper.getProductSearchSortList3", map1);
		ArrayList<ProductSearchListDto> productList = new ArrayList<ProductSearchListDto>();
		productList.addAll(list);
		return productList;
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductSearchPageNumList(int rnum1, int rnum2, String sortStr, String str) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("rnum1", rnum1);
		map1.put("rnum2", rnum2);
		map1.put("sortStr", sortStr);
		map1.put("str", str);
		List<ProductSearchListDto> list = sqlSession.selectList("ProductMapper.getProductSearchPageNumList", map1);
		ArrayList<ProductSearchListDto> productList = new ArrayList<ProductSearchListDto>();
		productList.addAll(list);
		return productList;
	}

	@Override
	public ArrayList<ProductSearchListDto> getProductCategoryList(int rnum1, int rnum2, String categoryLevel, int categoryIdx) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("rnum1", rnum1);
		map1.put("rnum2", rnum2);
		map1.put("categoryLevel", categoryLevel);
		map1.put("categoryIdx", categoryIdx);
		List<ProductSearchListDto> list = sqlSession.selectList("ProductMapper.getProductCategoryList", map1);
		ArrayList<ProductSearchListDto> productList = new ArrayList<ProductSearchListDto>();
		productList.addAll(list);
		return productList;
	}
		
	@Override
	public void setProductCheck(int productIdx, int viewdStoreIdx) {
		if(viewdStoreIdx != 0) {
			HashMap<String, Integer> map1 = new HashMap<String, Integer>();
			map1.put("productIdx", productIdx);
			map1.put("viewdStoreIdx", viewdStoreIdx);
			sqlSession.insert("ProductMapper.setProductCheck", map1);
		}
	}
	
}
