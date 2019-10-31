package com.fh.controller.log;

import com.fh.biz.log.LogService;
import com.fh.params.log.LogSearch;
import com.fh.po.common.DateTable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
public class LogController {
     @Resource(name = "logService")
     private LogService logService;

     @RequestMapping("queryLogList")
     @ResponseBody
    public DateTable queryLogList(LogSearch logSearch){
        DateTable dateTable=logService.queryLogList(logSearch);
        return dateTable;
    }
    @RequestMapping("toLogList")
    public String toLogList(){
         return "log/LogList";
    }

}
