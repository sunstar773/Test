package com.fh.mapper.menu;

import com.fh.po.menu.Menu;

import java.util.List;

public interface MenuMapper {
    List<Menu> queryMenuList();

    void addMenu(Menu menu);

    void deleteMenu(List<Integer> ids);

    void updateMenu(Menu menu);

    void deleteMenuAndRole(List<Integer> ids);

    List<String> queryMenuUrl(Long id);
}
