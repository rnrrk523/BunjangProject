package com.sh.dao;

import java.util.List;

import com.sh.dto.BuySellDto;

public interface SellHistoryDao {
	List<BuySellDto> selectSellDetail(int storeIdx, String search);
}
