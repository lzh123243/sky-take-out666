package com.sky.annotation;

import com.sky.enumeration.OperationType;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义注解，用于标识需要自动填充的字段
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface AutoFill {
    //1.自定义注解AutoFill，用于表示需要进行公共字段自动填充的方法
    //2.自定义切面类AutoFillAspect，统一拦截加入了AutoFill注解的方法
    //3.在Mapper的方法上加入AutoFill注解

    //数据库操作类型：insert、update
    OperationType value();

}
