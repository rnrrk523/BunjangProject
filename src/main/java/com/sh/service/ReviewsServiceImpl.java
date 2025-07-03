package com.sh.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.dao.ReviewsDao;
import com.sh.dto.ReviewsDto;


@Service
public class ReviewsServiceImpl implements ReviewsService{
	@Autowired
	ReviewsDao reviewsDao;
	
	@Transactional
	@Override
    public List<ReviewsDto> getStoreReviewsInfo(int storeIdx) {
        return reviewsDao.selectReviewsDetail(storeIdx);
    }
	
	@Override
    public int insertReview(Map<String, Object> params) {
        return reviewsDao.insertReview(params);
    }
	@Override
    public List<ReviewsDto> getUpdateReviewsView(Map<String, Object> params) {
        return reviewsDao.UpdateReviewsView(params);
    }
	@Override
	public int updateReview(Map<String, Object> params) {
	    return reviewsDao.updateReview(params);
	}
}
