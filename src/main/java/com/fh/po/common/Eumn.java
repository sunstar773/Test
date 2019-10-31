package com.fh.po.common;

import java.io.Serializable;

public enum Eumn implements Serializable {
    NAME(20,"sssss"),
    SUN(20,"sssss");
    private int code;
    private String msg;

    Eumn(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
