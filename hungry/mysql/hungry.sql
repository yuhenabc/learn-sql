/*
 Navicat MySQL Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50738 (5.7.38)
 Source Host           : localhost:3306
 Source Schema         : hungry

 Target Server Type    : MySQL
 Target Server Version : 50738 (5.7.38)
 File Encoding         : 65001

 Date: 07/03/2023 13:20:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '食物名称',
  `id_type` int(8) UNSIGNED NOT NULL COMMENT '类型ID',
  `id_creator` int(8) UNSIGNED NOT NULL COMMENT '创建者ID',
  `current_price` float(8, 2) NULL DEFAULT NULL COMMENT '现价',
  `origin_price` float(8, 2) NULL DEFAULT NULL COMMENT '原价',
  `rate` float(2, 1) NULL DEFAULT NULL COMMENT '折扣（0~10）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_goods_creator`(`id_creator`) USING BTREE,
  INDEX `idx_goods_type`(`id_type`) USING BTREE,
  CONSTRAINT `fk_goods_creator` FOREIGN KEY (`id_creator`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_goods_type` FOREIGN KEY (`id_type`) REFERENCES `type_of_goods` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '宫爆鸡丁', 1, 4, 12.00, 15.00, 8.0);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_type` int(8) UNSIGNED NOT NULL COMMENT '类型ID',
  `id_creator` int(8) UNSIGNED NOT NULL COMMENT '创建者ID',
  `id_goods` int(8) UNSIGNED NOT NULL COMMENT '商品ID',
  `price_unit` float(8, 2) NULL DEFAULT NULL COMMENT '单价',
  `rate` float(2, 1) NULL DEFAULT NULL COMMENT '折扣（0~10）',
  `quantity` int(10) NULL DEFAULT NULL COMMENT '数量',
  `price_total` float(12, 2) NULL DEFAULT NULL COMMENT '总价',
  `created` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_orders_type`(`id_type`) USING BTREE,
  INDEX `idx_orders_creator`(`id_creator`) USING BTREE,
  INDEX `idx_orders_goods`(`id_goods`) USING BTREE,
  CONSTRAINT `fk_orders_creator` FOREIGN KEY (`id_creator`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_goods` FOREIGN KEY (`id_goods`) REFERENCES `goods` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_type` FOREIGN KEY (`id_type`) REFERENCES `type_of_orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 7, 1, 12.00, 8.0, 1, 12.00, '2022-07-22 05:33:11', '2022-07-22 05:33:11', 1);
INSERT INTO `orders` VALUES (2, 1, 8, 1, 12.00, 8.0, 2, 24.00, '2022-07-22 05:33:11', '2022-07-22 05:33:11', 1);

-- ----------------------------
-- Table structure for type_of_goods
-- ----------------------------
DROP TABLE IF EXISTS `type_of_goods`;
CREATE TABLE `type_of_goods`  (
  `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type_of_goods
-- ----------------------------
INSERT INTO `type_of_goods` VALUES (1, '菜品');
INSERT INTO `type_of_goods` VALUES (2, '主食');
INSERT INTO `type_of_goods` VALUES (3, '酒水');
INSERT INTO `type_of_goods` VALUES (4, '其它');

-- ----------------------------
-- Table structure for type_of_orders
-- ----------------------------
DROP TABLE IF EXISTS `type_of_orders`;
CREATE TABLE `type_of_orders`  (
  `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type_of_orders
-- ----------------------------
INSERT INTO `type_of_orders` VALUES (1, '消费');
INSERT INTO `type_of_orders` VALUES (2, '业务办理');
INSERT INTO `type_of_orders` VALUES (3, '理赔');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_creator` int(8) UNSIGNED NOT NULL COMMENT '创建者ID',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户名',
  `purse` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '访问口令',
  `role` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 1, 'super', '123456', 'super');
INSERT INTO `users` VALUES (2, 1, 'admin', '123456', 'admin');
INSERT INTO `users` VALUES (3, 2, '小白', '123456', 'business');
INSERT INTO `users` VALUES (4, 2, '小花', '123456', 'business');
INSERT INTO `users` VALUES (5, 2, '小亮', '123456', 'business');
INSERT INTO `users` VALUES (6, 2, '小明', '123456', 'business');
INSERT INTO `users` VALUES (7, 2, '坏蛋', '123456', 'consumer');
INSERT INTO `users` VALUES (8, 2, '笨蛋', '123456', 'consumer');

-- ----------------------------
-- View structure for v_orders
-- ----------------------------
DROP VIEW IF EXISTS `v_orders`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_orders` AS (select `O`.`id` AS `id`,`G`.`name` AS `goods_name`,`GT`.`description` AS `goods_type`,`B`.`username` AS `goods_creator`,`C`.`username` AS `order_creator`,`OT`.`description` AS `order_type`,`O`.`price_unit` AS `price_unit`,`O`.`quantity` AS `quantity`,`O`.`price_total` AS `price_total` from (((((`orders` `O` join `goods` `G`) join `users` `B`) join `users` `C`) join `type_of_goods` `GT`) join `type_of_orders` `OT`) where ((`G`.`id` = `O`.`id_goods`) and (`B`.`id` = `G`.`id_creator`) and (`C`.`id` = `O`.`id_creator`) and (`GT`.`id` = `G`.`id_type`) and (`OT`.`id` = `O`.`id_type`)) order by `O`.`id`);

SET FOREIGN_KEY_CHECKS = 1;
