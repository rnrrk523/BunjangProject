package com.sh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.FollowerDao;
import com.sh.dto.StoreDto;

@Service
public class FollowerServiceImpl implements FollowerService {
	@Autowired
	FollowerDao followerDao;
	@Override
    public List<StoreDto> getStoreFollowerInfo(int storeIdx) {
        return followerDao.selectFollowerDetail(storeIdx);
    }
	
}
