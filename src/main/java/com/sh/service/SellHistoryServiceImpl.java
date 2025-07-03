package com.sh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.SellHistoryDao;
import com.sh.dto.BuySellDto;
@Service
public class SellHistoryServiceImpl implements SellHistoryService {
	@Autowired
	SellHistoryDao sellhistoryDao;
	@Override
	public List<BuySellDto> getSellHistoryInfo(int storeIdx, String search) {
		 return sellhistoryDao.selectSellDetail(storeIdx,search);
	}

}
