package com.fh.util;

import com.fh.po.common.Cons;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.UUID;

public class DistributedSession {
    public static  String getSession(HttpServletRequest request, HttpServletResponse response){
        String readCookie = CookieUtil.readCookie(Cons.COOK_NAME, request);
        if (StringUtils.isEmpty(readCookie)){
            //生成session
            readCookie = UUID.randomUUID().toString();
        }
        //写到客户端浏览器
        CookieUtil.writeCookie(Cons.COOK_NAME,readCookie,Cons.DOMAIN,response);
        return  readCookie;
    }
}
