package com.fh.mapper.area;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.po.area.Area;

import java.util.List;

public interface AreaMapper extends BaseMapper<Area> {
    List<Area> queryArea();

    void addArea(Area area);

    void updateArea(Area area);
}
