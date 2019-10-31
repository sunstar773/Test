package com.fh.controller.product;

import com.fh.biz.product.ProductService;
import com.fh.controller.area.AreaController;
import com.fh.params.product.ProductSearch;
import com.fh.po.common.DateTable;
import com.fh.po.common.ServerResponse;
import com.fh.po.product.Product;
import com.fh.util.DownExcel;
import com.fh.util.FileUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class ProductController {
    @Resource(name="productService")
    private ProductService productService;
     @RequestMapping("queryProductList")
     @ResponseBody
    public DateTable queryProductList(ProductSearch product){
         DateTable dateTable=productService.findProductList(product);
         return  dateTable;
    }
    @RequestMapping("addProduct")
    @ResponseBody
    public ServerResponse addProduct(Product product){
            productService.addProduct( product);
           return ServerResponse.success();
    }
    @RequestMapping("deleteProduct")
    @ResponseBody
    public ServerResponse deleteProduct(Long id){
            productService.deleteProduct( id);
            return ServerResponse.success();
    }
    @RequestMapping("goUpdateProduct")
    @ResponseBody
    public ServerResponse goUpdateProduct(Long id){
            Product p=productService.getProduct( id);
            return ServerResponse.success(p);
    }
    @RequestMapping("updateProduct")
    @ResponseBody
    public  ServerResponse updateProduct(Product product){
            productService.updateProduct( product);
            return ServerResponse.success();
    }

    @RequestMapping("toProduct")
    public String toProduct(){
         return "product/productList";
    }

    @RequestMapping("updateButton")
    @ResponseBody
    public ServerResponse updateButton(Long id){
        Product p=productService.getProduct( id);
        if (p.getIsOut()==1){
            productService.updateButton(id);
            return ServerResponse.success();
        }else {
            productService.updateButton1(id);
            return ServerResponse.success();
        }

    }

    @RequestMapping("productExportExcel")
    public void exportExcel(ProductSearch productSearch, HttpServletResponse response){
         /*查出需要导出的 数据*/
         List<Product> list=productService.querySearchProductList(productSearch);
         /*把数据转为  workbook 类型 */
        String sheetName="商品信息";
        String[]heads={"id","商品名","价格","生产日期","品牌","分类"};
        String[] props={"id","name","price","createDate","brandName","selName"};
        Workbook workbook = DownExcel.buildWorkbook(sheetName, heads, props, Product.class, list);
        /*响应下载*/
        FileUtil.xlsDownloadFile(response, workbook);
    }
    @RequestMapping("productExportPdf")
    public void productExportPdf(ProductSearch productSearch, HttpServletResponse response,HttpServletRequest request){
        ByteArrayOutputStream byo=productService.buildByte(productSearch,request);
        FileUtil.pdfDownload(response, byo);
    }
    @RequestMapping("productExportWord")
    public void exportWord(ProductSearch productSearch,HttpServletRequest request,HttpServletResponse response)throws IOException, TemplateException {
        InputStream in=null;
        List<Product> list=productService.querySearchProductList( productSearch);
        // 第一步：创建一个Configuration对象，直接new一个对象。构造方法的参数就是freemarker对于的版本号。
        Configuration configuration = new Configuration(Configuration.getVersion());
        // 第二步：设置模板文件所在的路径。
        configuration.setDirectoryForTemplateLoading(new File("C:\\学习工具\\ftl"));
        // 第三步：设置模板文件使用的字符集。一般就是utf-8.
        configuration.setDefaultEncoding("utf-8");
        // 第四步：加载一个模板，创建一个模板对象。
        Template template = configuration.getTemplate("productWord.ftl");
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

}
