package com.fh.mapper.user;

import com.fh.params.user.UserSearchParams;
import com.fh.params.user.UserUpdatePassword;
import com.fh.po.menu.Menu;
import com.fh.po.role2user.RoleToUser;
import com.fh.po.user.User;
import com.fh.vo.user.UserVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    Long queryUserCount(UserSearchParams user);

    List<User> queryUserList(UserSearchParams user);

    void deleteUser(Long id);

    void addUser(User user);

    User goUpdateUser(Long id);

    void updateUser(User user);

    void roleToUser(RoleToUser roleToUser);

    List<String> queryRoleName(Long id);

    List<Long> findRole(Long id);

    void deleteUserDeRole(Long id);

    void deltBatch(List<Integer> list);

    User queryUserByName(String loginname);

    void updateUserr(User user);

    void clearLock();

    List<User> querySearchUserList(UserSearchParams userSearchParams);

    void updateUserCount(Long id);

    List<Menu> queryMenuById(Long id);

    List<Menu> queryAllMenu();

    List<Menu> queryButton(Long id);


    void updatePassword(@Param("s") String s,@Param("id") Long id);

    User findUserByEmail(String email);
}
