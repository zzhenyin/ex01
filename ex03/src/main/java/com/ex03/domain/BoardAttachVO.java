package com.ex03.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BoardAttachVO {
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;			// 1: image || 0
	private Long bno;
}
