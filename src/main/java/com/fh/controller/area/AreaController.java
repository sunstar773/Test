package com.fh.controller.area;

import com.fh.biz.area.AreaService;
import com.fh.controller.user.UserController;
import com.fh.po.area.Area;
import com.fh.po.common.ServerResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AreaController {
    @Resource(name = "areaService")
    private AreaService areaService;
         @RequestMapping("queryArea")
         @ResponseBody
         public List<Map<String,Object>> queryArea(){
           return areaService.queryArea();
         }
    @RequestMapping("goAreaList")
    public String goAreaList(){
        return "area/areaList";
    }
    @RequestMapping("AreaList")
    @ResponseBody
    public ServerResponse AreaList(Long id){
             List list=areaService.AreaList( id);
             return ServerResponse.success(list);
    }



    @RequestMapping("addArea")
    @ResponseBody
         public ServerResponse addArea(Area area){
            areaService.addArea( area);
            return   ServerResponse.success(area.getId());
         }
    @RequestMapping("updateArea")
    @ResponseBody
         public ServerResponse updateArea(Area area){
            areaService.updateArea( area);
            return   ServerResponse.success();
         }
}
