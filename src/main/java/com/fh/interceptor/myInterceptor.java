package com.fh.interceptor;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.fh.po.common.Cons;
import com.fh.po.user.User;
import com.fh.util.DistributedSession;
import com.fh.util.KeyUtil;
import com.fh.util.RedisUtil;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class myInterceptor  extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        /*HttpSession session = request.getSession();
        User u = (User) session.getAttribute(Cons.USER_SESSION);*/
        String session1 = DistributedSession.getSession(request, response);
        String u = RedisUtil.get(KeyUtil.userKey(session1));
        if (u!=null) {
             RedisUtil.setExpire(KeyUtil.userKey(session1),5*60);
             RedisUtil.setExpire(KeyUtil.userAllMenuKey(session1),5*60);
             RedisUtil.setExpire(KeyUtil.allMenuKey(session1),5*60);
            return true;
        }
        response.sendRedirect( Cons.USER_LOGIN);
        return false;
    }

}
