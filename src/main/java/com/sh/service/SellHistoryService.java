package com.sh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sh.dto.BuySellDto;

@Service
public interface SellHistoryService {
	List<BuySellDto> getSellHistoryInfo(int storeIdx, String search);
}
