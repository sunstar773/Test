package com.fh.params.log;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fh.po.page.PageBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class LogSearch extends PageBean implements Serializable {

    private String userName;
    private String realName;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date mindate;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date maxdate;
    private Integer status;
    private String info;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Date getMindate() {
        return mindate;
    }

    public void setMindate(Date mindate) {
        this.mindate = mindate;
    }

    public Date getMaxdate() {
        return maxdate;
    }

    public void setMaxdate(Date maxdate) {
        this.maxdate = maxdate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
