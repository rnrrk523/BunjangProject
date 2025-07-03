package com.sh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.FollowingDao;
import com.sh.dto.FollowingStoreDto;

@Service
public class FollowingServiceImpl implements FollowingService {
	@Autowired
	FollowingDao followingDao;
	@Override
    public List<FollowingStoreDto> getStoreFollowingInfo(int storeIdx, int myStoreIdx) {
        return followingDao.selectFollowingDetail(storeIdx, myStoreIdx);
    }
}
