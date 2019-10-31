package com.fh.mapper.brand;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.vo.brand.Brand;

import java.util.List;

public interface BrandMapper extends BaseMapper<Brand> {
    Long queryBrandCount(com.fh.po.brand.Brand brand);

    List<com.fh.po.brand.Brand> queryBrandList(com.fh.po.brand.Brand brand);

    void addBrand(com.fh.po.brand.Brand brand);

    void deleteBrand(Long id);

    com.fh.po.brand.Brand getBrand(Long id);

    void updateBrand(com.fh.po.brand.Brand brand);

    void deltBrands(List<Integer> ids);
}
