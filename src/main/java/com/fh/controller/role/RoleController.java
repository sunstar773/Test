package com.fh.controller.role;

import com.fh.biz.role.RoleService;
import com.fh.po.common.DateTable;
import com.fh.po.common.ServerResponse;
import com.fh.po.role.Role;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class RoleController {
    @Resource(name = "roleService")
    private RoleService roleService;

     @RequestMapping("toRoleList")
    public String toRoleList(){
        return "role/roleList";
    }
    @RequestMapping("queryRoleList")
    @ResponseBody
    public ServerResponse queryRoleList(Role role){
        DateTable dateTable=roleService.findRoleList(role);
      return ServerResponse.success(dateTable);
    }
    @RequestMapping("queryRlist")
    @ResponseBody
    public ServerResponse queryRlist(){
        List<Role>  list = roleService.queryRlist();
           return ServerResponse.success(list);
    }

    @RequestMapping("addRole")
    @ResponseBody
    public ServerResponse addRole(Role role){
            roleService.addRole(role);
            return ServerResponse.success();
    }
    @RequestMapping("deleteRole")
    @ResponseBody
    public ServerResponse  deleteRole(Long id){
            roleService.deleteRole(id);
            return ServerResponse.success();
    }

    @RequestMapping("getRole")
    @ResponseBody
    public ServerResponse getRole(Long id){
            Role role=  roleService.getRole(id);
            List<Integer> list=roleService.getMenuId(id);
            role.setList(list);
            return ServerResponse.success(role);
    }

    @RequestMapping("updateRole")
    @ResponseBody
    public ServerResponse updateRole(Role role){
            roleService.updateRole(role);
            return ServerResponse.success();
    }


}
