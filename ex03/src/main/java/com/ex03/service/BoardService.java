package com.ex03.service;

import java.util.List;

import com.ex03.domain.BoardAttachVO;
import com.ex03.domain.BoardVO;
import com.ex03.domain.Criteria;


public interface BoardService {

	//public List<BoardVO> getList();

	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList(Criteria cri);		// 페이징
	
	public int getTotal(Criteria cri);
	
}
