package com.fh.biz.brand;

import com.fh.po.common.DateTable;
import com.fh.vo.brand.Brand;

import java.util.List;

public  interface BrandService {


    void addBrand(com.fh.po.brand.Brand brand);

    void deleteBrand(Long id);

    com.fh.po.brand.Brand getBrand(Long id);

    void updateBrand(com.fh.po.brand.Brand brand);

    void deltBrands(List<Integer> ids);

    DateTable findBrandList(com.fh.po.brand.Brand brand);

    List<Brand> queryBrandAll();

    void updateSort(Brand brand);

    void updateHot(Brand brand);
}
