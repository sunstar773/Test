package com.fh.controller.cache;

import com.fh.po.common.ServerResponse;
import com.fh.util.RedisUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CacheController {
    @RequestMapping("cleanCache")
    @ResponseBody
    public ServerResponse  cleanCache(){
        RedisUtil.del("productList");
        return ServerResponse.success();
    }
}
