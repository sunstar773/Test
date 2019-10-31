package com.fh.controller;

import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

public class test {
    public static  void main(String[] args ){

        String endpoint = "http://oss-cn-beijing.aliyuncs.com";
        String accessKeyId = "LTAI4Fg1bdn7NZRNdLnBnaEL";
        String accessKeySecret = "lAmUQXKHTAJrhEeDQQG1gdc62dDpJn";
        String bucketName="sunstaroos";

      /*  File file=new File("C:\\Users\\孙Star\\Pictures\\thumb-1920-960281.jpg");
        FileInputStream fis=null;
        try {
            fis=new FileInputStream(file);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }*/
        OSSClient ossClient=new OSSClient(endpoint,accessKeyId,accessKeySecret);
        ossClient.deleteObject(bucketName,"771b4242-b457-4374-a5ba-646495c695fb.jpg");
       /* ObjectMetadata metadata=new ObjectMetadata();
        metadata.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        metadata.setContentEncoding("utf-8");
        metadata.setContentLength(file.length());
        PutObjectResult result = ossClient.putObject(bucketName, file.getName(),fis, metadata);
        System.out.println(result.getETag());*/
        ossClient.shutdown();
    }

}
