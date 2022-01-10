package com.ex03.persistence;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ex03.domain.BoardVO;
import com.ex03.domain.Criteria;
import com.ex03.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

import  org.springframework.beans.factory.annotation.*; 

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j

public class BoardServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	//@Test
	public void testExixt() {
		log.info(service);
		assertNotNull(service);
	}

/*
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("new");
		board.setContent("abcd");
		board.setWriter("elsa");
		
		service.register(board);
		
		log.info("bno : " + board.getBno());
	}
*/
	@Test
	public void testGetList() {
//		service.getList().forEach(board -> log.info(board));
		
		service.getList(new Criteria(2,7)).forEach(board -> log.info(board));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(8L));
	}
	
	//@Test
	public void testUpdate() {
		BoardVO board = service.get(3L);
		if(board == null) {
			return;
		}
		
		board.setTitle("update table");
		board.setContent("update");
		log.info("modify result: " + service.modify(board));
	}
	
	//@Test
	public void testDelete() {
		log.info("remove result: " + service.remove(4L));
	}
	
}
