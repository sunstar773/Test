package com.fh.controller.user;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fh.biz.user.UserService;
import com.fh.commons.CopyFile;
import com.fh.commons.Log;
import com.fh.params.user.UserSearchParams;
import com.fh.params.user.UserUpdatePassword;
import com.fh.po.common.DateTable;
import com.fh.po.common.ServerResponse;
import com.fh.po.menu.Menu;
import com.fh.po.user.User;
import com.fh.util.*;
import com.fh.vo.user.UserVo;
import com.itextpdf.text.BadElementException;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class UserController {
    @Resource(name = "userService")
    private UserService userService;
    @RequestMapping("toUserList")
    public String toUserList(){
        return "user/userList";
    }
   @Autowired
   private HttpServletResponse response;
    @Autowired
    private HttpServletRequest request;
    @RequestMapping("queryUserList")
    @ResponseBody
    public ServerResponse queryUserList(UserSearchParams user){
        DateTable dateTable=userService.findUserList(user);
        return ServerResponse.success(dateTable);
    }
    @Log("删除用户方法")
    @RequestMapping("deleteUser")
    @ResponseBody
    public ServerResponse deleteUser(Long id){
            userService.deleteUser(id);
          return   ServerResponse.success();
    }

    @Log("增加用户方法")
    @RequestMapping("addUser")
    @ResponseBody
    public ServerResponse addUser(User user){
       user.setSalt(UUID.randomUUID().toString());
       String solt=user.getSalt();
        user.setPassword(Md5Util.md5(Md5Util.md5(user.getPassword())+solt));
            userService.addUser(user);
            return   ServerResponse.success();
    }


    @RequestMapping("goUpdateUser")
    @ResponseBody
  public ServerResponse goUpdateUser(Long id){
            UserVo user=  userService.goUpdateUser(id);
            return   ServerResponse.success(user);
  } @Log("修改用户方法")
    @RequestMapping("updateUser")
    @ResponseBody
  public ServerResponse updateUser(User user){
            userService.updateUser(user);
            return   ServerResponse.success();

    }
    @RequestMapping("goMain")
    public String goMain(String url){
        if (StringUtils.isNotEmpty(url)){
           url= url.replace(":","/");
        }
        return url;
    }


    @RequestMapping("deleteBatchUser")
    @ResponseBody
    public ServerResponse deleteBatchUser(String ids){
            userService.deleteBatchUser( ids);
            return   ServerResponse.success();
    }
    @RequestMapping("exportExcel")
    public void exportExcel(UserSearchParams userSearchParams, HttpServletResponse response){
        List<UserVo> list1=userService.querySearchUserList(userSearchParams);
        String[]heads={"ID","地区"};
        String[]pros={"id","selName"};
        String sheetName="用户信息";
        Workbook workbook = DownExcel.buildWorkbook(sheetName, heads, pros, UserVo.class, list1);
        /* Workbook workbook = userService.buildWorkbook(userSearchParams, sheetName,heads,pros,User.class,list1);*/
        FileUtil.xlsDownloadFile(response, workbook);
    }
   @RequestMapping("exportPdf")
    public void exportPdf(HttpServletResponse response,HttpServletRequest request,UserSearchParams userSearchParams) throws BadElementException, MalformedURLException, IOException {
       //定义一个字节流数组
       ByteArrayOutputStream byo = new ByteArrayOutputStream();
       //查询到数据集合
       List<UserVo> list = userService.findExortList(userSearchParams);
       //创建一个doucment对象 文本对象
       Document document = new Document();
       document.setPageSize(PageSize.A4);
       //创建字体 设置为中文
       BaseFont font = null;
       //创建列的字体样式
       Font keyFont = null;
       try {
           font = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
           //创建列的字体样式
           keyFont = new Font(font, 10, Font.BOLD);
           //创建pdf文件
           PdfWriter.getInstance(document, byo);
       } catch (DocumentException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       } catch (IOException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }

       //设置一个表头数组
       String[] str = {"ID", "用户名", "头像", "真实姓名", "性别", "年龄", "手机号", "邮箱", "薪资", "入职 时间", "角色"};
       //设置书写器
       PdfPTable table = FileUtil.createTable(str.length);
       //打开文本对象
       document.open();
       //设置标题
       Font headFont = new Font(font, 25, Font.BOLD);
       //设置标题的颜色
       headFont.setColor(BaseColor.PINK);
       //创建标题
       PdfPCell headCell = FileUtil.createHeadline("用户信息", headFont);
       headCell.setExtraParagraphSpace(30);
       //放入书写器
       table.addCell(headCell);
       for (int i = 0; i < str.length; i++) {
           table.addCell(FileUtil.createCell(str[i], keyFont, Element.ALIGN_CENTER));
       }

       //把查询到的数据集合遍历到书写器里面
       for (int i = 0; i < list.size(); i++) {
           UserVo userVo = list.get(i);
           table.addCell(FileUtil.createCell(userVo.getId().toString(), keyFont, Element.ALIGN_CENTER));
           table.addCell(FileUtil.createCell(userVo.getLoginname(), keyFont, Element.ALIGN_CENTER));
           table.addCell(Image.getInstance(request.getServletContext().getRealPath("/") + userVo.getImgurl()));
           table.addCell(FileUtil.createCell(userVo.getRealname(), keyFont, Element.ALIGN_CENTER));
           table.addCell(FileUtil.createCell(userVo.getSex() == 1 ? "男" : "女", keyFont, Element.ALIGN_CENTER));
           table.addCell(FileUtil.createCell(userVo.getAge().toString(), keyFont, Element.ALIGN_CENTER));
           table.addCell(FileUtil.createCell(userVo.getPhone(), keyFont, Element.ALIGN_CENTER));
           table.addCell(FileUtil.createCell(userVo.getEmail(), keyFont, Element.ALIGN_CENTER));
           table.addCell(FileUtil.createCell(userVo.getPay().toString(), keyFont, Element.ALIGN_CENTER));
           table.addCell(FileUtil.createCell(new SimpleDateFormat().format(userVo.getJointime()), keyFont, Element.ALIGN_CENTER));
           table.addCell(FileUtil.createCell(userVo.getRoleName(), keyFont, Element.ALIGN_CENTER));

       }
       //放入文本对象
       try {
           document.add(table);
       } catch (DocumentException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }
       document.close();
       FileUtil.pdfDownload(response, byo);
   }
    @RequestMapping("exportWord")
   public void exportWord(UserSearchParams userSearchParams,HttpServletRequest request,HttpServletResponse response)throws IOException, TemplateException {

        InputStream in=null;
        List<UserVo> list=userService.findExortList(userSearchParams);
        // 第一步：创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
        Configuration configuration = new Configuration(Configuration.getVersion());
        // 第二步：设置模板文件所在的路径。
        configuration.setDirectoryForTemplateLoading(new File("C:\\学习工具\\ftl"));
        // 第三步：设置模板文件使用的字符集。一般就是utf-8.
        configuration.setDefaultEncoding("utf-8");
        // 第四步：加载一个模板，创建一个模板对象。
        Template template = configuration.getTemplate("product.ftl");
        // 第五步：创建一个模板使用的数据集，可以是pojo也可以是map。一般是Map。
        Map dataModel = new HashMap<>();


        for (int i = 0; i < list.size(); i++) {
            BASE64Encoder encoder = new BASE64Encoder();
            byte[] data = null;
            in=new FileInputStream(request.getServletContext().getRealPath("/")+list.get(i).getImgurl());
            data = new byte[in.available()];
            in.read(data);
            in.close();

            list.get(i).setImgurl(encoder.encode(data));
        }
        dataModel.put("list", list);
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/x-download");
        response.addHeader("Content-Disposition", "attachment;filename="+UUID.randomUUID().toString()+".doc");
        PrintWriter writer = response.getWriter();
         /*  // 第六步：创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名。
           Writer out = new FileWriter("C:\\学习工具\\"+new File(UUID.randomUUID().toString()+".doc"));*/
        // 第七步：调用模板对象的process方法输出文件。
        template.process(dataModel, writer);
        System.out.println("创建完成");
        // 第八步：关闭流。
        writer.close();
   }

    @RequestMapping("queryMenuById")
    @ResponseBody
   public List<Menu> queryMenuById(HttpServletRequest request){
        // User user= (User) request.getSession().getAttribute("u");
        String session = DistributedSession.getSession(request, response);
        String s = RedisUtil.get(KeyUtil.userKey(session));
        User user = JSONObject.parseObject(s, User.class);
        List<Menu> list=  userService.queryMenuById(user.getId());
        return list;
   }

    @RequestMapping("updateErrorCount")
    @ResponseBody
    @Log("用户账号解锁")
   public ServerResponse updateErrorCount(Long id){
        userService.updateUserCount(id);
        return ServerResponse.success();
   }
    @RequestMapping("goChangePassword")
   public String goChangePassword(){
        return "user/updatePassword";
   }
    @RequestMapping("updatePassword")
    @ResponseBody
   public ServerResponse updatePassword(UserUpdatePassword userUpdatePassword){
        ServerResponse serverResponse=userService.updatePassword(userUpdatePassword);
          return serverResponse;
   }
    @RequestMapping("resetPassword")
    @ResponseBody
   public ServerResponse resetPassword(Long id) throws Exception {
        ServerResponse serverResponse=userService.resetPassword(id);
        return serverResponse;
   }
    @RequestMapping("toFindPassword")
   public String toFindPassword(){
        return "user/forgetPassword";
   }
    @RequestMapping("sendPassword")
    @ResponseBody
   public ServerResponse sendPassword(String email) throws Exception {
        ServerResponse serverResponse=userService.sendPassword(email);
        return  serverResponse;
   }

   @RequestMapping("findUserInfo")
    @ResponseBody
    public ServerResponse findUserInfo(){
       String session = DistributedSession.getSession(request, response);
       String s = RedisUtil.get(KeyUtil.userKey(session));
       User user = JSONObject.parseObject(s, User.class);
       return ServerResponse.success(user);
   }

}
