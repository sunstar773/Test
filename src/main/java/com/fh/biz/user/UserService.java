package com.fh.biz.user;

import com.fh.params.user.UserSearchParams;
import com.fh.params.user.UserUpdatePassword;
import com.fh.po.common.DateTable;
import com.fh.po.common.ServerResponse;
import com.fh.po.menu.Menu;
import com.fh.po.page.PageBean;
import com.fh.po.user.User;
import com.fh.vo.user.UserVo;
import org.apache.poi.ss.usermodel.Workbook;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface UserService {


    void deleteUser(Long id);

    void addUser(User user);

    UserVo goUpdateUser(Long id);

    void updateUser(User user);


    void deleteBatchUser(String ids);

    DateTable findUserList(UserSearchParams user);

    User queryUserByName(String loginname);

    void updateUserr(User user);

    void clearLock();


    List<UserVo> findExortList(UserSearchParams userSearchParams);

    void updateUserCount(Long id);

    List<Menu> queryMenuById(Long id);

    List<Menu> queryAllMenu();

    List<Menu> queryUserAllMenu(Long id);

    ServerResponse updatePassword(UserUpdatePassword userUpdatePassword);

    ServerResponse resetPassword(Long id) throws Exception;

    ServerResponse sendPassword(String email) throws Exception;

    List<UserVo> querySearchUserList(UserSearchParams userSearchParams);

    Workbook buildWorkbook(UserSearchParams userSearchParams, String sheetName, String[] heads, String[] pros, Class<UserVo> userClass, List<UserVo> list1);
}
