package com.fh.aspect;

import com.alibaba.fastjson.JSONObject;
import com.fh.biz.log.LogService;
import com.fh.commons.WebContext;
import com.fh.po.common.Cons;
import com.fh.po.log.Log;
import com.fh.po.user.User;
import com.fh.util.DistributedSession;
import com.fh.util.KeyUtil;
import com.fh.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.Kernel;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;


public class LogAspect {
     private static  final Logger LOGGER=LoggerFactory.getLogger(LogAspect.class);
      @Resource(name = "logService")
      private LogService logService;
      @Autowired
      private HttpServletResponse response;

    public Object doLog(ProceedingJoinPoint proceedingJoinPoint){
        Object result=null;
        /*获取类名*/
         String className= proceedingJoinPoint.getTarget().getClass().getName();
         /*获取方法名*/
          String methodName= proceedingJoinPoint.getSignature().getName();
         /*获取request*/
        HttpServletRequest request = WebContext.getRequest();
        //User user = (User) request.getSession().getAttribute(Cons.USER_SESSION);
        String session = DistributedSession.getSession(request, response);
        String s = RedisUtil.get(KeyUtil.userKey(session));
        User user = JSONObject.parseObject(s, User.class);
        /*获取参数集合*/
        Map<String, String[]> parameterMap = request.getParameterMap();
        Iterator<Map.Entry<String, String[]>> iterator = parameterMap.entrySet().iterator();
        StringBuffer str=new StringBuffer();
        while (iterator.hasNext()){
            Map.Entry<String, String[]> next = iterator.next();
            str.append(",").append(next.getKey()+":").append(StringUtils.join(next.getValue(),","));
        }
        String substring = str.substring(1);

        /*获取注解信息*/
        MethodSignature signature = (MethodSignature) proceedingJoinPoint.getSignature();
        Method method = signature.getMethod();
        String value="";
        if (method.isAnnotationPresent(com.fh.commons.Log.class)){
              Annotation annotation = method.getAnnotation(com.fh.commons.Log.class);
               value = ((com.fh.commons.Log) annotation).value();
          }

        try {
            result= proceedingJoinPoint.proceed();
            Log log=new Log();
            log.setUserName(user.getLoginname());
            log.setRealName(user.getRealname());
            log.setCurrDate(new Date());
            log.setInfo("执行了"+className+"的"+methodName+"方法成功");
           log.setErrorMsg("");
           log.setStatus(Cons.LOG_SUCCESS);
           log.setDetails(substring);
           log.setContext(value);
            logService.addLog(log);
        } catch (Throwable throwable) {
            Log log=new Log();
            log.setUserName(user.getLoginname());
            log.setRealName(user.getRealname());
            log.setCurrDate(new Date());
            log.setInfo("执行了"+className+"的"+methodName+"方法失败");
            log.setErrorMsg(throwable.getMessage());
            log.setStatus(Cons.LOG_ERROR);
            log.setContext(value);
            log.setDetails(substring);
            logService.addLog(log);
            throw new RuntimeException();
        }
        return result;
    }
}
