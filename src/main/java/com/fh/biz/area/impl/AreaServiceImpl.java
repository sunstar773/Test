package com.fh.biz.area.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.biz.area.AreaService;
import com.fh.mapper.area.AreaMapper;
import com.fh.po.area.Area;
import com.fh.po.classify.Classify;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("areaService")
public class AreaServiceImpl implements AreaService {
    @Autowired
    private AreaMapper areaMapper;
    @Override
    public List<Map<String, Object>> queryArea() {
        List<Area> list=areaMapper.queryArea();
        return areaTree("0",list);
    }

    @Override
    public void addArea(Area area) {
        areaMapper.addArea( area);
    }

    @Override
    public void updateArea(Area area) {
        areaMapper.updateArea( area);
    }

    @Override
    public List AreaList(Long id) {
        QueryWrapper<Area> objectQueryWrapper1=null;
        if (id!=null){
            objectQueryWrapper1 = new QueryWrapper<Area>();
            objectQueryWrapper1.eq("pid",id);
        }
        List<Area> list=areaMapper.selectList(objectQueryWrapper1);
        return list;
    }

    public List<Map<String, Object>> areaTree(String pid,List<Area> list){
        List<Map<String, Object>> areaList=new ArrayList<Map<String, Object>>();
        for (Area arList:list){
            Map<String, Object> map=null;
            if (pid.equals(String.valueOf(arList.getpId()))){
                map=new HashMap<>();
                map.put("id",arList.getId());
                map.put("name",arList.getName());
                map.put("children",areaTree(String.valueOf(arList.getId()),list));
            }
            if (map!=null){
                areaList.add(map);
            }
        }
        return areaList;
    }
}
