package cn.az.wx.framework.aspectj;

import cn.az.wx.common.utils.StringUtil;
import cn.az.wx.framework.aspectj.lang.annotation.DataSource;
import cn.az.wx.framework.datasource.DynamicDataSourceContextHolder;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

/**
 * 多数据源处理
 *
 * @author ruoyi
 */
@Aspect
@Order(1)
@Component
public class DataSourceAspect {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Pointcut("@annotation(cn.az.wx.framework.aspectj.lang.annotation.DataSource)"
        + "|| @within(cn.az.wx.framework.aspectj.lang.annotation.DataSource)")
    public void dsPointCut() {

    }

    @Around("dsPointCut()")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        DataSource dataSource = getDataSource(point);

        if (StringUtil.isNotNull(dataSource)) {
            DynamicDataSourceContextHolder.setDataSourceType(dataSource.value().name());
        }

        try {
            return point.proceed();
        } finally {
            // 销毁数据源 在执行方法之后
            DynamicDataSourceContextHolder.clearDataSourceType();
        }
    }

    /**
     * 获取需要切换的数据源
     */
    public DataSource getDataSource(ProceedingJoinPoint point) {
        MethodSignature signature = (MethodSignature) point.getSignature();
        Class<?> targetClass = point.getTarget().getClass();
        DataSource targetDataSource = targetClass.getAnnotation(DataSource.class);
        if (StringUtil.isNotNull(targetDataSource)) {
            return targetDataSource;
        } else {
            Method method = signature.getMethod();
            return method.getAnnotation(DataSource.class);
        }
    }
}
