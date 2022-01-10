package com.ex03.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ex03.domain.BoardAttachVO;
import com.ex03.domain.BoardVO;
import com.ex03.domain.Criteria;
import com.ex03.mapper.BoardAttachMapper;
import com.ex03.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import  org.springframework.beans.factory.annotation.*; 

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	
	@Transactional
	@Override
	public void register(BoardVO board) {
		// TODO Auto-generated method stub
		log.info("register...." + board);
		
		//mapper.insert(board);
		mapper.insertSelectKey(board);		// mybatis_selectKey-insert
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno){		
		log.info("get Attach List by bno : " + bno);
		return attachMapper.findByBno(bno);					//select * from tbl_attach where bno = #{bno}
	}
	
	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		log.info("get....." + bno);
		
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		// TODO Auto-generated method stub
		
		log.info("modify..." + board);
		
		attachMapper.deleteAll(board.getBno());		// 기존 첨부파일 삭제 후 새로 추가
		
		boolean modifyResult = mapper.update(board) ==1;
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach ->{
				
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		//return mapper.update(board) == 1;		// 완료 : 1
		return modifyResult;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		log.info("remove...." + bno);
		//return mapper.delete(bno) ==1;
		attachMapper.deleteAll(bno);		// 게시물 삭제시 첨부파일 삭제
		
		return mapper.delete(bno) == 1;
		
	}

//	@Override
//	public List<BoardVO> getList() {
//		// TODO Auto-generated method stub
//		log.info("getList.....");
//		
//		return mapper.getList();
//	}
	
	@Override
	public List<BoardVO> getList(Criteria cri){
		log.info("get List with criteria : " + cri);
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get Total count : ");
		return mapper.getTotalCount(cri);
	}

}
