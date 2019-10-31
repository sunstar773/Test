package com.fh.interceptor;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fh.biz.menu.MenuService;
import com.fh.po.common.Cons;
import com.fh.po.menu.Menu;
import com.fh.po.user.User;
import com.fh.util.DistributedSession;
import com.fh.util.KeyUtil;
import com.fh.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class menuInterceptor  extends HandlerInterceptorAdapter {
    @Resource
    private MenuService menuService;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
            /*获取当前请求*/
        String servletPath = request.getServletPath();
       // HttpSession session = request.getSession();
        boolean pubMethod=false;
          // List<Menu> allMenuList= (List<Menu>) session.getAttribute(Cons.ALL_MENU);
        String session1 = DistributedSession.getSession(request, response);
        String s1 = RedisUtil.get(KeyUtil.allMenuKey(session1));
        List<Menu> allMenuList = JSON.parseArray(s1, Menu.class);
        for (Menu menu : allMenuList) {
            if (StringUtils.isNotEmpty(menu.getMenuurl()) && menu.getMenuurl().contains(servletPath) ){
                pubMethod=true;
                break;
            }
        }
        if (!pubMethod){
            return  true;
        }
      /*  User u = (User) session.getAttribute(Cons.USER_SESSION);
            List<String> list=menuService.queryMenuUrl(u.getId());*/
        boolean da=false;
        //List<Menu> buttonList= (List<Menu>) session.getAttribute(Cons.USER_ALL_MENU);
        String s2 = RedisUtil.get(KeyUtil.userAllMenuKey(session1));
        List<Menu> buttonList = JSON.parseArray(s2, Menu.class);
        for (Menu menu : buttonList) {
                if (StringUtils.isNotEmpty(menu.getMenuurl()) && servletPath.contains(menu.getMenuurl())){
                    da=true;
                    return da;
                }
        }
            if (StringUtils.isNotEmpty(request.getHeader("X-Requested-With") )&& request.getHeader("X-Requested-With").equals("XMLHttpRequest") ){
                 Map map=new HashMap();
                 map.put("code",-10000);
                 map.put("msg",Cons.ALERT_NOMENU);
                String s = JSONObject.toJSONString(map);
                 resp(s,response);
                 return da;
            }else {
               response.sendRedirect(Cons.NO_MENU);
               return da;
            }

    }
    public void resp(String json,HttpServletResponse response){
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter writer=null;
        try {
             writer = response.getWriter();
             writer.write(json);
             writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (writer!=null){
                writer.close();
            }
        }
    }
}
