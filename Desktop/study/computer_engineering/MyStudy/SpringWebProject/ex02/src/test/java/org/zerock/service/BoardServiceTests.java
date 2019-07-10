package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// Java Config
// @ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = {@Autowired })
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("修正された題名");
		board.setContent("修正された内容");
		board.setWriter("newbie");
		
		service.register(board);
		
		log.info("生成された掲示物の番号" + board.getBno());
	}
	
	@Test
	public void testGet() {
		log.info(service.get(1L));
	}
	
//	@Test
//	public void testDelete() {
//		log.info(service.remove(2L));
//	}
//	
//	@Test
//	public void testUpdate() {
//		BoardVO board = service.get(1L);
//		
//		if (board == null) return;
//		
//		board.setTitle("題名を修正します。");
//		log.info("MODIFY RESULT: " + service.modify(board));
//	}
	
}
