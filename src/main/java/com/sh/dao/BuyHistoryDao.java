package com.sh.dao;

import java.util.List;

import com.sh.dto.BuySellDto;

public interface BuyHistoryDao {
	List<BuySellDto> selectBuyDetail(int storeIdx, String search);
	int updateSaleStatus(int productIdx, int historyIdx ,String status);
	int updateProductSaleYn(int productIdx);
	void updateAllSecession(int storeIdx);
}
