package com.fh.params.user;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fh.po.page.PageBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserSearchParams extends PageBean implements Serializable {
    private String loginname;
    private String realname;

    private Integer minage;
    private Integer maxage;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minJointime;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxJointime;
    private Double minpay;
    private Double maxpay;
    private String roleIds;
    private List<Integer> list=new ArrayList<>();
    private int size;
    private Long s1;
    private Long s2;
    private Long s3;

    public Long getS1() {
        return s1;
    }

    public void setS1(Long s1) {
        this.s1 = s1;
    }

    public Long getS2() {
        return s2;
    }

    public void setS2(Long s2) {
        this.s2 = s2;
    }

    public Long getS3() {
        return s3;
    }

    public void setS3(Long s3) {
        this.s3 = s3;
    }

    public String getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String roleIds) {
        this.roleIds = roleIds;
    }

    public List<Integer> getList() {
        return list;
    }

    public void setList(List<Integer> list) {
        this.list = list;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public Integer getMinage() {
        return minage;
    }

    public void setMinage(Integer minage) {
        this.minage = minage;
    }

    public Integer getMaxage() {
        return maxage;
    }

    public void setMaxage(Integer maxage) {
        this.maxage = maxage;
    }

    public Date getMinJointime() {
        return minJointime;
    }

    public void setMinJointime(Date minJointime) {
        this.minJointime = minJointime;
    }

    public Date getMaxJointime() {
        return maxJointime;
    }

    public void setMaxJointime(Date maxJointime) {
        this.maxJointime = maxJointime;
    }

    public Double getMinpay() {
        return minpay;
    }

    public void setMinpay(Double minpay) {
        this.minpay = minpay;
    }

    public Double getMaxpay() {
        return maxpay;
    }

    public void setMaxpay(Double maxpay) {
        this.maxpay = maxpay;
    }
}
