package org.zerock.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	
	static {
		try {
			//Class.forName("oracle.jdbc.driver.OracleDriver");
			// oracle.jdbc.driver.OracleDriver 대신에 oracle.jdbc.OracleDriver를 사용
			// 오라클 9 이후에 oracle.jdbc.driver.OracleDriver는 중단되었음.
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		
		try(Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:XE", 
				"book_ex", 
				"book_ex")){
			
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
}
