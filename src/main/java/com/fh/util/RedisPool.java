package com.fh.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisPool {
    private RedisPool(){

    }

    private static JedisPool jedisPool;

    private  static void initPool(){
        JedisPoolConfig jedisPoolConfig=new JedisPoolConfig();
        jedisPoolConfig.setMaxTotal(1000);
        jedisPoolConfig.setMaxIdle(100);
        jedisPoolConfig.setMinIdle(100);
        jedisPoolConfig.setTestOnReturn(true);
        jedisPoolConfig.setTestOnBorrow(true);
        jedisPool =new JedisPool(jedisPoolConfig,"192.168.92.128",7766);
    }
    static{
        initPool();
    }
    public static Jedis getResources(){
       return jedisPool.getResource();
    }
}
