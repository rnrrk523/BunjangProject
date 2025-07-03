package com.sh.dao;

import java.util.List;

import com.sh.dto.ManagerDto;

public interface ManagerDao {
	List<ManagerDto> selectManagerDetail(int storeIdx, String str, int startRow, int endRow , String search);
	int getTotalProductCount(int storeIdx, String str, String search);
	 int deleteProduct(int productIdx);
}
