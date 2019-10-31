package com.fh.controller;

import com.fh.po.product.Product;
import com.fh.vo.brand.Brand;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class fanshe {
    public static void main(String[] args) throws Exception {
         Brand brand=new Brand();
          brand.setName("123");
           sun(Brand.class,brand);

    }
    public static void sun(Class clazz,Brand brand) throws IllegalAccessException {
        Field[] declaredFields = clazz.getDeclaredFields();//获取所有属性
        for (Field declaredField : declaredFields) {
            declaredField.setAccessible(true);
            Object o = declaredField.get(brand);
            System.out.println(declaredField.getName()+":"+o);
        }
    }
}
