package com.sh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.JjimDao2;
import com.sh.dto.JjimDto;

@Service
public class JjimServiceImpl2 implements JjimService2 {
	@Autowired
	JjimDao2 jjimDao2;
	@Override
    public List<JjimDto> getStoreJjimInfo(int storeIdx, String str) {
		 if ("인기순".equals(str)) {
            return jjimDao2.selectJjimFameDetail(storeIdx);
        } else {
            return jjimDao2.selectJjimDetail(storeIdx, str);
        }
    }
	@Override
    public void deleteJjimProduct(List<Integer> productIdxList, int storeIdx) {
        for (int productIdx : productIdxList) {
            jjimDao2.deleteJjimProduct(storeIdx, productIdx);
        }
    }
}
