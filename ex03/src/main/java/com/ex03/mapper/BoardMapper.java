package com.ex03.mapper;

import java.util.List;

import com.ex03.domain.BoardVO;
import com.ex03.domain.Criteria;

public interface BoardMapper {

	//@Select("select * from tbl_board where bno >0")
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	// paging list
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
}
