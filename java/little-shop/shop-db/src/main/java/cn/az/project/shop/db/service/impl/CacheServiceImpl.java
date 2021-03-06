package cn.az.project.shop.db.service.impl;

import cn.az.project.shop.db.constant.Setting;
import cn.az.project.shop.db.entity.Admin;
import cn.az.project.shop.db.entity.Permission;
import cn.az.project.shop.db.entity.Role;
import cn.az.project.shop.db.service.IAdminService;
import cn.az.project.shop.db.service.ICacheService;
import cn.az.project.shop.db.service.IPermissionService;
import cn.az.project.shop.db.service.IRedisService;
import cn.az.project.shop.db.service.IRoleService;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * The type Cache service.
 *
 * @author Liz
 */
@Service
public class CacheServiceImpl implements ICacheService {

    @Resource
    private IRedisService redisService;
    @Resource
    private IRoleService roleService;
    @Resource
    private IPermissionService permissionService;
    @Resource
    private ObjectMapper objectMapper;
    @Resource
    private IAdminService adminService;

    /**
     * 测试 Redis是否连接成功
     */
    @Override
    public void testConnect() {
        redisService.exists("test");
    }

    /**
     * Gets user.
     *
     * @param username the username
     * @return the admin
     */
    @Override
    public Admin getAdmin(String username) throws Exception {
        String userString = redisService.get(Setting.USER_CACHE_PREFIX + username);
        if (StringUtils.isBlank(userString)) {
            throw new Exception("缓存中还没有" + username + "的信息");
        } else {
            return this.objectMapper.readValue(userString, Admin.class);
        }
    }

    /**
     * 从缓存中获取用户角色
     *
     * @param username username
     * @return 角色集 roles
     * @throws Exception the exception
     */
    @Override
    public List<Role> getRoles(String username) throws Exception {
        String roleListString = this.redisService.get(Setting.USER_ROLE_CACHE_PREFIX + username);
        if (StringUtils.isBlank(roleListString)) {
            throw new Exception("缓存中还没有" + username + "的ROLE信息");
        } else {
            JavaType type = objectMapper.getTypeFactory().constructParametricType(List.class, Role.class);
            return this.objectMapper.readValue(roleListString, type);
        }
    }

    /**
     * 从缓存中获取用户权限
     *
     * @param username username
     * @return 权限集 permissions
     * @throws Exception the exception
     */
    @Override
    public List<Permission> getPermissions(String username) throws Exception {
        String permissionListString = redisService.get(Setting.USER_PERMISSION_CACHE_PREFIX + username);
        if (StringUtils.isBlank(permissionListString)) {
            throw new Exception("缓存中还没有" + username + "的PERMISSION信息");
        } else {
            JavaType type = objectMapper.getTypeFactory().constructParametricType(List.class, Permission.class);
            return this.objectMapper.readValue(permissionListString, type);
        }
    }

    /**
     * 缓存用户信息
     *
     * @param username 用户名
     * @throws Exception the exception
     */
    @Override
    public void saveAdmin(String username) throws Exception {
        Admin admin = adminService.getOneByUsername(username);
        deleteAdmin(username);
        redisService.set(Setting.USER_CACHE_PREFIX + username, objectMapper.writeValueAsString(admin));
    }

    /**
     * 缓存用户角色信息
     *
     * @param username 用户名
     * @throws Exception the exception
     */
    @Override
    public void saveRoles(String username) throws Exception {
        List<Role> roleList = roleService.getUserRoles(username);
        if (!roleList.isEmpty()) {
            this.deleteRoles(username);
            redisService.set(Setting.USER_ROLE_CACHE_PREFIX + username, objectMapper.writeValueAsString(roleList));
        }
    }

    /**
     * 缓存用户权限信息
     *
     * @param username 用户名
     * @throws Exception the exception
     */
    @Override
    public void savePermissions(String username) throws Exception {
        List<Permission> permissionList = permissionService.getUserPermissions(username);
        if (!permissionList.isEmpty()) {
            this.deletePermissions(username);
            redisService.set(Setting.USER_PERMISSION_CACHE_PREFIX + username, objectMapper.writeValueAsString(permissionList));
        }
    }

    /**
     * 删除用户信息
     *
     * @param username 用户名
     */
    @Override
    public void deleteAdmin(String username) {
        redisService.del(Setting.USER_CACHE_PREFIX + username);
    }

    /**
     * 删除用户角色信息
     *
     * @param username 用户名
     */
    @Override
    public void deleteRoles(String username) {
        redisService.del(Setting.USER_ROLE_CACHE_PREFIX + username);
    }

    /**
     * 删除用户权限信息
     *
     * @param username 用户名
     */
    @Override
    public void deletePermissions(String username) {
        redisService.del(Setting.USER_PERMISSION_CACHE_PREFIX + username);
    }

}
