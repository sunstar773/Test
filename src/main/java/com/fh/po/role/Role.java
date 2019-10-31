package com.fh.po.role;

import com.fh.po.page.PageBean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Role extends PageBean implements Serializable {

    private Long id;
    private String name;
    private String ids;

    private List<Integer> list=new ArrayList<>();

    public List<Integer> getList() {
        return list;
    }

    public void setList(List<Integer> list) {
        this.list = list;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
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
}
