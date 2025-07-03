package com.sh.bunjang;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sh.dao.FollowDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class FollowServiceTest {
	
	@Autowired
	FollowDao fDao;
	
	@Test
	public void testFollowOn() throws Exception {
		fDao.followOn(1, 2);
	}
	
	@Test
	public void testFollowOff() throws Exception {
		fDao.followOff(1, 2);
	}
}
