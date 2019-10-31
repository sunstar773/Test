package com.fh.controller.member;

import com.fh.biz.member.MemberService;
import com.fh.params.member.MemberSearch;
import com.fh.po.common.ServerResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {
          @Autowired
          private MemberService memberService;
          @RequestMapping("findMemList")
          @ResponseBody
        public ServerResponse findMemList(MemberSearch memberSearch){
           ServerResponse serverResponse=memberService.findMemList(memberSearch);
           return serverResponse;
        }
    @RequestMapping("goMemList")
        public String  goMemList(){
              return "member/memberList";
        }
}
