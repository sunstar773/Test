package com.fh.biz.menu;

import com.fh.po.menu.Menu;

import java.util.List;

public interface MenuService {
    List<Menu> queryMenuList();

    void addMenu(Menu menu);

    void deleteMenu(List<Integer> ids);

    void updateMenu(Menu menu);

    List<String> queryMenuUrl(Long id);
}
