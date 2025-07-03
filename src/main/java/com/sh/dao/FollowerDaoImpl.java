package com.sh.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sh.dto.StoreDto;

@Repository
public class FollowerDaoImpl implements FollowerDao {
    @Autowired
    SqlSession sqlSession;

    @Override
    public List<StoreDto> selectFollowerDetail(int storeIdx) {
        HashMap<String,Integer> map1 = new HashMap<>();
        map1.put("storeIdx", storeIdx);
        return sqlSession.selectList("StoreFollowerMapper.getStoreFollowerInfo", map1);
    }
}
