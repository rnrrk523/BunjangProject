package com.sh.dao;

import java.util.List;

import com.sh.dto.JjimDto;

public interface JjimDao2 {
	List<JjimDto> selectJjimDetail(int storeIdx, String str);
	List<JjimDto> selectJjimFameDetail(int storeIdx);
	
	 int deleteJjimProduct(int storeIdx, int productIdx);
}
