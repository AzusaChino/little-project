package cn.az.project.shop.db.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 操作日志表
 *
 * @author Liz
 */
@Data
@TableName("tb_log")
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
public class Log implements Serializable {


    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 管理员
     */
    private String admin;

    /**
     * 管理员地址
     */
    private String ip;

    /**
     * 操作分类
     */
    private Integer type;

    /**
     * 操作动作
     */
    private String action;

    /**
     * 操作状态
     */
    private Boolean status;

    /**
     * 操作结果，或者成功消息，或者失败消息
     */
    private String result;

    /**
     * 补充信息
     */
    private String comment;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

    /**
     * 逻辑删除
     */
    @TableLogic
    private Boolean deleted;


}
