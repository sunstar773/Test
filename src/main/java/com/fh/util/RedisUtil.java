package com.fh.util;

import redis.clients.jedis.Jedis;

public class RedisUtil {

    public static  void set(String key,String value){
        Jedis jedis=null;
        try {
             jedis = RedisPool.getResources();
            jedis.set(key, value);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally {
            if (null!=jedis){
                jedis.close();
            }
        }
    }
    public static String get(String key){
        Jedis jedis =null;
        String s =null;
        try {
            jedis = RedisPool.getResources();
            s = jedis.get(key);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally {
            if (null!=jedis){
                jedis.close();
            }
        }
        return s;
    }

    public static void del(String key){
        Jedis jedis =null;
        try {
            jedis = RedisPool.getResources();
            jedis.del(key);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally {
            if (null!=jedis){
                jedis.close();
            }
        }
    }
    public  static void  setExpire(String key,int time){
        Jedis jedis =null;
        try {
            jedis =   RedisPool.getResources();
            jedis.expire(key,time);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally {
            if (null!=jedis){
                jedis.close();
            }
        }
    }
    public static void setEx(String key,String value,int time){
        Jedis jedis =null;
        try {
            jedis =   RedisPool.getResources();
            jedis.setex(key,time,value);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally {
            if (null!=jedis){
                jedis.close();
            }
        }
    }
    public static void  delBatchKey(String... key){
        Jedis jedis =null;
        try {
            jedis= RedisPool.getResources();
            jedis.del(key);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }finally {
            if (null!=jedis){
                jedis.close();
            }
        }

    }

}
