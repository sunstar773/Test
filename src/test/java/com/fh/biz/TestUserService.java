/*
package com.fh.biz;

import com.fh.biz.user.UserService;
import com.fh.params.user.UserSearchParams;
import com.fh.po.common.DateTable;
import com.fh.po.user.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-common.xml"})
public class TestUserService extends AbstractJUnit4SpringContextTests {
         @Resource(name = "userService")
         private UserService userService;
         @Test
        public void addUser(){
                User user=new User();
                user.setLoginname("测试");
                user.setPassword("123");
                user.setRealname("猴子");
                userService.addUser(user);
        }
        @Test
        public void queryUser(){
                UserSearchParams userSearchParams=new UserSearchParams();
                userSearchParams.setDraw(1);
                userSearchParams.setStart(0);
                userSearchParams.setLength(5);
                DateTable userList = userService.findUserList(userSearchParams);
                System.out.println(userList);
        }

}
*/
