package com.fh.po.brand;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fh.po.page.PageBean;

import java.io.Serializable;

public class Brand extends PageBean implements Serializable {
    private  Long id;
    private String name;
    private String imgurl;
    private  Integer isHot;
    private Integer sort;

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getIsHot() {
        return isHot;
    }

    public void setIsHot(Integer isHot) {
        this.isHot = isHot;
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

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }
}
