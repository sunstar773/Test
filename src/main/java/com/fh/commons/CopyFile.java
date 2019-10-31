package com.fh.commons;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.CannedAccessControlList;
import com.fh.po.common.ServerResponse;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class CopyFile {


	    public static ServerResponse upOss(CommonsMultipartFile file) throws IOException {
			String endpoint = "http://oss-cn-beijing.aliyuncs.com";
			String accessKeyId = "LTAI4Fg1bdn7NZRNdLnBnaEL";
			String accessKeySecret = "lAmUQXKHTAJrhEeDQQG1gdc62dDpJn";
			String bucketName="sunstaroos";
			OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
			String originalFilename = file.getOriginalFilename();
			String houzhui=originalFilename.substring(originalFilename.indexOf("."));
			String newfileName=UUID.randomUUID().toString();
			newfileName=newfileName+houzhui;
			ossClient.setBucketAcl(bucketName,CannedAccessControlList.PublicRead);
			ossClient.putObject(bucketName, newfileName, file.getInputStream());
			ossClient.shutdown();
			return ServerResponse.success("https://"+bucketName+"."+endpoint+"/"+newfileName);
		}

       public static String copyFile(CommonsMultipartFile photo,String mkdirName){
    	   //获取request
    	   HttpServletRequest request = ((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes())).getRequest();
    	   //获取项目发布的绝对路径
    	   String realPath = request.getServletContext().getRealPath("/");
    	   String oldName = photo.getOriginalFilename();
    	   String suffix = oldName.substring(oldName.lastIndexOf("."));
    	   String uuid = UUID.randomUUID().toString();
    	   String newFileName = uuid+suffix;
    	   //获取要保存文件夹的路径
    	   String mkdirUrl=realPath+"/commons/"+mkdirName;
    	    File file = new File(mkdirUrl);
    	    if (!file.exists()) {
    	    	file.mkdirs();
			}
    	    try {
				photo.transferTo(new File(mkdirUrl+"/"+newFileName));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return "commons/"+mkdirName+"/"+newFileName;
    	   
       }
}
