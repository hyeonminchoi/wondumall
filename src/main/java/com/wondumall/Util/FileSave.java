package com.wondumall.Util;

import java.io.File;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileSave {
	public String save(String realPath, MultipartFile file) throws Exception {
		File saveFile = new File(realPath);
		if(!saveFile.exists())
			saveFile.mkdirs();
		
		String fileName = UUID.randomUUID().toString() + file.getOriginalFilename();
		saveFile = new File(realPath, fileName);
		//file.transferTo(saveFile); //java.io
		FileCopyUtils.copy(file.getBytes(), saveFile); //springframework
		return fileName;
	}
	
	public String save(String realPath, String file) throws Exception {
		File saveFile = new File(realPath);
		if(!saveFile.exists())
			saveFile.mkdirs();
		
		String fileName = UUID.randomUUID().toString() + file;
		saveFile = new File(realPath, fileName);
		//file.transferTo(saveFile); //java.io
		FileCopyUtils.copy(file.getBytes(), saveFile); //springframework
		return fileName;
	}
}