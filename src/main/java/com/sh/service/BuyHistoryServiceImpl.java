package com.sh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.dao.BuyHistoryDao;
import com.sh.dto.BuySellDto;
@Service
public class BuyHistoryServiceImpl implements BuyHistoryService {
	@Autowired
	BuyHistoryDao buyhistoryDao;
	
	@Override
	public List<BuySellDto> getBuyHistoryInfo(int storeIdx, String search) {
		 return buyhistoryDao.selectBuyDetail(storeIdx,search);
	}
	
	@Transactional
	@Override
    public int updateSaleStatus(int productIdx, int historyIdx, String status) {
		int result = buyhistoryDao.updateSaleStatus(productIdx,historyIdx, status);
	    if ("취소/환불".equals(status)) {
	        buyhistoryDao.updateProductSaleYn(productIdx);
	    }
	    return result;
    }

	@Override
	public void updateAllSecession(int storeIdx) {
		buyhistoryDao.updateAllSecession(storeIdx);
	}
}
