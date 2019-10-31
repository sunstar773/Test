package com.fh.controller.file;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.CannedAccessControlList;
import com.fh.po.common.ServerResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.UUID;

@Controller
public class FileController {


/*    //文件上传
    @RequestMapping("uploadPhoto")
    @ResponseBody
    public Map<String,Object> uploadPhoto(@RequestParam("headPhoto")CommonsMultipartFile photo, String type){
        Map<String,Object> map=new HashMap<String, Object>();
        String url = CopyFile.copyFile(photo, type);
        if (StringUtils.isNoneBlank(url)){
            map.put("ok",true);
            map.put("url",url);
            return map;
        }
        map.put("ok",false);
        return map;
    }*/
    @RequestMapping("/textOss")
    @ResponseBody
    public ServerResponse testOss(@RequestParam()MultipartFile headPhoto, HttpServletRequest request) throws IOException {
        String endpoint = "http://oss-cn-beijing.aliyuncs.com";
        String endpoint1 = "oss-cn-beijing.aliyuncs.com";
        String accessKeyId = "LTAI4Fg1bdn7NZRNdLnBnaEL";
        String accessKeySecret = "lAmUQXKHTAJrhEeDQQG1gdc62dDpJn";
        String bucketName="sunstaroos";
// 创建OSSClient实例。
        OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
        String originalFilename = headPhoto.getOriginalFilename();
        String houzhui=originalFilename.substring(originalFilename.indexOf("."));
        String newfileName=UUID.randomUUID().toString();
        newfileName=newfileName+houzhui;
        ossClient.setBucketAcl(bucketName,CannedAccessControlList.PublicRead);
        ossClient.putObject(bucketName, newfileName, headPhoto.getInputStream());
        ossClient.shutdown();
        return ServerResponse.success("https://"+bucketName+"."+endpoint1+"/"+newfileName);
    }
}
