package com.fh.mapper.member;

import com.fh.params.member.MemberSearch;
import com.fh.po.member.Member;

import java.util.List;

public interface MemberMapper {
    Long selectCount(MemberSearch memberSearch);

    List<Member> queryList(MemberSearch memberSearch);
}
