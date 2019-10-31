package com.fh.po.member;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Member {
    private Long id;
    private String name;
    private String password;
    private String realname;
    private String phone;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;
    @TableField(exist = false)
    private String areaName;
    private Long c1;
    private Long c2;
    private Long c3;

    public Long getC1() {
        return c1;
    }

    public void setC1(Long c1) {
        this.c1 = c1;
    }

    public Long getC2() {
        return c2;
    }

    public void setC2(Long c2) {
        this.c2 = c2;
    }

    public Long getC3() {
        return c3;
    }

    public void setC3(Long c3) {
        this.c3 = c3;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }
}
