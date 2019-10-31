package com.fh.biz.area;

import com.fh.po.area.Area;

import java.util.List;
import java.util.Map;

public interface AreaService {
    List<Map<String,Object>> queryArea();

    void addArea(Area area);

    void updateArea(Area area);

    List AreaList(Long id);
}
