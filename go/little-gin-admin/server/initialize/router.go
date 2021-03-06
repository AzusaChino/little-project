package initialize

import (
    "github.com/gin-gonic/gin"
    "github.com/swaggo/gin-swagger/swaggerFiles"

    _ "little-gin-admin/docs"
    "little-gin-admin/global"
    "little-gin-admin/middleware"
    "little-gin-admin/router"
)

// 初始化总路由

func Routers() *gin.Engine {
    var Router = gin.Default()
    // Router.Use(middleware.LoadTls())  // 打开就能玩https了
    // global.Logger.Debug("use middleware logger")
    // 跨域
    Router.Use(middleware.Cors())
    global.Logger.Debug("use middleware cors")
    Router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
    global.Logger.Debug("register swagger handler")
    // 方便统一添加路由组前缀 多服务器上线使用
    ApiGroup := Router.Group("")
    router.InitUserRouter(ApiGroup)                  // 注册用户路由
    router.InitBaseRouter(ApiGroup)                  // 注册基础功能路由 不做鉴权
    router.InitMenuRouter(ApiGroup)                  // 注册menu路由
    router.InitAuthorityRouter(ApiGroup)             // 注册角色路由
    router.InitApiRouter(ApiGroup)                   // 注册功能api路由
    router.InitFileUploadAndDownloadRouter(ApiGroup) // 文件上传下载功能路由
    router.InitWorkflowRouter(ApiGroup)              // 工作流相关路由
    router.InitCasbinRouter(ApiGroup)                // 权限相关路由
    router.InitJwtRouter(ApiGroup)                   // jwt相关路由
    router.InitSystemRouter(ApiGroup)                // system相关路由
    router.InitCustomerRouter(ApiGroup)              // 客户路由
    router.InitAutoCodeRouter(ApiGroup)              // 创建自动化代码
    router.InitSysDictionaryDetailRouter(ApiGroup)   // 字典详情管理
    router.InitSysDictionaryRouter(ApiGroup)         // 字典管理
    router.InitSysOperationRecordRouter(ApiGroup)    // 操作记录
    global.Logger.Info("router register success")
    return Router
}
