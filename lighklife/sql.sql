CREATE TABLE `car_category_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID标识',
  `pid` int(11) NOT NULL COMMENT '父ID',
  `category_id` int(11) NOT NULL COMMENT '车型id',
  `item_name` varchar(128) NOT NULL COMMENT '条目名称',
  `item_value` char(128) DEFAULT NULL COMMENT '条目值',
  `value` varchar(255) DEFAULT NULL,
  `price_info` varchar(255) DEFAULT '-1',
  `level` int(2) NOT NULL COMMENT '级别',
  `pathid` varchar(512) CHARACTER SET latin1 NOT NULL COMMENT '路径id',
  `pathname` varchar(512) NOT NULL COMMENT '路径名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ind_category_id_pathname` (`category_id`,`pathname`) USING BTREE,
  KEY `ind_category_id_name_level` (`category_id`,`item_name`,`level`) USING BTREE,
  KEY `ind_category_id` (`category_id`) USING BTREE,
  KEY `ind_pathname` (`pathname`) USING BTREE,
  KEY `ind_category_id_pid` (`category_id`,`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='car_category_config';


CREATE TABLE `car_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `category_name` varchar(127) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `min_price` varchar(127) DEFAULT NULL,
  `description` varchar(127) DEFAULT NULL,
  `auto_series_id` int(11) DEFAULT NULL,
  `auto_category_id` int(11) DEFAULT NULL,
  `engine_description` varchar(127) DEFAULT NULL,
  `series_id` int(11) DEFAULT NULL,
  `stop_sell` tinyint(1) NOT NULL DEFAULT '0',
  `good_label` varchar(2048) DEFAULT NULL,
  `bad_label` varchar(2048) DEFAULT NULL,
  `year_value` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `car_category_auto_category_id_pk` (`auto_category_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `car_series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `factory_name` varchar(128) DEFAULT NULL COMMENT '工厂名称',
  `series_name` varchar(128) NOT NULL COMMENT '车系名称',
  `imgurl` varchar(1024) NOT NULL COMMENT '图片链接',
  `level_id` int(11) DEFAULT NULL COMMENT '型号id',
  `level_name` varchar(64) DEFAULT NULL COMMENT '车辆型号',
  `price` varchar(128) DEFAULT '0' COMMENT '价格',
  `auto_series_id` int(11) DEFAULT NULL COMMENT '汽车之家 车系id',
  `auto_brand_id` int(11) DEFAULT NULL COMMENT '汽车之家 品牌id',
  `brand_id` int(11) DEFAULT NULL COMMENT '表car_brand的id',
  `inner_color` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '内饰颜色',
  `outer_color` varchar(2048) NOT NULL DEFAULT '[]' COMMENT '外饰颜色 ',
  `outer_img` varchar(2018) DEFAULT NULL,
  `central_control_img` varchar(2048) DEFAULT NULL,
  `seat_img` varchar(2048) DEFAULT NULL,
  `good_label` varchar(2048) DEFAULT NULL,
  `bad_label` varchar(2048) DEFAULT NULL,
  `isar` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有ar',
  `isvr` tinyint(1) NOT NULL DEFAULT '0',
  `vr_url` varchar(1024) DEFAULT '' COMMENT 'vr看车的url地址',
  `sort` int(11) NOT NULL DEFAULT '65536' COMMENT '排序值',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `car_series_auto_series_id_pk` (`auto_series_id`) USING BTREE,
  KEY `brand_id_index` (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `car_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auto_brand_id` int(11) NOT NULL,
  `letter` varchar(1) NOT NULL,
  `brand_name` varchar(64) NOT NULL,
  `logo_url` varchar(255) DEFAULT '',
  `country` varchar(30) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT '65536' COMMENT '排序值',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
