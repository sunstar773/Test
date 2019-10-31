package com.fh.util;

public class KeyUtil {
    public static String codeKey(String data){
        return "code:"+data;
    }
    public static String userKey(String data){
        return "user:"+data;
    }
    public static String userAllMenuKey(String data){
        return "userAllMenuKey:"+data;
    }

    public static String allMenuKey(String data){
        return "allMenuKey:"+data;
    }
}
