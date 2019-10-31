package com.fh.po.common;

import java.io.Serializable;

public class ServerResponse implements Serializable {
    private int code;
    private String msg;
    private Object data;

    public static ServerResponse success(){
        return new ServerResponse(200,"ok",null);
    }
    public static ServerResponse success(Object data){
        return new ServerResponse(200,"ok",data);
    }
    public static ServerResponse error(){
        return new ServerResponse(-1,"error",null);
    }
    public static ServerResponse error(ResponseEnum responseEnum){
        return new ServerResponse(responseEnum.getCode(),responseEnum.getMsg(),null);
    }

    private ServerResponse(int code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
    private ServerResponse(){}
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
