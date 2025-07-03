package com.sh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.ManagerDao;
import com.sh.dto.ManagerDto;
@Service
public class ManagerServiceImpl implements ManagerService {
    @Autowired
    private ManagerDao managerDao;

    @Override
    public List<ManagerDto> getProductManagerInfo(int storeIdx, String str, int startRow, int endRow , String search) {
        return managerDao.selectManagerDetail(storeIdx, str, startRow, endRow,search);
    }

    @Override
    public int getTotalProductCount(int storeIdx, String str, String search) {
        return managerDao.getTotalProductCount(storeIdx, str, search);
    }
    @Override
    public boolean deleteProduct(int productIdx) {
        return managerDao.deleteProduct(productIdx) > 0;
    }
}
