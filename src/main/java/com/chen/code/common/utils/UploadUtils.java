package com.chen.code.common.utils;

import cn.hutool.core.io.FileUtil;
import com.google.common.io.Files;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

/**
 * Created by 陈书山 on 2017/11/21.
 */
@Component
public class UploadUtils {

	public static String uploadFolder;


	public static File upload(MultipartFile file,String filePath) throws IOException {
		return upload(file,filePath,"");
	}

	public static File uploadMappingDir(MultipartFile file,String childDir) throws IOException {
		return upload(file, uploadFolder, childDir);
	}



	public static File upload(MultipartFile file,String filePath,String childDir) throws IOException {
		String fileName = file.getOriginalFilename();

		String fileExtension = Files.getFileExtension(fileName);
		String nameWithoutExtension = Files.getNameWithoutExtension(fileName);
		String newFileName = nameWithoutExtension + System.currentTimeMillis();
		if(childDir !=null || childDir.length() > 0){
			filePath = filePath + File.separator + childDir;
		}

//		服务器端文件
		filePath = filePath + File.separator + newFileName + "." + fileExtension;
		File saveFile = FileUtil.touch(filePath);
		file.transferTo(saveFile);
		return saveFile;
	}

	public String getUploadFolder() {
		return uploadFolder;
	}
	@Value("${file.uploadFolder}")
	public void setUploadFolder(String uploadFolder) {
		this.uploadFolder = uploadFolder;
	}
}
