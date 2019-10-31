package com.fh.biz.product.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.fh.biz.product.ProductService;
import com.fh.mapper.classify.ClassifyMapper;
import com.fh.mapper.product.ProductMapper;
import com.fh.params.product.ProductSearch;
import com.fh.po.classify.Classify;
import com.fh.po.common.DateTable;
import com.fh.po.product.Product;
import com.fh.util.FileUtil;
import com.fh.util.RedisUtil;
import com.fh.vo.product.ProductVo;
import com.fh.vo.user.UserVo;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.opensymphony.oscache.util.StringUtil;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("productService")
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ClassifyMapper classifyMapper;
    @Override
    public void addProduct(Product product) {
        productMapper.addProduct( product);
    }

    @Override
    public void deleteProduct(Long id) {
        productMapper.deleteProduct( id);
    }

    @Override
    public Product getProduct(Long id) {
        Product product=productMapper.getProduct( id);
        String classList = RedisUtil.get("classList");
        if (!StringUtil.isEmpty(classList)){
            List<Classify> list = JSON.parseArray(classList,Classify.class);
            String s1=getClassById(product.getS1(),list);
            String s2=getClassById(product.getS2(),list);
            String s3=getClassById(product.getS3(),list);
            product.setSelName(s1+"-->"+s2+"-->"+s3);
        }
        else {
            List list=classifyMapper.selectList(null);
            String s1=getClassById(product.getS1(),list);
            String s2=getClassById(product.getS2(),list);
            String s3=getClassById(product.getS3(),list);
            product.setSelName(s1+"-->"+s2+"-->"+s3);
            RedisUtil.set("classList",s1+"-->"+s2+"-->"+s3);
        }
        return  product;
    }
    public String getClassById(Long id,List<Classify> list){

        for (Classify classify : list) {
            if(classify.getId()==id){
                return classify.getName();
            }
        }
        return "";
    }

    @Override
    public void updateProduct(Product product) {
        productMapper.updateProduct( product);
    }

    @Override
    public DateTable findProductList(ProductSearch product) {
        /*查询总条数*/
       Long count= productMapper.queryProductCount(product);
       /*查询分页*/
       List<Product> list=productMapper.queryProductList( product);
        List<ProductVo> objects = new ArrayList<>();
        for (Product product1 : list) {
            ProductVo productVo=new ProductVo();
            productVo.setId(product1.getId());
            productVo.setName(product1.getName());
            productVo.setCreateDate(product1.getCreateDate());
            productVo.setIsHot(product1.getIsHot());
            productVo.setIsOut(product1.getIsOut());
            productVo.setImgurl(product1.getImgurl());
            productVo.setNum(product1.getNum());
            productVo.setPrice(product1.getPrice());
            productVo.setBrandName(product1.getBrand().getName());
            productVo.setSelName(product1.getSelName());
            objects.add(productVo);
        }
        return new DateTable(product.getDraw(),count,count,objects);
    }

    @Override
    public void updateButton(Long id) {
        productMapper.updateButton( id);
    }

    @Override
    public void updateButton1(Long id) {
        productMapper.updateButton1( id);
    }



    @Override
    public ByteArrayOutputStream buildByte(ProductSearch productSearch, HttpServletRequest request) {
        //定义一个字节流数组
        ByteArrayOutputStream byo = new ByteArrayOutputStream();
        //查询到数据集合
        List<Product> list=productMapper.querySearchProductList( productSearch);
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
        String[] str = {"ID", "商品名", "图片", "是否上架", "是否热销", "价格", "库存", "生产日期"};
        //设置书写器
        PdfPTable table = FileUtil.createTable(str.length);
        //打开文本对象
        document.open();
        //设置标题
        Font headFont = new Font(font, 25, Font.BOLD);
        //设置标题的颜色
        headFont.setColor(BaseColor.PINK);
        //创建标题
        PdfPCell headCell = FileUtil.createHeadline("商品信息", headFont);
        headCell.setExtraParagraphSpace(30);
        //放入书写器
        table.addCell(headCell);
        for (int i = 0; i < str.length; i++) {
            table.addCell(FileUtil.createCell(str[i], keyFont, Element.ALIGN_CENTER));
        }

        //把查询到的数据集合遍历到书写器里面
        for (int i = 0; i < list.size(); i++) {
            Product product = list.get(i);
            table.addCell(FileUtil.createCell(product.getId().toString(), keyFont, Element.ALIGN_CENTER));
            table.addCell(FileUtil.createCell(product.getName(), keyFont, Element.ALIGN_CENTER));
            try {
                table.addCell(Image.getInstance(request.getServletContext().getRealPath("/") + product.getImgurl()));
            } catch (BadElementException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            table.addCell(FileUtil.createCell(product.getIsOut()==1?"上架":"下架", keyFont, Element.ALIGN_CENTER));
            table.addCell(FileUtil.createCell(product.getIsHot() == 1 ? "热销" : "否", keyFont, Element.ALIGN_CENTER));
            table.addCell(FileUtil.createCell(product.getPrice().toString(), keyFont, Element.ALIGN_CENTER));
            table.addCell(FileUtil.createCell(product.getNum().toString(), keyFont, Element.ALIGN_CENTER));
            table.addCell(FileUtil.createCell(new SimpleDateFormat().format(product.getCreateDate()), keyFont, Element.ALIGN_CENTER));

        }
        //放入文本对象
        try {
            document.add(table);
        } catch (DocumentException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        document.close();
        return byo;
    }

    @Override
    public List<Product> querySearchProductList(ProductSearch productSearch) {
        return productMapper.querySearchProductList( productSearch);
    }

    @Override
    public List queryProductCount() {
        List list=  productMapper.queryProductNum();
        return  list;
    }
}
