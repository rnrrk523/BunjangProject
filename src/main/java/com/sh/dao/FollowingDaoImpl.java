package com.sh.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.dto.FollowingStoreDto;

public class FollowingDaoImpl implements FollowingDao {
	@Autowired
    SqlSession sqlSession;

    @Override
    public List<FollowingStoreDto> selectFollowingDetail(int storeIdx, int myStoreIdx) {
        HashMap<String,Integer> map1 = new HashMap<>();
        map1.put("storeIdx", storeIdx);
        map1.put("myStoreIdx", myStoreIdx);
        return sqlSession.selectList("StoreFollowingMapper.getStoreFollowingInfo", map1);
    }
}
