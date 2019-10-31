package com.fh.biz.product;

import com.fh.params.product.ProductSearch;
import com.fh.po.common.DateTable;
import com.fh.po.product.Product;
import org.apache.poi.ss.usermodel.Workbook;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.util.List;

public interface ProductService {

    void addProduct(Product product);

    void deleteProduct(Long id);

    Product getProduct(Long id);

    void updateProduct(Product product);

    DateTable  findProductList(ProductSearch product);

    void updateButton(Long id);

    void updateButton1(Long id);

   

    ByteArrayOutputStream buildByte(ProductSearch productSearch, HttpServletRequest request);

    List<Product> querySearchProductList(ProductSearch productSearch);


    List queryProductCount();
}
