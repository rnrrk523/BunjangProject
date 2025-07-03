package com.sh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.LoginDao;

@Service
public class LoginServiceImpl implements LoginService {
	@Autowired
	LoginDao lDao;
	
	@Override
	public Integer getLoginCheckResult(String id) {
		return lDao.getLoginCheckResult(id);
	}

	@Override
	public void setStoreInsert(String name, String id) {
		lDao.setStoreInsert(name, id);
	}

}
