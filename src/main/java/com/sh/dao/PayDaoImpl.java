package com.sh.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PayDaoImpl implements PayDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void pay(int sellerIdx, int buyerIdx, int productIdx, String stateStr) {
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("productIdx", productIdx);
		map1.put("sellerIdx", sellerIdx);
		map1.put("buyerIdx", buyerIdx);
		map1.put("stateStr", stateStr);
		
		// 거래내역 insert
		sqlSession.insert("PayMapper.putSaleHistory", map1);
		
		// 상품테이블 sale_yn컬럼 Y로 변경
		sqlSession.update("PayMapper.updateSaleYN", map1);
		
		// 해당 상품 찜 해제
		sqlSession.delete("PayMapper.deleteJJim", map1);
	}
	
}
