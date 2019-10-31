package com.fh.controller;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

import java.io.IOException;

public class HttpClient {
    public static void main(String[] args) throws IOException {

        //打开浏览器
        CloseableHttpClient build = HttpClientBuilder.create().build();
        CloseableHttpResponse execute ;
        HttpEntity entity ;
        //地址栏输入 地址
        HttpGet httpGet = new HttpGet("http://news.baidu.com/");
        try {
            //敲回车
            execute = build.execute(httpGet);
            //获取内容
            entity = execute.getEntity();
            //输出到控制台
            String s = EntityUtils.toString(entity, "utf-8");
            System.out.println(s);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            if (null==build){
                build.close();;
            }
        }
    }
}
