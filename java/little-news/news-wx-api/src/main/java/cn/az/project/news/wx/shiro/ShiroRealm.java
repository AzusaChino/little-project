package cn.az.project.news.wx.shiro;

import cn.az.project.news.core.jwt.JwtToken;
import cn.az.project.news.core.jwt.JwtUtil;
import cn.az.project.news.core.utils.CommonUtil;
import cn.az.project.news.core.utils.IpUtil;
import cn.az.project.news.db.constant.Setting;
import cn.az.project.news.db.entity.User;
import cn.az.project.news.db.service.IRedisService;
import cn.az.project.news.wx.manager.UserManager;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Set;

/**
 * 自定义实现 ShiroRealm，包含认证和授权两大模块
 *
 * @author az
 */
public class ShiroRealm extends AuthorizingRealm {

    @Resource
    private IRedisService redisService;

    @Resource
    private UserManager userManager;

    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof JwtToken;
    }

    /**
     * `
     * 授权模块，获取用户角色和权限
     *
     * @param token token
     * @return AuthorizationInfo 权限信息
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection token) {
        String username = JwtUtil.getUsername(token.toString());

        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();

        // 获取用户角色集
        Set<String> roleSet = userManager.getUserRoles(username);
        // 获取用户权限集
        Set<String> permissionSet = userManager.getUserPermissions(username);

        simpleAuthorizationInfo.setRoles(roleSet);
        simpleAuthorizationInfo.setStringPermissions(permissionSet);
        return simpleAuthorizationInfo;
    }

    /**
     * 用户认证
     *
     * @param authenticationToken 身份认证 token
     * @return AuthenticationInfo 身份认证信息
     * @throws AuthenticationException 认证相关异常
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 这里的 token是从 JWTFilter 的 executeLogin 方法传递过来的，已经解密
        String token = (String) authenticationToken.getCredentials();

        // 从 redis里获取这个 token
        HttpServletRequest request = CommonUtil.getHttpServletRequest();
        String ip = IpUtil.getIpAddr(request);

        String encryptToken = CommonUtil.encryptToken(token);
        String encryptTokenInRedis = null;
        try {
            encryptTokenInRedis = redisService.get(Setting.TOKEN_CACHE_PREFIX + encryptToken + "." + ip);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 如果找不到，说明已经失效
        if (StringUtils.isBlank(encryptTokenInRedis)) {
            throw new AuthenticationException("token已经过期");
        }

        String username = JwtUtil.getUsername(token);

        if (StringUtils.isBlank(username)) {
            throw new AuthenticationException("token校验不通过");
        }

        // 通过用户名查询用户信息
        User user = userManager.getUser(username);

        if (user == null) {
            throw new AuthenticationException("用户名或密码错误");
        }
        if (!JwtUtil.verify(token, username, user.getPassword())) {
            throw new AuthenticationException("token校验不通过");
        }
        return new SimpleAuthenticationInfo(token, token, getName());
    }
}
