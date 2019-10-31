package com.fh.util;

import org.apache.commons.lang3.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
       public static final String Y_M_D="yyyy-MM-dd";
       public static  final String Y_H_S="yyyy-MM-dd HH:mm:ss";

       public static String  DateToString(Date param,String format){
           SimpleDateFormat simpleDateFormat=new SimpleDateFormat(format);
           if (param==null){
               return "";
           }
           String date= simpleDateFormat.format(param);
           return date;
       }

       public static Date StringToDate(String param,String format){
           if (StringUtils.isEmpty(param)){
               return null;
           }
           SimpleDateFormat simpleDateFormat=new SimpleDateFormat(format);
           Date date=null;
           try {
               date= simpleDateFormat.parse(param);
           } catch (ParseException e) {
               e.printStackTrace();
           }
           return date;
       }
}
