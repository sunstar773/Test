package com.fh.mapper.product;

import com.fh.params.product.ProductSearch;
import com.fh.po.product.Product;

import java.util.List;

public interface ProductMapper {
    Long queryProductCount(ProductSearch productSearch );

    List<Product> queryProductList(ProductSearch product);

    void addProduct(Product product);

    void deleteProduct(Long id);

    Product getProduct(Long id);

    void updateProduct(Product product);

    void updateButton(Long id);

    void updateButton1(Long id);

    List<Product> querySearchProductList(ProductSearch productSearch);

    List queryProductNum();
}
