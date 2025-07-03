package com.sh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.SecessionDao;

@Service
public class SecessionServiceImpl implements SecessionService {
	@Autowired
	SecessionDao sDao;
	
	@Override
	public void delStoreSecession(int storeIdx) {
		sDao.delStoreSecession(storeIdx);
	}

}
