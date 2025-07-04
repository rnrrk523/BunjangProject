package com.sh.bunjang;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class DataSourceTest {
	@Autowired
	DataSource ds;
	
	@Test
	public void testGetConnection() throws Exception {
		Connection conn;
		conn = ds.getConnection();
		if(conn != null) {
			System.out.println("접속됨!");
		}
		conn.close();
	}
}
