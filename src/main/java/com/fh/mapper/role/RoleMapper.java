package com.fh.mapper.role;

import com.fh.po.menu2role.MenuToRole;
import com.fh.po.role.Role;

import java.util.List;

public interface RoleMapper {
    Long queryRoleCount();

    List<Role> queryRoleList(Role role);

    void addRole(Role role);

    void deleteRole(Long id);

    Role getRole(Long id);

    void updateRole(Role role);

    List<Role> queryRlist();

    void addMenuToRole(MenuToRole menuToRole);

    List<String> queryMenuNames(Long id);

    List<Integer> getMenuId(Long id);

    void deleteRoleMenu(Long id);

    void addMenuToRoleList(List<MenuToRole> list);
}
