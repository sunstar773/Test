package com.fh.controller.brand;

import com.fh.biz.brand.BrandService;
import com.fh.po.common.DateTable;
import com.fh.po.common.ServerResponse;
import com.fh.po.oss.OSS;
import com.fh.util.FileUtil;
import com.fh.util.RedisUtil;
import com.fh.vo.brand.Brand;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class BrandController {
    @Resource(name = "brandService")
    private BrandService brandService;
     @RequestMapping("queryBrandList")
     @ResponseBody
      public DateTable queryBrandList(com.fh.po.brand.Brand brand){
        DateTable dateTable= brandService.findBrandList(brand);
          return dateTable;
      }
    @RequestMapping("toBrandList")
      public String toBrandList(){
         return "brand/brandList";
      }
    @RequestMapping("addBrand")
    @ResponseBody
      public ServerResponse addBrand(com.fh.po.brand.Brand brand){
        RedisUtil.del("hotBrandList");
        RedisUtil.del("BrandList");
            brandService.addBrand( brand);
          return   ServerResponse.success();
}
    @RequestMapping("deleteBrand")
    @ResponseBody
      public ServerResponse deleteBrand(Long id){
        RedisUtil.del("hotBrandList");
        RedisUtil.del("BrandList");
            brandService.deleteBrand( id);
            return   ServerResponse.success();
      }
    @RequestMapping("goUpdateBrand")
    @ResponseBody
      public ServerResponse goUpdateBrand(Long id){
              com.fh.po.brand.Brand brand=brandService.getBrand(id);
              return   ServerResponse.success(brand);
      }
    @RequestMapping("updateBrand")
    @ResponseBody
      public ServerResponse updateBrand(com.fh.po.brand.Brand brand,String ossImgUrl){
        RedisUtil.del("hotBrandList");
        RedisUtil.del("BrandList");
        FileUtil.deleteOssImg(ossImgUrl);
              brandService.updateBrand( brand);
              return   ServerResponse.success();
      }
    @RequestMapping("deltBrands")
    @ResponseBody
      public ServerResponse deltBrands(@RequestParam("ids[]")List<Integer> ids){
            brandService.deltBrands(ids);
            return   ServerResponse.success();
      }
    @RequestMapping("queryBrandAll")
    @ResponseBody
      public ServerResponse queryBrandAll(){
         List<Brand> list=brandService.queryBrandAll();
         return ServerResponse.success(list);
    }
    @RequestMapping("updateSort")
    @ResponseBody
    public  ServerResponse updateSort(Brand brand){
        RedisUtil.del("hotBrandList");
        brandService.updateSort(brand);
         return ServerResponse.success();
    }
    @RequestMapping("updateHot")
    @ResponseBody
    public ServerResponse updateHot(Brand brand){
        RedisUtil.del("hotBrandList");
        brandService.updateHot(brand);
         return ServerResponse.success();
    }
}
