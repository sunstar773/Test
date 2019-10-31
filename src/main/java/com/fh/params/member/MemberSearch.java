package com.fh.params.member;

import com.fh.po.page.PageBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class MemberSearch extends PageBean {
    private String  name;
    private String realname;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minBirthday;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxBirthday;
    private Long c1;
    private Long c2;
    private Long c3;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public Date getMinBirthday() {
        return minBirthday;
    }

    public void setMinBirthday(Date minBirthday) {
        this.minBirthday = minBirthday;
    }

    public Date getMaxBirthday() {
        return maxBirthday;
    }

    public void setMaxBirthday(Date maxBirthday) {
        this.maxBirthday = maxBirthday;
    }

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
}
