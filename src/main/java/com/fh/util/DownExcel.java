package com.fh.util;

import com.fh.params.product.ProductSearch;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.*;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class DownExcel {

    public static Workbook buildWorkbook(String sheetName, String[]heads, String[]props, Class clazz, List list) {
        /*创建操作对象*/
        XSSFWorkbook xw=new XSSFWorkbook();
        /*创建 sheet 页*/
        XSSFSheet createSheet = xw.createSheet(sheetName);
        XSSFRow createRow = createSheet.createRow(0);
        /* 创建标头。通过sheet 创建  row 行，通过行创建列cell，并且给列赋值*/
        getHead(createRow,heads);
        /*创建行，并给每行的列赋值*/
        getBody(list, xw, createSheet, clazz,props);
        return xw;
    }

    private static void getBody(List list, XSSFWorkbook xw, XSSFSheet createSheet,Class clazz,String[]props) {
        /*创建日期格式*/
        XSSFCellStyle dateStyle = xw.createCellStyle();
        dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        /*创建数值格式*/
        XSSFCellStyle priceStyle = xw.createCellStyle();
        priceStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
        for (int i = 0; i <list.size(); i++) {
            Object obj = list.get(i);
            XSSFRow createRow1 = createSheet.createRow(i+1);
            for (int j = 0; j <props.length ; j++) {
                String s= props[j];
                try {
                    Field declaredField = clazz.getDeclaredField(s);
                    declaredField.setAccessible(true);
                    Object o1 = declaredField.get(obj);
                    Class<?> type = declaredField.getType();
                    if (type==java.lang.String.class){
                        createRow1.createCell(j).setCellValue(o1.toString());
                    }
                    if (type==java.util.Date.class){
                        XSSFCell cell = createRow1.createCell(j);
                        cell.setCellValue((Date) o1);
                        cell.setCellStyle(dateStyle);
                    }
                    if (type==java.lang.Integer.class){
                        createRow1.createCell(j).setCellValue(Integer.valueOf(o1.toString()));
                    }
                    if (type==java.math.BigDecimal.class){
                        XSSFCell cell = createRow1.createCell(j);
                        cell.setCellValue(((BigDecimal) o1).doubleValue());
                        cell.setCellStyle(priceStyle);
                    }
                    if (type==java.lang.Long.class){
                        createRow1.createCell(j).setCellValue(Long.valueOf(o1.toString()));
                    }
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (NoSuchFieldException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static void getHead(XSSFRow createRow,String[]heads) {
        for (int i = 0; i < heads.length; i++) {
            createRow.createCell(i).setCellValue(heads[i]);
        }
    }
}
