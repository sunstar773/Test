package com.fh.controller.classify;

import com.fh.biz.classify.ClassifyService;
import com.fh.po.classify.Classify;
import com.fh.po.common.ServerResponse;
import com.fh.util.RedisUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class ClassifyController {
    @Resource(name = "classifyService")
    private ClassifyService classifyService;
     @RequestMapping("queryClassify")
     @ResponseBody
    public ServerResponse queryClassify(Long id){
         List list=classifyService.queryClassify(id);
        return  ServerResponse.success(list);
    }
    @RequestMapping("addClass")
    @ResponseBody
    public ServerResponse addClass(Classify classify){
        RedisUtil.del("classList");
        classifyService.addClass( classify);
         return  ServerResponse.success(classify.getId());
    }

    @RequestMapping("deleteClass")
    @ResponseBody
    public ServerResponse deleteClass(@RequestParam("ids[]") List<Integer> ids){
        RedisUtil.del("classList");
        classifyService.deleteClass(ids);
        return ServerResponse.success();
    }
    @RequestMapping("updateClass")
    @ResponseBody
    public ServerResponse updateClass(Classify classify){
        RedisUtil.del("classList");
        classifyService.updateClass( classify);
        return ServerResponse.success();
    }

    @RequestMapping("toClassList")
    public String toMenuList(){
        return "classify/classifyList";
    }
}
