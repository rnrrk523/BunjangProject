package com.sh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.PayDao;

@Service
public class PayServiceImpl implements PayService {
	@Autowired
	PayDao pDao;
	
	@Override
	public void pay(int sellerIdx, int buyerIdx, int productIdx, String stateStr) {
		pDao.pay(sellerIdx, buyerIdx, productIdx, stateStr);
	}
	
}
