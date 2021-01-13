package cn.az.project.shop.db.function;

import org.springframework.data.redis.RedisConnectionFailureException;

/**
 * The interface Jedis executor.
 *
 * @param <T> the type parameter
 * @param <R> the type parameter
 * @author Liz
 */
public interface JedisExecutor<T, R> {

    /**
     * Execute r.
     *
     * @param t the t
     * @return the r
     * @throws RedisConnectionFailureException the redis connection failure exception
     */
    R execute(T t) throws RedisConnectionFailureException;
}
