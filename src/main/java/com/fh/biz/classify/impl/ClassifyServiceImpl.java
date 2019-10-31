package com.fh.biz.classify.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.biz.classify.ClassifyService;
import com.fh.mapper.classify.ClassifyMapper;
import com.fh.po.classify.Classify;
import com.fh.util.RedisUtil;
import com.opensymphony.oscache.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("classifyService")
public class ClassifyServiceImpl implements ClassifyService {
    @Autowired
    private ClassifyMapper classifyMapper;
    @Override
    public List queryClassify(Long id) {
            QueryWrapper<Classify> objectQueryWrapper=null;
        if (id!=null){
            objectQueryWrapper = new QueryWrapper<>();
            objectQueryWrapper.eq("pid",id);
        }

        String classList = RedisUtil.get("classList");
        if (StringUtil.isEmpty(classList)){
               List list=classifyMapper.selectList(null);
            RedisUtil.set("classList",JSON.toJSONString(list));
            List childList = findChild(id, list);

            return childList;
        }
        List childList = findChild(id, JSON.parseArray(classList));
        return childList;
    }
    public List findChild(Long id,List list){
        QueryWrapper<Classify> objectQueryWrapper=null;
        if (id!=null){
            objectQueryWrapper = new QueryWrapper<>();
            objectQueryWrapper.eq("pid",id);
        }
        List childRenList=classifyMapper.selectList(objectQueryWrapper);
        return childRenList;
    }

    @Override
    public void addClass(Classify classify) {
        classifyMapper.addClass(classify);
    }

    @Override
    public void deleteClass(List<Integer> ids) {
        classifyMapper.deleteClass(ids);
    }

    @Override
    public void updateClass(Classify classify) {
        classifyMapper.updateById(classify);
    }
}
