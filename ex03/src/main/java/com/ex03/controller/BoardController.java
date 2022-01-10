package com.ex03.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ex03.domain.BoardAttachVO;
import com.ex03.domain.BoardVO;
import com.ex03.domain.Criteria;
import com.ex03.domain.PageDTO;
import com.ex03.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor

public class BoardController {
	
	private BoardService service;
	

	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)		// bno -> save JSON
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("get Attach List : " + bno);												// attachMapper.findByBno(bno);	
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	public void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() ==0) {
			return;
		}
		log.info("delelte attach file---------------");
		log.info(attachList);
		
		attachList.forEach(attach ->{
			Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() +"\\" + attach.getUuid() + "_" + attach.getFileName());
			
			try {
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() +
							"_" + attach.getFileName());
					
					Files.delete(thumbNail);
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				log.error("delete file error" + e.getMessage());
			}
			
		});
	} // end deleteFiles
	
	
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));
		//model.addAttribute("pageMaker", new PageDTO(cri, 100));			// 전체 임의 100개
		
		int total = service.getTotal(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) { //get -> list
		log.info("/get");
		model.addAttribute("board",service.get(bno));
	}	// open get&modify page
	
	
	@GetMapping("/register")
	public void register() {
		log.info("register page--------");
	}
	
	@PostMapping("/register")	// 게시물 등록
	public String register(BoardVO board, RedirectAttributes ra) {
		log.info("register : " + board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("==============================");
		service.register(board);
		ra.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}

	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes ra) {
		log.info("modify :" + board);
		
		if(service.modify(board)) {
			ra.addFlashAttribute("result", "success");
		}
		ra.addAttribute("pageNum", cri.getPageNum());
		ra.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
	
//	@PostMapping("/modify")
//	public String modify(BoardVO board, RedirectAttributes ra) {
//		log.info("modify : " + board);
//		service.modify(board);
//		ra.addFlashAttribute("result", "success");
//		return "redirect:/board/list";
//	}
		
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes ra){
		log.info("remove" + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			
			// delete attach files
			deleteFiles(attachList);
			
			ra.addFlashAttribute("result", "success");
		}
//		ra.addAttribute("pageNum", cri.getPageNum());
//		ra.addAttribute("amount", cri.getAmount());
//		
//		return "redirect:/board/list";
		return "redirect:/board/list" + cri.getListLink();
	}
	
/*	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list",service.getList());
	}

	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes ra) {
		log.info("remove......" + bno);
		if(service.remove(bno)) {
			ra.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
*/	
	
}
