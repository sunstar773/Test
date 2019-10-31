package com.fh.mapper.log;

import com.fh.params.log.LogSearch;
import com.fh.po.log.Log;

import java.util.List;

public interface LogMapper {
    void addLog(Log log);

    Long queryCount(LogSearch logSearch);

    List<Log> queryLogList(LogSearch logSearch);
}
