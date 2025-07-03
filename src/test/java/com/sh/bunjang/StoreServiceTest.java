package com.sh.bunjang;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sh.dao.StoreDao;
import com.sh.dto.StoreInfoDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class StoreServiceTest {
	@Autowired
	StoreDao sDao;
	
	@Test
	public void testGetStoreInfo() throws Exception {
		StoreInfoDto storeInfo = sDao.getStoreInfo(1);
		System.out.println(storeInfo.getStoreIdx());
		System.out.println(storeInfo.getStoreName());
	}
}
