package com.sh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.dao.ProductCreateDao;
import com.sh.dto.InsertProductDto;

@Service
public class ProductCreateServiceImpl implements ProductCreateService {

    @Autowired
    private ProductCreateDao productCreateDao;

    @Override
    public int addProduct(InsertProductDto product) {
        return productCreateDao.insertProduct(product);
    }
}
