package com.fh.biz.brand.impl;

import com.alibaba.fastjson.JSON;
import com.fh.biz.brand.BrandService;
import com.fh.mapper.brand.BrandMapper;
import com.fh.po.common.DateTable;
import com.fh.util.RedisUtil;
import com.fh.vo.brand.Brand;
import com.opensymphony.oscache.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("brandService")
public class BrandServiceImpl implements BrandService {
    @Autowired
    private BrandMapper brandMapper;


    @Override
    public void addBrand(com.fh.po.brand.Brand brand) {
        brandMapper.addBrand( brand);
    }

    @Override
    public void deleteBrand(Long id) {
        brandMapper.deleteBrand( id);
    }

    @Override
    public com.fh.po.brand.Brand getBrand(Long id) {
        return brandMapper.getBrand( id);
    }

    @Override
    public void updateBrand(com.fh.po.brand.Brand brand) {
        brandMapper.updateBrand( brand);
    }

    @Override
    public void deltBrands(List<Integer> ids) {
        brandMapper.deltBrands(ids);
    }

    @Override
    public DateTable findBrandList(com.fh.po.brand.Brand brand) {
        /*查询总条数*/
        Long count=brandMapper.queryBrandCount(brand);
        /*查询分页*/
        List<com.fh.po.brand.Brand> list=brandMapper.queryBrandList( brand);
        return new DateTable(brand.getDraw(),count,count,list);
    }

    @Override
    public List<Brand> queryBrandAll() {
        String brandList = RedisUtil.get("brandList");
        if (StringUtil.isEmpty(brandList)){
          List<Brand> list=  brandMapper.selectList(null);
            String jsonString = JSON.toJSONString(list);
            RedisUtil.set("brandList",jsonString);
            return list;
        }else {
            return  JSON.parseArray(brandList,Brand.class);
        }

    }

    @Override
    public void updateSort(Brand brand) {
        brandMapper.updateById(brand);
    }

    @Override
    public void updateHot(Brand brand) {
        brandMapper.updateById(brand);
    }
}
