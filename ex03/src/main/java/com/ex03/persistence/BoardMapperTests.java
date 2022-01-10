package com.ex03.persistence;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;

import com.ex03.domain.BoardVO;
import com.ex03.domain.Criteria;
import com.ex03.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import sun.print.resources.serviceui;

import  org.springframework.beans.factory.annotation.*; 


@TestExecutionListeners( { DependencyInjectionTestExecutionListener.class })

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(board -> log.info(board));
//	}

	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		
		//10개씩 3페이지
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
	
	//@Test
	public void testInsertselectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("xingqisan");
		board.setContent("haiyouliangtian");
		board.setWriter("wo");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	
	//@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새 글 새 글");
		board.setContent("새 내용 새 내용");
		board.setWriter("나 !");
		
		mapper.insert(board);;
		
		//log.info(board);
	}	
	
	
	//@Test
	public void testRead() {
		BoardVO board = mapper.read(2L);
		//log.info(board);
	}
	

	//@Test
	public void testDelete() {
		log.info("DELETE COUNT: " + mapper.delete(2L));
	}


	//@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(6L);
		board.setTitle("Cc");
		board.setContent("Cc");
		board.setWriter("Cc");
		
		int count = mapper.update(board);
		log.info("update count : " + count);
	}

}
