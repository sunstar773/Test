package com.fh.biz.user.impl;

import com.fh.biz.user.UserService;
import com.fh.mapper.user.UserMapper;
import com.fh.params.user.UserSearchParams;
import com.fh.params.user.UserUpdatePassword;
import com.fh.po.common.Cons;
import com.fh.po.common.DateTable;
import com.fh.po.common.ResponseEnum;
import com.fh.po.common.ServerResponse;
import com.fh.po.menu.Menu;
import com.fh.po.role2user.RoleToUser;
import com.fh.po.user.User;
import com.fh.test.SendEmail;
import com.fh.util.Md5Util;
import com.fh.vo.user.UserVo;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.*;

@Service("userService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;


    @Override
    public void deleteUser(Long id) {
        userMapper.deleteUser( id);
    }

    @Override
    public void addUser(User user) {
        userMapper.addUser( user);
        addUserRole(user);

    }

    private void addUserRole(User user) {
        String ids = user.getIds();
        if (StringUtils.isNotEmpty(ids)){
        String[] split = ids.split(",");
        for (int i=0;i<split.length;i++){
            RoleToUser roleToUser=new RoleToUser();
            roleToUser.setUserid(user.getId());
            roleToUser.setRoleid(Long.parseLong(split[i]));
            userMapper.roleToUser(roleToUser);
        }
        }
    }

    @Override
    public UserVo goUpdateUser(Long id) {
        User user1=userMapper.goUpdateUser( id);
        UserVo userVo=new UserVo();
        userVo.setId(user1.getId());
        userVo.setAge(user1.getAge());
        userVo.setEmail(user1.getEmail());
        userVo.setLoginname(user1.getLoginname());
        userVo.setPassword(user1.getPassword());
        userVo.setPhone(user1.getPhone());
        userVo.setRealname(user1.getRealname());
        userVo.setSex(user1.getSex());
        userVo.setPay(user1.getPay());
        userVo.setJointime(user1.getJointime());
        userVo.setImgurl(user1.getImgurl());
        userVo.setSelName(user1.getSelName());
         List<Long> list= userMapper.findRole(id);
        if (list!=null && list.size()>0){
            String join = StringUtils.join(list,",");
            userVo.setRoleIds(join);
        }
        return userVo;
    }

    @Override
    public void updateUser(User user) {
        userMapper.deleteUserDeRole(user.getId());
        userMapper.updateUser( user);
        addUserRole(user);
    }


  /*批量删除*/
    @Override
    public void deleteBatchUser(String ids) {
        if (StringUtils.isNotEmpty(ids)){
            String[] split = ids.split(",");
            List<Integer> list=new ArrayList<>();
            for (int a=0;a<split.length;a++){
                 list.add(Integer.valueOf(split[a]));
            }
            userMapper.deltBatch(list);
        }
    }

    @Override
    public DateTable findUserList(UserSearchParams user) {
        /*roleids   List*/
        buildRoleList(user);
        /*分页查询*/
        List<User> list=userMapper.queryUserList(user);
        /*po转vo*/
        List<UserVo> list1 = getUserVos(list);
        /*查询总条数*/
        Long queryUserCount = userMapper.queryUserCount(user);
        DateTable dateTable=new DateTable(user.getDraw(),queryUserCount,queryUserCount,list1);
        return dateTable;
    }
    @Override
    public User queryUserByName(String loginname) {
        return userMapper.queryUserByName(loginname);
    }

    @Override
    public void updateUserr(User user) {
        userMapper.updateUserr( user);
    }

    @Override
    public void clearLock() {
        userMapper.clearLock();
    }


    /*导出   创建workbook*/
    @Override
    public Workbook buildWorkbook(UserSearchParams userSearchParams,String sheetName,String[]heads,String[]pros,Class clazz, List list) {
        XSSFWorkbook xw=new XSSFWorkbook();
        XSSFSheet createSheet = xw.createSheet(sheetName);
        XSSFRow createRow = createSheet.createRow(0);
        getHead(createRow,heads);
        /*创建日期格式*/
        XSSFCellStyle dateStyle = xw.createCellStyle();
        dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        /*创建数值格式*/
        XSSFCellStyle priceStyle = xw.createCellStyle();
        priceStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
       Map<String,XSSFCellStyle> map=new HashMap();
       map.put("dateStyle",dateStyle);
       map.put("priceStyle",priceStyle);
        /*创建内容*/
        createBody(list, createSheet,pros,clazz,map);
        return xw;
    }

    private void createBody(List list, XSSFSheet createSheet,String[]pros,Class clazz, Map<String,XSSFCellStyle> map) {
        for (int i = 0; i <list.size(); i++) {
            Object object = list.get(i);
            XSSFRow createRow1 = createSheet.createRow(i+1);
            for (int j = 0; j < pros.length; j++) {
                 String s=pros[j];
                try {
                    Field declaredField = clazz.getDeclaredField(s);
                    declaredField.setAccessible(true);
                    Object o = declaredField.get(object);
                    Class<?> type = declaredField.getType();
                    if (type==java.lang.String.class){
                        createRow1.createCell(j).setCellValue(o.toString());
                    }
                    if (type==java.util.Date.class){
                        XSSFCell cell = createRow1.createCell(j);
                        cell.setCellValue((Date) o);
                        cell.setCellStyle(map.get("dateStyle"));
                    }
                    if (type==java.lang.Integer.class){
                        createRow1.createCell(j).setCellValue(Integer.valueOf(o.toString()));
                    }
                    if (type==java.math.BigDecimal.class){
                        XSSFCell cell = createRow1.createCell(j);
                        cell.setCellValue(((BigDecimal) o).doubleValue());
                        cell.setCellStyle(map.get("priceStyle"));
                    }
                    if (type==java.lang.Long.class){
                        createRow1.createCell(j).setCellValue(Long.valueOf(o.toString()));
                    }
                } catch (NoSuchFieldException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void getHead(XSSFRow createRow,String[]heads) {
        for (int i = 0; i <heads.length ; i++) {
            createRow.createCell(i).setCellValue(heads[i]);
        }
    }

    @Override
    public List<UserVo> findExortList(UserSearchParams userSearchParams) {
        /*roleids   List*/
        buildRoleList(userSearchParams);
        /*分页查询*/
        List<User> list1=userMapper.querySearchUserList(userSearchParams);
        /*po转vo*/
        List<UserVo> list = getUserVos(list1);
        return list;
    }

    @Override
    public void updateUserCount(Long id) {
        userMapper.updateUserCount(id);
    }

    @Override
    public List<Menu> queryMenuById(Long id) {

        return  userMapper.queryMenuById( id);
    }

    @Override
    public List<Menu> queryAllMenu() {
        return userMapper.queryAllMenu();
    }

    @Override
    public List<Menu> queryUserAllMenu(Long id) {
        return userMapper.queryButton( id) ;
    }

    @Override
    public ServerResponse updatePassword(UserUpdatePassword userUpdatePassword) {
        /*判断是否为空*/
        if (StringUtils.isEmpty(userUpdatePassword.getOldPassword())|| StringUtils.isEmpty(userUpdatePassword.getNewPassword())||StringUtils.isEmpty(userUpdatePassword.getConfirmPassword())){
            return ServerResponse.error(ResponseEnum.UPDATE_PASSWROD_ISNULL);
        }
        User user = userMapper.goUpdateUser(userUpdatePassword.getId());
        String salt = user.getSalt();
        if (!Md5Util.encodePassword(userUpdatePassword.getOldPassword(),salt).equals(user.getPassword())){
            System.out.println(Md5Util.encodePassword(userUpdatePassword.getNewPassword(),salt));
            System.out.println(user.getPassword());
            return ServerResponse.error(ResponseEnum.OLDPASSWORD_IS_ERROR);
        }
        if (!userUpdatePassword.getNewPassword().equals(userUpdatePassword.getConfirmPassword())){
            return ServerResponse.error(ResponseEnum.PASSWORD_IS_DIFFERENT);
        }
        userMapper.updatePassword(Md5Util.encodePassword(userUpdatePassword.getNewPassword(),salt),user.getId());
        return ServerResponse.success();
    }

    @Override
    public ServerResponse resetPassword(Long id) throws Exception {
        User user = userMapper.goUpdateUser(id);
        if (user==null) {
            return ServerResponse.error(ResponseEnum.USER_IS_NULL);
        }
            String salt = user.getSalt();
            String s = Md5Util.encodePassword(Cons.EMAIL_PASSWORD, salt);
            SendEmail.SendQQEmail(Cons.PASSWORD_RESET,user.getEmail(), Cons.EMAIL_PASSWORD_RESET);
            userMapper.updatePassword(s, id);

        return ServerResponse.success();

    }

    @Override
    public ServerResponse sendPassword(String email) throws Exception {
        User user= userMapper.findUserByEmail(email);
        if (user==null){
            return ServerResponse.error(ResponseEnum.EMAIL_IS_NULL);
        }
        /*生成随机密码*/
        String randomAlphabetic = RandomStringUtils.randomAlphabetic(6);
        /*把密码发送到邮箱*/
        SendEmail.SendQQEmail("找回密码",email,"您的新密码为："+randomAlphabetic);
        /*把密码加密保存到数据库*/
        String encodePassword = Md5Util.encodePassword(randomAlphabetic, user.getSalt());
        userMapper.updatePassword(encodePassword,user.getId());
        return ServerResponse.success();
    }

    @Override
    public List<UserVo> querySearchUserList(UserSearchParams userSearchParams) {
        /*roleids   List*/
        buildRoleList(userSearchParams);
        /*分页查询*/
        List<User> list1=userMapper.querySearchUserList(userSearchParams);
        /*po转vo*/
        List<UserVo> list = getUserVos(list1);
        return list;
    }


    private void buildRoleList(UserSearchParams user) {
        String roleIds = user.getRoleIds();
        if (StringUtils.isNotEmpty(roleIds)){
            String[] split = roleIds.split(",");
            List<Integer> list=null;
            for (int i=0;i<split.length;i++){
                list = user.getList();
                list.add(Integer.valueOf(split[i]));
            }
            user.setList(list);
            user.setSize(list.size());
        }
    }

    private List<UserVo> getUserVos(List<User> list) {
        List<UserVo> list1=new ArrayList<>();
        for (User user1 : list) {
            UserVo userVo=new UserVo();
            userVo.setId(user1.getId());
            userVo.setAge(user1.getAge());
            userVo.setEmail(user1.getEmail());
            userVo.setLoginname(user1.getLoginname());
            userVo.setPassword(user1.getPassword());
            userVo.setPhone(user1.getPhone());
            userVo.setRealname(user1.getRealname());
            userVo.setSex(user1.getSex());
            userVo.setPay(user1.getPay());
            userVo.setJointime(user1.getJointime());
            userVo.setImgurl(user1.getImgurl());
            userVo.setIslock(user1.getErrorCount()==Cons.LOCK_COUNT);
            userVo.setSelName(user1.getSelName());
            List<String> roleList=userMapper.queryRoleName(user1.getId());
            if (roleList!=null && roleList.size()>0){
                String join = StringUtils.join(roleList,",");
                userVo.setRoleName(join);
            }
            list1.add(userVo);
        }
        return list1;
    }
}
