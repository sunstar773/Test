package com.fh.controller.area;

import com.fh.biz.area.AreaService;
import com.fh.po.common.ServerResponse;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/areas")
public class AreaApi {
    @Resource(name = "areaService")
    private AreaService areaService;
    @GetMapping
    @CrossOrigin("*")
    public ServerResponse AreaList(Long id){
        List list=areaService.AreaList( id);
        return ServerResponse.success(list);
    }

}
