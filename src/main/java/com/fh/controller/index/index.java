package com.fh.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("index")
public class index {

    @RequestMapping("goBlank")
    public String goBlank(){
        return "blank";
    }
}
