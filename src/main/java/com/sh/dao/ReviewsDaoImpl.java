package com.sh.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.dto.ReviewsDto;


public class ReviewsDaoImpl implements ReviewsDao {
	@Autowired
    SqlSession sqlSession;

    @Override
    public List<ReviewsDto> selectReviewsDetail(int storeIdx) {
        HashMap<String,Integer> map1 = new HashMap<>();
        map1.put("storeIdx", storeIdx);
        return sqlSession.selectList("StoreReviewsMapper.getStoreReviewsInfo", map1);
    }
    
    @Override
    public int insertReview(Map<String, Object> params) {
    	return sqlSession.insert("StoreReviewsMapper.InsertReviews", params);
    }
    @Override
    public List<ReviewsDto> UpdateReviewsView(Map<String, Object> params) {
        return sqlSession.selectList("StoreReviewsMapper.UpdateReviewsView", params);
    }
    @Override
    public int updateReview(Map<String, Object> params) {
        return sqlSession.update("StoreReviewsMapper.UpdateReviews", params);
    }
}
