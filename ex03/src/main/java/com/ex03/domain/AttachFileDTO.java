package com.ex03.domain;

import lombok.Data;

@Data
public class AttachFileDTO {	
	
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
}
