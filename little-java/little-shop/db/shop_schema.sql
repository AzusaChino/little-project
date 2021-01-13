drop
database if exists little_shop;
drop
user if exists 'az'@'localhost';
create
database little_shop default character set utf8mb4;
use
little_shop;
create
user 'az'@'localhost' identified by 'azusa520';
grant all privileges on little_shop.* to
'az'@'localhost';
flush
privileges;

DROP TABLE IF EXISTS `tb_advertisement`;
CREATE TABLE `tb_advertisement`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(64)  NOT NULL DEFAULT '' COMMENT '广告标题',
    `link`        varchar(255) NOT NULL DEFAULT '' COMMENT '所广告的商品页面或者活动页面链接地址',
    `url`         varchar(255) NOT NULL COMMENT '广告宣传图片',
    `position`    tinyint(3) DEFAULT '1' COMMENT '广告位置：1则是首页,2 sidebar',
    `content`     varchar(255)          DEFAULT '' COMMENT '活动内容',
    `start_time`  datetime              DEFAULT NULL COMMENT '广告开始时间',
    `end_time`    datetime              DEFAULT NULL COMMENT '广告结束时间',
    `enabled`     tinyint(1) DEFAULT '0' COMMENT '是否启用',
    `create_time` datetime              DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime              DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY           `enabled` (`enabled`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4 COMMENT ='广告表';

DROP TABLE IF EXISTS `tb_address`;
CREATE TABLE `tb_address`
(
    `id`             int(11) NOT NULL AUTO_INCREMENT,
    `username`       varchar(64)  NOT NULL DEFAULT '' COMMENT '收货人名称',
    `user_id`        int(11) NOT NULL DEFAULT '0' COMMENT '用户表的用户ID',
    `province`       varchar(64)  NOT NULL COMMENT '行政区域表的省ID',
    `city`           varchar(64)  NOT NULL COMMENT '行政区域表的市ID',
    `country`        varchar(64)  NOT NULL COMMENT '行政区域表的区县ID',
    `address_detail` varchar(127) NOT NULL DEFAULT '' COMMENT '详细收货地址',
    `area_code`      char(6)               DEFAULT NULL COMMENT '地区编码',
    `postal_code`    char(6)               DEFAULT NULL COMMENT '邮政编码',
    `tel`            varchar(20)  NOT NULL DEFAULT '' COMMENT '手机号码',
    `is_default`     tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认地址',
    `create_time`    datetime              DEFAULT NULL COMMENT '创建时间',
    `update_time`    datetime              DEFAULT NULL COMMENT '更新时间',
    `deleted`        tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY              `user_id` (`user_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4 COMMENT ='收货地址表';

DROP TABLE IF EXISTS `tb_admin`;
CREATE TABLE `tb_admin`
(
    `id`              int(11) NOT NULL AUTO_INCREMENT,
    `username`        varchar(64) NOT NULL DEFAULT '' COMMENT '管理员名称',
    `password`        varchar(64) NOT NULL DEFAULT '' COMMENT '管理员密码',
    `last_login_ip`   varchar(64)          DEFAULT '' COMMENT '最近一次登录IP地址',
    `last_login_time` datetime             DEFAULT NULL COMMENT '最近一次登录时间',
    `avatar`          varchar(255)         DEFAULT '''' COMMENT '头像图片',
    `create_time`     datetime             DEFAULT NULL COMMENT '创建时间',
    `update_time`     datetime             DEFAULT NULL COMMENT '更新时间',
    `deleted`         tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4 COMMENT ='管理员表';

DROP TABLE IF EXISTS `tb_after_sale`;
CREATE TABLE `tb_after_sale`
(
    `id`            int(11) NOT NULL AUTO_INCREMENT,
    `after_sale_sn` varchar(63)    DEFAULT NULL COMMENT '售后编号',
    `order_id`      int(11) NOT NULL COMMENT '订单ID',
    `user_id`       int(11) NOT NULL COMMENT '用户ID',
    `type`          smallint(6) DEFAULT '0' COMMENT '售后类型，0是未收货退款，1是已收货（无需退货）退款，2用户退货退款',
    `reason`        varchar(31)    DEFAULT '' COMMENT '退款原因',
    `amount`        decimal(10, 2) DEFAULT '0.00' COMMENT '退款金额',
    `pictures`      varchar(1023)  DEFAULT '[]' COMMENT '退款凭证图片链接数组',
    `comment`       varchar(511)   DEFAULT '' COMMENT '退款说明',
    `status`        smallint(6) DEFAULT '0' COMMENT '售后状态，0是可申请，1是用户已申请，2是管理员审核通过，3是管理员退款成功，4是管理员审核拒绝，5是用户已取消',
    `handle_time`   datetime       DEFAULT NULL COMMENT '管理员操作时间',
    `add_time`      datetime       DEFAULT NULL COMMENT '添加时间',
    `update_time`   datetime       DEFAULT NULL COMMENT '更新时间',
    `deleted`       tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4 COMMENT ='售后表';

DROP TABLE IF EXISTS `tb_admin_role`;
create table `tb_admin_role`
(
    `admin_id` varchar(10) not null comment '用户ID',
    `role_id`  varchar(10) not null default '3' comment '角色ID'
) comment '用户角色关联表';


DROP TABLE IF EXISTS `tb_brand`;
CREATE TABLE `tb_brand`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(255) NOT NULL DEFAULT '' COMMENT '品牌商名称',
    `desc`        varchar(255) NOT NULL DEFAULT '' COMMENT '品牌商简介',
    `pic_url`     varchar(255) NOT NULL DEFAULT '' COMMENT '品牌商页的品牌商图片',
    `sort_order`  tinyint(3) DEFAULT '50',
    `floor_price` decimal(10, 2)        DEFAULT '0.00' COMMENT '品牌商的商品低价，仅用于页面展示',
    `create_time` datetime              DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime              DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARSET = utf8mb4 COMMENT ='品牌商表';

DROP TABLE IF EXISTS `tb_cart`;
CREATE TABLE `tb_cart`
(
    `id`             int(11) NOT NULL AUTO_INCREMENT,
    `user_id`        int(11) DEFAULT NULL COMMENT '用户表的用户ID',
    `product_id`     int(11) DEFAULT NULL COMMENT '商品表的商品ID',
    `product_sn`     varchar(64)    DEFAULT NULL COMMENT '商品编号',
    `product_name`   varchar(127)   DEFAULT NULL COMMENT '商品名称',
    `price`          decimal(10, 2) DEFAULT '0.00' COMMENT '商品货品的价格',
    `number`         smallint(5) DEFAULT '0' COMMENT '商品货品的数量',
    `specifications` varchar(1023)  DEFAULT NULL COMMENT '商品规格值列表，采用JSON数组格式',
    `checked`        tinyint(1) DEFAULT '1' COMMENT '购物车中商品是否选择状态',
    `pic_url`        varchar(255)   DEFAULT NULL COMMENT '商品图片或者商品货品图片',
    `create_time`    datetime       DEFAULT NULL COMMENT '创建时间',
    `update_time`    datetime       DEFAULT NULL COMMENT '更新时间',
    `deleted`        tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4 COMMENT ='购物车商品表';

DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(64)   NOT NULL DEFAULT '' COMMENT '类目名称',
    `keywords`    varchar(1023) NOT NULL DEFAULT '' COMMENT '类目关键字，以JSON数组格式',
    `desc`        varchar(255)           DEFAULT '' COMMENT '类目广告语介绍',
    `pid`         int(11) NOT NULL DEFAULT '0' COMMENT '父类目ID',
    `icon_url`    varchar(1023)          DEFAULT '' COMMENT '类目图标',
    `pic_url`     varchar(1023)          DEFAULT '' COMMENT '类目图片',
    `level`       varchar(30)            DEFAULT 'L1',
    `sort_order`  tinyint(3) DEFAULT '50' COMMENT '排序',
    `create_time` datetime               DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime               DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY           `parent_id` (`pid`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 17
  DEFAULT CHARSET = utf8mb4 COMMENT ='类目表';

DROP TABLE IF EXISTS `tb_collection`;
CREATE TABLE `tb_collection`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `user_id`     int(11) NOT NULL DEFAULT '0' COMMENT '用户表的用户ID',
    `value_id`    int(11) NOT NULL DEFAULT '0' COMMENT '如果type=0，则是商品ID；如果type=1，则是专题ID',
    `type`        tinyint(3) NOT NULL DEFAULT '0' COMMENT '收藏类型，如果type=0，则是商品ID；如果type=1，则是专题ID',
    `add_time`    datetime DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY           `user_id` (`user_id`),
    KEY           `goods_id` (`value_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='收藏表';

DROP TABLE IF EXISTS `tb_comment`;
CREATE TABLE `tb_comment`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `value_id`    int(11) NOT NULL DEFAULT '0' COMMENT '见下',
    `type`        tinyint(3) NOT NULL DEFAULT '0' COMMENT '评论类型，如果type=0，则是商品评论；如果是type=1，则是专题评论；如果type=3，则是订单商品评论。',
    `content`     varchar(1023) NOT NULL COMMENT '评论内容',
    `user_id`     int(11) NOT NULL DEFAULT '0' COMMENT '用户表的用户ID',
    `has_picture` tinyint(1) DEFAULT '0' COMMENT '是否含有图片',
    `pic_urls`    varchar(1023) DEFAULT NULL COMMENT '图片地址列表，采用JSON数组格式',
    `star`        smallint(6) DEFAULT '1' COMMENT '评分， 1-5',
    `create_time` datetime      DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime      DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY           `id_value` (`value_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 12
  DEFAULT CHARSET = utf8mb4 COMMENT ='评论表';

DROP TABLE IF EXISTS `tb_coupon`;
CREATE TABLE `tb_coupon`
(
    `id`            int(11) NOT NULL AUTO_INCREMENT,
    `name`          varchar(64) NOT NULL COMMENT '优惠券名称',
    `desc`          varchar(127)   DEFAULT '' COMMENT '优惠券介绍，通常是显示优惠券使用限制文字',
    `tag`           varchar(64)    DEFAULT '' COMMENT '优惠券标签，例如新人专用',
    `total`         int(11) NOT NULL DEFAULT '0' COMMENT '优惠券数量，如果是0，则是无限量',
    `discount`      decimal(10, 2) DEFAULT '0.00' COMMENT '优惠金额，',
    `min`           decimal(10, 2) DEFAULT '0.00' COMMENT '最少消费金额才能使用优惠券。',
    `limit`         smallint(6) DEFAULT '1' COMMENT '用户领券限制数量，如果是0，则是不限制；默认是1，限领一张.',
    `type`          smallint(6) DEFAULT '0' COMMENT '优惠券赠送类型，如果是0则通用券，用户领取；如果是1，则是注册赠券；如果是2，则是优惠券码兑换；',
    `status`        smallint(6) DEFAULT '0' COMMENT '优惠券状态，如果是0则是正常可用；如果是1则是过期; 如果是2则是下架。',
    `product_type`  smallint(6) DEFAULT '0' COMMENT '商品限制类型，如果0则全商品，如果是1则是类目限制，如果是2则是商品限制。',
    `product_value` varchar(1023)  DEFAULT '[]' COMMENT '商品限制值，product_type如果是0则空集合，如果是1则是类目集合，如果是2则是商品集合。',
    `code`          varchar(64)    DEFAULT NULL COMMENT '优惠券兑换码',
    `time_type`     smallint(6) DEFAULT '0' COMMENT '有效时间限制，如果是0，则基于领取时间的有效天数days；如果是1，则start_time和end_time是优惠券有效期；',
    `days`          smallint(6) DEFAULT '0' COMMENT '基于领取时间的有效天数days。',
    `start_time`    datetime       DEFAULT NULL COMMENT '使用券开始时间',
    `end_time`      datetime       DEFAULT NULL COMMENT '使用券截至时间',
    `create_time`   datetime       DEFAULT NULL COMMENT '创建时间',
    `update_time`   datetime       DEFAULT NULL COMMENT '更新时间',
    `deleted`       tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 9
  DEFAULT CHARSET = utf8mb4 COMMENT ='优惠券信息及规则表';

DROP TABLE IF EXISTS `tb_coupon_user`;
CREATE TABLE `tb_coupon_user`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `user_id`     int(11) NOT NULL COMMENT '用户ID',
    `coupon_id`   int(11) NOT NULL COMMENT '优惠券ID',
    `status`      smallint(6) DEFAULT '0' COMMENT '使用状态, 如果是0则未使用；如果是1则已使用；如果是2则已过期；如果是3则已经下架；',
    `used_time`   datetime DEFAULT NULL COMMENT '使用时间',
    `start_time`  datetime DEFAULT NULL COMMENT '有效期开始时间',
    `end_time`    datetime DEFAULT NULL COMMENT '有效期截至时间',
    `order_id`    int(11) DEFAULT NULL COMMENT '订单ID',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8mb4 COMMENT ='优惠券用户使用表';

DROP TABLE IF EXISTS `tb_favorite`;
CREATE TABLE `tb_favorite`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `user_id`     int(11) NOT NULL DEFAULT '0' COMMENT '用户表的用户ID',
    `value_id`    int(11) NOT NULL DEFAULT '0' COMMENT '见下',
    `type`        tinyint(3) NOT NULL DEFAULT '0' COMMENT '收藏类型，如果type=0，则是商品ID；如果type=1，则是专题ID',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY           `user_id` (`user_id`),
    KEY           `value_id` (`value_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='收藏表';

DROP TABLE IF EXISTS `tb_feedback`;
CREATE TABLE `tb_feedback`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `user_id`     int(11) NOT NULL DEFAULT '0' COMMENT '用户表的用户ID',
    `username`    varchar(64)   NOT NULL DEFAULT '' COMMENT '用户名称',
    `mobile`      varchar(20)   NOT NULL DEFAULT '' COMMENT '手机号',
    `feed_type`   varchar(64)   NOT NULL DEFAULT '' COMMENT '反馈类型',
    `content`     varchar(1023) NOT NULL COMMENT '反馈内容',
    `status`      int(3) NOT NULL DEFAULT '0' COMMENT '状态',
    `has_picture` tinyint(1) DEFAULT '0' COMMENT '是否含有图片',
    `pic_urls`    varchar(1023)          DEFAULT NULL COMMENT '图片地址列表，采用JSON数组格式',
    `create_time` datetime               DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime               DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY           `id_value` (`status`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='意见反馈表';

DROP TABLE IF EXISTS `tb_footprint`;
CREATE TABLE `tb_footprint`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `user_id`     int(11) NOT NULL DEFAULT '0' COMMENT '用户表的用户ID',
    `product_id`  int(11) NOT NULL DEFAULT '0' COMMENT '浏览商品ID',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='用户浏览足迹表';

DROP TABLE IF EXISTS `tb_product`;
CREATE TABLE `tb_product`
(
    `id`            int(11) NOT NULL AUTO_INCREMENT,
    `product_sn`    varchar(64)  NOT NULL DEFAULT '' COMMENT '商品编号',
    `name`          varchar(127) NOT NULL DEFAULT '' COMMENT '商品名称',
    `category_id`   int(11) DEFAULT '0' COMMENT '商品所属类目ID',
    `brand_id`      int(11) DEFAULT '0',
    `gallery`       varchar(1023)         DEFAULT NULL COMMENT '商品宣传图片列表，采用JSON数组格式',
    `keywords`      varchar(255)          DEFAULT '' COMMENT '商品关键字，采用逗号间隔',
    `brief`         varchar(255)          DEFAULT '' COMMENT '商品简介',
    `is_on_sale`    tinyint(1) DEFAULT '1' COMMENT '是否上架',
    `sort_order`    smallint(4) DEFAULT '100',
    `pic_url`       varchar(255)          DEFAULT NULL COMMENT '商品页面商品图片',
    `share_url`     varchar(255)          DEFAULT NULL COMMENT '商品分享朋友圈图片',
    `is_new`        tinyint(1) DEFAULT '0' COMMENT '是否新品首发，如果设置则可以在新品首发页面展示',
    `is_hot`        tinyint(1) DEFAULT '0' COMMENT '是否人气推荐，如果设置则可以在人气推荐页面展示',
    `unit`          varchar(31)           DEFAULT '’件‘' COMMENT '商品单位，例如件、盒',
    `counter_price` decimal(10, 2)        DEFAULT '0.00' COMMENT '专柜价格',
    `retail_price`  decimal(10, 2)        DEFAULT '100000.00' COMMENT '零售价格',
    `detail`        text COMMENT '商品详细介绍，是富文本格式',
    `create_time`   datetime              DEFAULT NULL COMMENT '创建时间',
    `update_time`   datetime              DEFAULT NULL COMMENT '更新时间',
    `deleted`       tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY             `product_sn` (`product_sn`),
    KEY             `cate_id` (`category_id`),
    KEY             `brand_id` (`brand_id`),
    KEY             `sort_order` (`sort_order`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 100
  DEFAULT CHARSET = utf8mb4 COMMENT ='商品基本信息表';

DROP TABLE IF EXISTS `tb_product_attribute`;
CREATE TABLE `tb_product_attribute`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `product_id`  int(11) NOT NULL DEFAULT '0' COMMENT '商品表的商品ID',
    `attribute`   varchar(255) NOT NULL COMMENT '商品参数名称',
    `value`       varchar(255) NOT NULL COMMENT '商品参数值',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY           `product_id` (`product_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 877
  DEFAULT CHARSET = utf8mb4 COMMENT ='商品参数表';

DROP TABLE IF EXISTS `tb_product_specification`;
CREATE TABLE `tb_product_specification`
(
    `id`            int(11) NOT NULL AUTO_INCREMENT,
    `product_id`    int(11) NOT NULL DEFAULT '0' COMMENT '商品表的商品ID',
    `specification` varchar(1023) NOT NULL DEFAULT '' COMMENT '商品规格名称',
    `value`         varchar(255)  NOT NULL DEFAULT '' COMMENT '商品规格值',
    `pic_url`       varchar(255)  NOT NULL DEFAULT '' COMMENT '商品规格图片',
    `create_time`   datetime               DEFAULT NULL COMMENT '创建时间',
    `update_time`   datetime               DEFAULT NULL COMMENT '更新时间',
    `deleted`       tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY             `product_id` (`product_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 250
  DEFAULT CHARSET = utf8mb4 COMMENT ='商品规格表';

DROP TABLE IF EXISTS `tb_product_goods`;
CREATE TABLE `tb_product_goods`
(
    `id`             int(11) NOT NULL AUTO_INCREMENT,
    `product_id`     int(11) NOT NULL DEFAULT '0' COMMENT '商品表的商品ID',
    `specifications` varchar(1023)  NOT NULL COMMENT '商品规格值列表，采用JSON数组格式',
    `price`          decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '商品货品价格',
    `number`         int(11) NOT NULL DEFAULT '0' COMMENT '商品货品数量',
    `url`            varchar(125)            DEFAULT NULL COMMENT '商品货品图片',
    `create_time`    datetime                DEFAULT NULL COMMENT '创建时间',
    `update_time`    datetime                DEFAULT NULL COMMENT '更新时间',
    `deleted`        tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY              `goods_id` (`product_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 251
  DEFAULT CHARSET = utf8mb4 COMMENT ='商品货品表';

DROP TABLE IF EXISTS `tb_group`;
CREATE TABLE `tb_group`
(
    `id`                int(11) NOT NULL AUTO_INCREMENT,
    `order_id`          int(11) NOT NULL COMMENT '关联的订单ID',
    `group_id`          int(11) DEFAULT '0' COMMENT '如果是开团用户，则group_id是0；如果是参团用户，则group_id是团购活动ID',
    `rules_id`          int(11) NOT NULL COMMENT '团购规则ID，关联group_rules表ID字段',
    `user_id`           int(11) NOT NULL COMMENT '用户ID',
    `share_url`         varchar(255) DEFAULT NULL COMMENT '团购分享图片地址',
    `creator_user_id`   int(11) NOT NULL COMMENT '开团用户ID',
    `creator_user_time` datetime     DEFAULT NULL COMMENT '开团时间',
    `status`            smallint(6) DEFAULT '0' COMMENT '团购活动状态，开团未支付则0，开团中则1，开团失败则2',
    `create_time`       datetime NOT NULL COMMENT '创建时间',
    `update_time`       datetime     DEFAULT NULL COMMENT '更新时间',
    `deleted`           tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT ='团购活动表';

DROP TABLE IF EXISTS `tb_group_rules`;
CREATE TABLE `tb_group_rules`
(
    `id`              int(11) NOT NULL AUTO_INCREMENT,
    `product_id`      int(11) NOT NULL COMMENT '商品表的商品ID',
    `product_name`    varchar(127)   NOT NULL COMMENT '商品名称',
    `pic_url`         varchar(255) DEFAULT NULL COMMENT '商品图片或者商品货品图片',
    `discount`        decimal(64, 0) NOT NULL COMMENT '优惠金额',
    `discount_member` int(11) NOT NULL COMMENT '达到优惠条件的人数',
    `expire_time`     datetime     DEFAULT NULL COMMENT '团购过期时间',
    `status`          smallint(6) DEFAULT '0' COMMENT '团购规则状态，正常上线则0，到期自动下线则1，管理手动下线则2',
    `create_time`     datetime       NOT NULL COMMENT '创建时间',
    `update_time`     datetime     DEFAULT NULL COMMENT '更新时间',
    `deleted`         tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT ='团购规则表';

DROP TABLE IF EXISTS `tb_issue`;
CREATE TABLE `tb_issue`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `question`    varchar(255) DEFAULT NULL COMMENT '问题标题',
    `answer`      varchar(255) DEFAULT NULL COMMENT '问题答案',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4 COMMENT ='常见问题表';

DROP TABLE IF EXISTS `tb_keyword`;
CREATE TABLE `tb_keyword`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `keyword`     varchar(127) NOT NULL DEFAULT '' COMMENT '关键字',
    `url`         varchar(255) NOT NULL DEFAULT '' COMMENT '关键字的跳转链接',
    `is_hot`      tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是热门关键字',
    `is_default`  tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是默认关键字',
    `sort_order`  int(11) NOT NULL DEFAULT '100' COMMENT '排序',
    `create_time` datetime              DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime              DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 8
  DEFAULT CHARSET = utf8mb4 COMMENT ='关键字表';

DROP TABLE IF EXISTS `tb_log`;
CREATE TABLE `tb_log`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `admin`       varchar(45)  DEFAULT NULL COMMENT '管理员',
    `ip`          varchar(45)  DEFAULT NULL COMMENT '管理员地址',
    `type`        int(11) DEFAULT NULL COMMENT '操作分类',
    `action`      varchar(45)  DEFAULT NULL COMMENT '操作动作',
    `status`      tinyint(1) DEFAULT NULL COMMENT '操作状态',
    `result`      varchar(127) DEFAULT NULL COMMENT '操作结果，或者成功消息，或者失败消息',
    `comment`     varchar(255) DEFAULT NULL COMMENT '补充信息',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='操作日志表';

DROP TABLE IF EXISTS `tb_notice`;
CREATE TABLE `tb_notice`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `title`       varchar(63)  DEFAULT NULL COMMENT '通知标题',
    `content`     varchar(511) DEFAULT NULL COMMENT '通知内容',
    `admin_id`    int(11) DEFAULT '0' COMMENT '创建通知的管理员ID，如果是系统内置通知则是0.',
    `add_time`    datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8mb4 COMMENT ='通知表';

DROP TABLE IF EXISTS `tb_notice_admin`;
CREATE TABLE `tb_notice_admin`
(
    `id`           int(11) NOT NULL AUTO_INCREMENT,
    `notice_id`    int(11) DEFAULT NULL COMMENT '通知ID',
    `notice_title` varchar(63) DEFAULT NULL COMMENT '通知标题',
    `admin_id`     int(11) DEFAULT NULL COMMENT '接收通知的管理员ID',
    `read_time`    datetime    DEFAULT NULL COMMENT '阅读时间，如果是NULL则是未读状态',
    `add_time`     datetime    DEFAULT NULL COMMENT '创建时间',
    `update_time`  datetime    DEFAULT NULL COMMENT '更新时间',
    `deleted`      tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8mb4 COMMENT ='通知管理员表';

DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order`
(
    `id`                int(11) NOT NULL AUTO_INCREMENT,
    `user_id`           int(11) NOT NULL COMMENT '用户表的用户ID',
    `order_sn`          varchar(64)    NOT NULL COMMENT '订单编号',
    `order_status`      smallint(6) NOT NULL COMMENT '订单状态',
    `after_sale_status` smallint(6) DEFAULT '0' COMMENT '售后状态，0是可申请，1是用户已申请，2是管理员审核通过，3是管理员退款成功，4是管理员审核拒绝，5是用户已取消',
    `consignee`         varchar(64)    NOT NULL COMMENT '收货人名称',
    `mobile`            varchar(64)    NOT NULL COMMENT '收货人手机号',
    `address`           varchar(127)   NOT NULL COMMENT '收货具体地址',
    `message`           varchar(255)   NOT NULL DEFAULT '' COMMENT '用户订单留言',
    `product_price`     decimal(10, 2) NOT NULL COMMENT '商品总费用',
    `freight_price`     decimal(10, 2) NOT NULL COMMENT '配送费用',
    `coupon_price`      decimal(10, 2) NOT NULL COMMENT '优惠券减免',
    `integral_price`    decimal(10, 2) NOT NULL COMMENT '用户积分减免',
    `group_price`       decimal(10, 2) NOT NULL COMMENT '团购优惠价减免',
    `order_price`       decimal(10, 2) NOT NULL COMMENT '订单费用， = product_price + freight_price - coupon_price',
    `actual_price`      decimal(10, 2) NOT NULL COMMENT '实付费用， = order_price - integral_price',
    `pay_id`            varchar(64)             DEFAULT NULL COMMENT '微信付款编号',
    `pay_time`          datetime                DEFAULT NULL COMMENT '微信付款时间',
    `ship_sn`           varchar(64)             DEFAULT NULL COMMENT '发货编号',
    `ship_channel`      varchar(64)             DEFAULT NULL COMMENT '发货快递公司',
    `ship_time`         datetime                DEFAULT NULL COMMENT '发货开始时间',
    `refund_amount`     decimal(10, 2)          DEFAULT NULL COMMENT '实际退款金额，（有可能退款金额小于实际支付金额）',
    `refund_type`       varchar(64)             DEFAULT NULL COMMENT '退款方式',
    `refund_content`    varchar(127)            DEFAULT NULL COMMENT '退款备注',
    `refund_time`       datetime                DEFAULT NULL COMMENT '退款时间',
    `confirm_time`      datetime                DEFAULT NULL COMMENT '用户确认收货时间',
    `comments`          smallint(6) DEFAULT '0' COMMENT '待评价订单商品数量',
    `end_time`          datetime                DEFAULT NULL COMMENT '订单关闭时间',
    `create_time`       datetime                DEFAULT NULL COMMENT '创建时间',
    `update_time`       datetime                DEFAULT NULL COMMENT '更新时间',
    `deleted`           tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='订单表';

DROP TABLE IF EXISTS `tb_order_product`;
CREATE TABLE `tb_order_product`
(
    `id`             int(11) NOT NULL AUTO_INCREMENT,
    `order_id`       int(11) NOT NULL DEFAULT '0' COMMENT '订单表的订单ID',
    `product_id`     int(11) NOT NULL DEFAULT '0' COMMENT '商品表的商品ID',
    `product_name`   varchar(127)   NOT NULL DEFAULT '' COMMENT '商品名称',
    `product_sn`     varchar(64)    NOT NULL DEFAULT '' COMMENT '商品编号',
    `number`         smallint(5) NOT NULL DEFAULT '0' COMMENT '商品货品的购买数量',
    `price`          decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '商品货品的售价',
    `specifications` varchar(1023)  NOT NULL COMMENT '商品货品的规格列表',
    `pic_url`        varchar(1023)  NOT NULL DEFAULT '' COMMENT '商品货品图片或者商品图片',
    `comment`        int(11) DEFAULT '0' COMMENT '订单商品评论，如果是-1，则超期不能评价；如果是0，则可以评价；如果其他值，则是comment表里面的评论ID。',
    `create_time`    datetime                DEFAULT NULL COMMENT '创建时间',
    `update_time`    datetime                DEFAULT NULL COMMENT '更新时间',
    `deleted`        tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY              `order_id` (`order_id`),
    KEY              `product_id` (`product_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='订单商品表';

DROP TABLE IF EXISTS `tb_permission`;
CREATE TABLE `tb_permission`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `permission`  varchar(64) DEFAULT NULL COMMENT '权限',
    `create_time` datetime    DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime    DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 32
  DEFAULT CHARSET = utf8mb4 COMMENT ='权限表';

DROP TABLE IF EXISTS `tb_region`;
CREATE TABLE `tb_region`
(
    `id`   int(11) NOT NULL AUTO_INCREMENT,
    `pid`  int(11) NOT NULL DEFAULT '0' COMMENT '行政区域父ID，例如区县的pid指向市，市的pid指向省，省的pid则是0',
    `name` varchar(120) NOT NULL DEFAULT '' COMMENT '行政区域名称',
    `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '行政区域类型，如如1则是省， 如果是2则是市，如果是3则是区县',
    `code` int(11) NOT NULL DEFAULT '0' COMMENT '行政区域编码',
    PRIMARY KEY (`id`),
    KEY    `parent_id` (`pid`),
    KEY    `region_type` (`type`),
    KEY    `agency_id` (`code`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3232
  DEFAULT CHARSET = utf8mb4 COMMENT ='行政区域表';

DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(64) NOT NULL COMMENT '角色名称',
    `desc`        varchar(255) DEFAULT NULL COMMENT '角色描述',
    `enabled`     tinyint(1) DEFAULT '1' COMMENT '是否启用',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT ='角色表';

create table if not exists `tb_role_permission`
(
    `role_id` varchar
(
    10
) not null comment '角色ID',
    `permission_id` varchar
(
    10
) not null comment '权限ID'
    )
    comment '角色权限表';

DROP TABLE IF EXISTS `tb_search_history`;
CREATE TABLE `tb_search_history`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `user_id`     int(11) NOT NULL COMMENT '用户表的用户ID',
    `keyword`     varchar(64) NOT NULL COMMENT '搜索关键字',
    `from`        varchar(64) NOT NULL DEFAULT '' COMMENT '搜索来源，如pc、wx、app',
    `create_time` datetime             DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime             DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='搜索历史表';

DROP TABLE IF EXISTS `tb_storage`;
CREATE TABLE `tb_storage`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `key`         varchar(64)  NOT NULL COMMENT '文件的唯一索引',
    `name`        varchar(255) NOT NULL COMMENT '文件名',
    `type`        varchar(20)  NOT NULL COMMENT '文件类型',
    `size`        int(11) NOT NULL COMMENT '文件大小',
    `url`         varchar(255) DEFAULT NULL COMMENT '文件访问链接',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='文件存储表';

DROP TABLE IF EXISTS `tb_system`;
CREATE TABLE `tb_system`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `key_name`    varchar(255) NOT NULL COMMENT '系统配置名',
    `key_value`   varchar(255) NOT NULL COMMENT '系统配置值',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 19
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT ='系统配置表';

DROP TABLE IF EXISTS `tb_topic`;
CREATE TABLE `tb_topic`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `title`       varchar(255) NOT NULL DEFAULT '''' COMMENT '专题标题',
    `subtitle`    varchar(255)          DEFAULT '''' COMMENT '专题子标题',
    `content`     text COMMENT '专题内容，富文本格式',
    `price`       decimal(10, 2)        DEFAULT '0.00' COMMENT '专题相关商品最低价',
    `read_count`  varchar(20)           DEFAULT '0' COMMENT '专题阅读量',
    `pic_url`     varchar(255)          DEFAULT '' COMMENT '专题图片',
    `sort_order`  int(11) DEFAULT '100' COMMENT '排序',
    `product`     varchar(1023)         DEFAULT '' COMMENT '专题相关商品，采用JSON数组格式',
    `create_time` datetime              DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime              DEFAULT NULL COMMENT '更新时间',
    `deleted`     tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    KEY           `topic_id` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT ='专题表';

DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`
(
    `id`              int(11) NOT NULL AUTO_INCREMENT,
    `username`        varchar(64)  NOT NULL COMMENT '用户名称',
    `password`        varchar(64)  NOT NULL DEFAULT '' COMMENT '用户密码',
    `gender`          tinyint(3) NOT NULL DEFAULT '1' COMMENT '性别：1 男,2 女, 3 未知',
    `birthday`        date                  DEFAULT NULL COMMENT '生日',
    `last_login_time` datetime              DEFAULT NULL COMMENT '最近一次登录时间',
    `last_login_ip`   varchar(64)  NOT NULL DEFAULT '' COMMENT '最近一次登录IP地址',
    `user_level`      tinyint(3) DEFAULT '1' COMMENT '1 普通用户，1 VIP用户，2 高级VIP用户',
    `nickname`        varchar(64)  NOT NULL DEFAULT '' COMMENT '用户昵称或网络名称',
    `mobile`          varchar(20)  NOT NULL DEFAULT '' COMMENT '用户手机号码',
    `avatar`          varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像图片',
    `wx_openid`       varchar(64)  NOT NULL DEFAULT '' COMMENT '微信登录openid',
    `session_key`     varchar(100) NOT NULL DEFAULT '' COMMENT '微信登录会话KEY',
    `status`          tinyint(3) NOT NULL DEFAULT '1' COMMENT '1 活跃, 2 冻结, 3 废弃, 4 注销',
    `create_time`     datetime              DEFAULT NULL COMMENT '创建时间',
    `update_time`     datetime              DEFAULT NULL COMMENT '更新时间',
    `deleted`         tinyint(1) DEFAULT '0' COMMENT '逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `user_name` (`username`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8mb4 COMMENT ='用户表';
