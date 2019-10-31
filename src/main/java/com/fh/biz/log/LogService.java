package com.fh.biz.log;

import com.fh.params.log.LogSearch;
import com.fh.po.common.DateTable;
import com.fh.po.log.Log;

public interface LogService


{
    void addLog(Log log);

    DateTable queryLogList(LogSearch logSearch);
}
