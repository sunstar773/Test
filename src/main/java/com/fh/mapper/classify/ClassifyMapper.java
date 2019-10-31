package com.fh.mapper.classify;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.po.classify.Classify;

import java.util.List;

public interface ClassifyMapper extends BaseMapper<Classify> {
    void addClass(Classify classify);

    void deleteClass(List<Integer> ids);

    String selectClassNameById(Long id);
}
