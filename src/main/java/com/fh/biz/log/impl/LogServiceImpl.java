package com.fh.biz.log.impl;

import com.fh.biz.log.LogService;
import com.fh.mapper.log.LogMapper;
import com.fh.params.log.LogSearch;
import com.fh.po.common.DateTable;
import com.fh.po.log.Log;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("logService")
public class LogServiceImpl implements LogService {
     @Resource
    private LogMapper logMapper;

    @Override
    public void addLog(Log log) {
        logMapper.addLog( log);
    }

    @Override
    public DateTable queryLogList(LogSearch logSearch) {
        Long count=logMapper.queryCount(logSearch);
        List<Log> logs=logMapper.queryLogList(logSearch);
        return new DateTable(logSearch.getDraw(),count,count,logs);
    }
}
