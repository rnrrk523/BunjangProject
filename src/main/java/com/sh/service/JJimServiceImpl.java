package com.sh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.JJimDao;

@Service
public class JJimServiceImpl implements JJimService {
	@Autowired
	JJimDao jjimDao;
	
	@Override
	public void JJimOn(int storeIdx, int productIdx) {
		jjimDao.jjimOn(storeIdx, productIdx);
	}

	@Override
	public void JJimOff(int storeIdx, int productIdx) {
		jjimDao.jjimOff(storeIdx, productIdx);
	}

}
