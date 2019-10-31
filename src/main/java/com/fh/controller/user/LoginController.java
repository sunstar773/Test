package com.fh.controller.user;

import com.alibaba.fastjson.JSON;
import com.fh.biz.product.ProductService;
import com.fh.biz.user.UserService;
import com.fh.po.common.Cons;
import com.fh.po.common.ResponseEnum;
import com.fh.po.common.ServerResponse;
import com.fh.po.menu.Menu;
import com.fh.po.product.Product;
import com.fh.po.user.User;
import com.fh.test.SendEmail;
import com.fh.util.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

import static com.fh.util.Md5Util.encodePassword;

@Controller
@RequestMapping("loginController")
public class LoginController {
    @Resource(name = "userService")
    private UserService userService;
     @Autowired
     private HttpServletResponse respon;
    @Autowired
    private ProductService productService;
    @RequestMapping("login")
    @ResponseBody
    public ServerResponse login(User user, HttpServletRequest request){
        String loginname= user.getLoginname();
        String password = user.getPassword();
        /*判断账号密码是否为空*/
        if (StringUtils.isEmpty(loginname) || StringUtils.isEmpty(user.getPassword() )||StringUtils.isEmpty(user.getImgCode())){
            return ServerResponse.error(ResponseEnum.USERNAME_USERPWD_IS_EMPTY);
        }
       // String session1 =(String) request.getSession().getAttribute("checkcode");
        String session1 = DistributedSession.getSession(request, respon);
        String s = RedisUtil.get(KeyUtil.codeKey(session1));
        if (!user.getImgCode().equalsIgnoreCase(s)){
            return ServerResponse.error(ResponseEnum.IMGCODE_IS_ERROR);
        }
        User user1=userService.queryUserByName(user.getLoginname());
        /*判断账号是否存在*/
        if (user1==null){
            return ServerResponse.error(ResponseEnum.USERNAME_IS_EXIST);
        }
        /*判断账号 是否被锁定*/
        if (user1.getErrorCount()==Cons.LOCK_COUNT){
            return ServerResponse.error(ResponseEnum.USER_IS_LOCK);
        }
        /*判断密码是否正确*/
        String salt = user1.getSalt();
        if (!Md5Util.encodePassword(password, salt).equals(user1.getPassword())){
            System.out.println(Md5Util.encodePassword(password, user1.getSalt()));
            /*账号没有被锁定  错误次数才会+1*/
            if (user1.getErrorCount()<Cons.LOCK_COUNT){
                /*密码错误，错误次数+1*/
                user1.setErrorCount(user1.getErrorCount()+1);
                userService.updateUserr(user1);
            }
            /*错误次数大于2   账号锁定*/
            if (user1.getErrorCount()==Cons.LOCK_COUNT){
                try {
                    SendEmail.SendQQEmail(Cons.USER_LOCK,user1.getEmail(),Cons.EMAIL_PASSWORD_ERROR);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return ServerResponse.error(ResponseEnum.USER_IS_LOCK);
            }
            if (user1.getErrorCount()==1){
                return ServerResponse.error(ResponseEnum.USERPWD_IS_ERROR2);
            }
            if (user1.getErrorCount()==2){
                return ServerResponse.error(ResponseEnum.USERPWD_IS_ERROR3);
            }
            return ServerResponse.error(ResponseEnum.USERPWD_IS_ERROR);
        }else {

                /* //创建当天凌晨零点时间戳
                 long nowTime = System.currentTimeMillis();
                 long todayStartTime = nowTime - (nowTime + TimeZone.getDefault().getRawOffset()) % (1000 * 3600 * 24);*/
            User user2 = new User();
            user2.setId(user1.getId());
            if (user1.getLoginTime()!=null){
                /*【当天零点】 大于【上次登陆时间】     则是今天第一次*/
                  /*   if (todayStartTime > user1.getLoginTime().getTime()) {
                         user1.setLoginCount(1);
                         user2.setLoginCount(1);
                     }
                     *//*【当天零点】 小于【上次登陆时间】     则是今天登陆次数+1*//*
                     if (todayStartTime < user1.getLoginTime().getTime()) {
                         user1.setLoginCount(user1.getLoginCount() + 1);
                         user2.setLoginCount(user1.getLoginCount());
                     }*/
                /*当前登陆时间*/
                Date current =  DateUtil.StringToDate(DateUtil.DateToString(new Date(),DateUtil.Y_M_D),DateUtil.Y_M_D);
                /*当前登陆时间    大于  上次登陆时间*/
                if (current.after(user1.getLoginTime())){
                    /*重置为1*/
                    user1.setLoginCount(1);
                    user2.setLoginCount(1);
                }else {
                    user1.setLoginCount(user1.getLoginCount() + 1);
                    user2.setLoginCount(user1.getLoginCount());
                }

            }else {
                user1.setLoginCount(1);
                user2.setLoginCount(1);
            }
            //HttpSession session = request.getSession();
            /*成功*/
            //session.setAttribute(Cons.USER_SESSION, user1);
             RedisUtil.setEx(KeyUtil.userKey(session1),JSON.toJSONString(user1),10*60);
             RedisUtil.del(KeyUtil.codeKey(session1));
            /*  查询所有权限  */
            List<Menu> list=userService.queryAllMenu();
            /*查询 用户 拥有的权限*/
            List<Menu> list1=userService.queryUserAllMenu(user1.getId());
           /* session.setAttribute(Cons.USER_ALL_MENU,list1);
            session.setAttribute(Cons.ALL_MENU,list);*/
           RedisUtil.setEx(KeyUtil.userAllMenuKey(session1),JSON.toJSONString(list1),10*60);
           RedisUtil.setEx(KeyUtil.allMenuKey(session1),JSON.toJSONString(list),10*60);
            /*登陆成功，错误次数清空*/
            user1.setErrorCount(0);
            userService.updateUserCount(user1.getId());
            user2.setLoginTime(new Date());
            userService.updateUserr(user2);
            return ServerResponse.success();


        }

    }



    @RequestMapping("loginOut")
    public String loginOut(HttpServletRequest request,HttpServletResponse response){
        // 清除session中的数据
        //request.getSession().invalidate();
        String session = DistributedSession.getSession(request, response);
        RedisUtil.delBatchKey(KeyUtil.userKey(session),KeyUtil.allMenuKey(session),KeyUtil.userAllMenuKey(session));
        return "redirect:/";
    }
    /*每天凌晨执行一次*/
    /*解锁用户*/
    @Scheduled(cron = "0 0 0 * * ?")
    public void clearLock() {
        userService.clearLock();
    }

    @Scheduled(cron = "0/10 * * * * ?")
    public void checkProductCount() throws Exception {
        List<Product> list=productService.queryProductCount();
        String str="<br>";
        for (Product product : list) {
            str+="商品名:"+product.getName()+"---价格："+product.getPrice()+"---库存："+product.getNum()+"<br>";
        }
        str+="<br>from：孙世达";
        SendEmail.SendQQEmail("商品库存不足！","532028476@qq.com",str);
    }

  /*  @Scheduled(cron = "0/1 * * * * ? ")
    public void s() {
        try {
            SendEmail.SendQQEmail("敲死你","932949717@qq.com","<font color='green'>sbsbsbsbs</font>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/
}
