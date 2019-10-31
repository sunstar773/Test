package com.fh.biz.member.impl;

import com.fh.biz.member.MemberService;
import com.fh.mapper.member.MemberMapper;
import com.fh.params.member.MemberSearch;
import com.fh.po.common.DateTable;
import com.fh.po.common.ServerResponse;
import com.fh.po.member.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;
    @Override
    public ServerResponse findMemList(MemberSearch memberSearch) {
          Long count=memberMapper.selectCount(memberSearch);
          List<Member> list=memberMapper.queryList(memberSearch);
        return ServerResponse.success(new DateTable(memberSearch.getDraw(),count,count,list));
    }
}
