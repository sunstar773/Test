package com.fh.biz.classify;

import com.fh.po.classify.Classify;

import java.util.List;

public interface ClassifyService {
    List queryClassify(Long id);

    void addClass(Classify classify);

    void deleteClass(List<Integer> ids);

    void updateClass(Classify classify);
}
