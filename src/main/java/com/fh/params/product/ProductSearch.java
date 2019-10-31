package com.fh.params.product;

import com.fh.po.page.PageBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class ProductSearch extends PageBean implements Serializable {
     private String name;
     private Double minprice;
     private Double maxprice;
    @DateTimeFormat(pattern = "yyyy-MM-dd" )
     private Date mindate;
    @DateTimeFormat(pattern = "yyyy-MM-dd" )
     private Date maxdate;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getMinprice() {
        return minprice;
    }

    public void setMinprice(Double minprice) {
        this.minprice = minprice;
    }

    public Double getMaxprice() {
        return maxprice;
    }

    public void setMaxprice(Double maxprice) {
        this.maxprice = maxprice;
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
}
