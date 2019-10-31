package com.fh.biz.member;

import com.fh.params.member.MemberSearch;
import com.fh.po.common.ServerResponse;

public interface MemberService {
    ServerResponse findMemList(MemberSearch memberSearch);
}
