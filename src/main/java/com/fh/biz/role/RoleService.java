package com.fh.biz.role;

import com.fh.po.common.DateTable;
import com.fh.po.page.PageBean;
import com.fh.po.role.Role;

import java.util.List;

public interface RoleService {


    void addRole(Role role);

    void deleteRole(Long id);

    Role getRole(Long id);

    void updateRole(Role role);

    List<Role> queryRlist();


    List<Integer> getMenuId(Long id);

    DateTable findRoleList(Role role);
}
