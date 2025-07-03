package com.sh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sh.dto.BuySellDto;

@Service
public interface BuyHistoryService {
	List<BuySellDto> getBuyHistoryInfo(int storeIdx, String search);
	int updateSaleStatus(int productIdx, int historyIdx, String status);
	void updateAllSecession(int storeIdx);
}
