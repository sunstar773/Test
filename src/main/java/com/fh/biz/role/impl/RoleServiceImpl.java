package com.fh.biz.role.impl;

import com.fh.biz.role.RoleService;
import com.fh.mapper.role.RoleMapper;
import com.fh.po.common.DateTable;
import com.fh.po.menu2role.MenuToRole;
import com.fh.po.page.PageBean;
import com.fh.po.role.Role;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("roleService")
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public void addRole(Role role) {
        roleMapper.addRole( role);
        /*角色权限关联表增加*/
        String ids = role.getIds();
        String[] split = ids.split(",");
        for (int a=0;a<split.length;a++){
            MenuToRole menuToRole=new MenuToRole();
            menuToRole.setRoleid(role.getId());
            menuToRole.setMenuid(Long.parseLong(split[a]));
            roleMapper.addMenuToRole(menuToRole);
        }
    }

    @Override
    public void deleteRole(Long id) {
        roleMapper.deleteRole( id);
    }

    @Override
    public Role getRole(Long id) {

        return roleMapper.getRole( id);
    }

    @Override
    public void updateRole(Role role) {
        roleMapper.updateRole( role);

        /*增加角色的权限*/
        String ids=role.getIds();
        if (StringUtils.isNotEmpty(ids)){
            /*删除角色的所有权限*/
            roleMapper.deleteRoleMenu(role.getId());
            String[] split = ids.split(",");
            List<MenuToRole> list=new ArrayList<>();
            for (String s : split) {
                MenuToRole menuToRole=new MenuToRole();
                menuToRole.setMenuid(Long.parseLong(s));
                menuToRole.setRoleid(role.getId());
                list.add(menuToRole);

            }
            roleMapper.addMenuToRoleList(list);
        }

    }

    @Override
    public List<Role> queryRlist() {
        return roleMapper.queryRlist();
    }

    @Override
    public List<Integer> getMenuId(Long id) {
        return roleMapper.getMenuId( id);
    }

    @Override
    public DateTable findRoleList(Role role) {
        /*查询总条数*/
       Long count= roleMapper.queryRoleCount();
        List<Role> list1=roleMapper.queryRoleList(role);
        for (Role role1 : list1) {
            List<String> list=roleMapper.queryMenuNames(role1.getId());
            String join = StringUtils.join(list, ",");
            role1.setIds(join);
        }
        return new DateTable(role.getDraw(),count,count,list1);
    }

}
