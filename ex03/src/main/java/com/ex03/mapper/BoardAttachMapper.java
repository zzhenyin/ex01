package com.ex03.mapper;

import java.util.List;

import com.ex03.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	public void delete(String uuidd);		
	public List<BoardAttachVO> findByBno(Long bno);
	public void deleteAll(Long bno);		// 게시물 삭제시 첨부파일 삭제
	
	public List<BoardAttachVO> getOldFiles();
	
}
