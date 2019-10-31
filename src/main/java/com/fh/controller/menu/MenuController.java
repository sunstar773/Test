package com.fh.controller.menu;

import com.fh.biz.menu.MenuService;
import com.fh.controller.area.AreaController;
import com.fh.po.common.ServerResponse;
import com.fh.po.menu.Menu;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
public class MenuController {
    @Resource(name = "menuService")
    private MenuService menuService;
    @RequestMapping("queryMenuList")
    @ResponseBody
    public ServerResponse queryMenuList(){
            List<Menu> list=menuService.queryMenuList();
            return ServerResponse.success(list);
    }
    @RequestMapping("toMenuList")
    public String toMenuList(){
        return "menu/index";
    }
    @RequestMapping("addMenu")
    @ResponseBody
    public ServerResponse addMenu(Menu menu){
            menuService.addMenu( menu);
            return ServerResponse.success(menu.getId());
    }
    @RequestMapping("deleteMenu")
    @ResponseBody
    public ServerResponse deleteMenu(@RequestParam("ids[]") List<Integer> ids){
            menuService.deleteMenu(ids);
            return ServerResponse.success();
    }
    @RequestMapping("updateMenu")
    @ResponseBody
    public ServerResponse updateMenu(Menu menu){
            menuService.updateMenu( menu);
            return ServerResponse.success();
    }
}
