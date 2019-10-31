package com.fh.po.common;

import java.io.Serializable;

public enum ResponseEnum implements Serializable {
    ERROR(-1, "error"),
    USERNAME_USERPWD_IS_EMPTY(100, "用户名或密码或验证码为空"),
    USERNAME_IS_EXIST(101, "用户名不存在"),
    USERPWD_IS_ERROR(102, "密码错误"),
    USER_IS_LOCK(103, "账号已经被锁定,请明天再试"),
    USERPWD_IS_ERROR2(104, "密码错误,还有2次机会"),
    USERPWD_IS_ERROR3(105, "密码错误,还有1次机会"),
    UPDATE_PASSWROD_ISNULL(106, "原密码或新密码不能为空"),
    OLDPASSWORD_IS_ERROR(107, "原密码不正确"),
    PASSWORD_IS_DIFFERENT(108,"新密码与确认密码不同"),
    USER_IS_NULL(109,"该用户不存在"),
    EMAIL_IS_NULL(110,"邮箱不存在"),
    IMGCODE_IS_ERROR(111,"验证码不正确"),
    SUCCESS(200, "ok");
    private int code;
     private String msg;

    public int getCode() {
        return code;
    }

    ResponseEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public String getMsg() {
        return msg;
    }


}
