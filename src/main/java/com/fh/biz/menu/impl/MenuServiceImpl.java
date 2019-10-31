package com.fh.biz.menu.impl;

import com.fh.biz.menu.MenuService;
import com.fh.mapper.menu.MenuMapper;
import com.fh.po.menu.Menu;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
    @Resource
    private MenuMapper menuMapper;
    @Override
    public List<Menu> queryMenuList() {
        return menuMapper.queryMenuList() ;
    }

    @Override
    public void addMenu(Menu menu) {
        menuMapper.addMenu( menu);
    }

    @Override
    public void deleteMenu(List<Integer> ids) {
        menuMapper.deleteMenuAndRole(ids);
        menuMapper.deleteMenu( ids);
    }

    @Override
    public void updateMenu(Menu menu) {
        menuMapper.updateMenu( menu);
    }

    @Override
    public List<String> queryMenuUrl(Long id) {
        return menuMapper.queryMenuUrl( id);
    }
}
