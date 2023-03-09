/*
 Navicat PostgreSQL Data Transfer

 Source Server         : local
 Source Server Type    : PostgreSQL
 Source Server Version : 140002 (140002)
 Source Host           : localhost:5432
 Source Catalog        : hungry
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 140002 (140002)
 File Encoding         : 65001

 Date: 07/03/2023 16:51:53
*/


-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS "goods";
CREATE TABLE "goods" (
  "id" serial NOT NULL,
  "name" varchar(20) NOT NULL,
  "id_type" int4 NOT NULL,
  "id_creator" int4 NOT NULL,
  "current_price" float4,
  "origin_price" float4,
  "rate" float4,
  PRIMARY KEY ("id")
)
;
COMMENT ON COLUMN "goods"."id" IS 'ID';
COMMENT ON COLUMN "goods"."name" IS '食物名称';
COMMENT ON COLUMN "goods"."id_type" IS '类型ID';
COMMENT ON COLUMN "goods"."id_creator" IS '创建者ID';
COMMENT ON COLUMN "goods"."current_price" IS '现价';
COMMENT ON COLUMN "goods"."origin_price" IS '原价';
COMMENT ON COLUMN "goods"."rate" IS '折扣（0~10）';

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO "goods" ("name", "id_type", "id_creator", "current_price", "origin_price", "rate") VALUES ('宫爆鸡丁', 1, 4, 12, 15, 8);
INSERT INTO "goods" ("name", "id_type", "id_creator", "current_price", "origin_price", "rate") VALUES ('香辣排骨', 1, 4, 16, 20, 8);
INSERT INTO "goods" ("name", "id_type", "id_creator", "current_price", "origin_price", "rate") VALUES ('九曲人参', 1, 4, 180, 200, 9);

-- ----------------------------
-- Table structure for type_of_goods
-- ----------------------------
DROP TABLE IF EXISTS "type_of_goods";
CREATE TABLE "type_of_goods" (
  "id" serial NOT NULL,
  "description" varchar(20),
  PRIMARY KEY ("id")
);
COMMENT ON COLUMN "type_of_goods"."id" IS 'ID';
COMMENT ON COLUMN "type_of_goods"."description" IS '描述';

-- ----------------------------
-- Records of type_of_goods
-- ----------------------------
INSERT INTO "type_of_goods" ("description") VALUES ('菜品');
INSERT INTO "type_of_goods" ("description") VALUES ('主食');
INSERT INTO "type_of_goods" ("description") VALUES ('酒水');
INSERT INTO "type_of_goods" ("description") VALUES ('其它');

-- ----------------------------
-- Table structure for type_of_orders
-- ----------------------------
DROP TABLE IF EXISTS "type_of_orders";
CREATE TABLE "type_of_orders" (
  "id" serial NOT NULL,
  "description" varchar(20),
  PRIMARY KEY ("id")
);
COMMENT ON COLUMN "type_of_orders"."id" IS 'ID';
COMMENT ON COLUMN "type_of_orders"."description" IS '描述';

-- ----------------------------
-- Records of type_of_orders
-- ----------------------------
INSERT INTO "type_of_orders" ("description") VALUES ('消费');
INSERT INTO "type_of_orders" ("description") VALUES ('业务办理');
INSERT INTO "type_of_orders" ("description") VALUES ('理赔');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS "orders";
CREATE TABLE "orders" (
  "id" serial NOT NULL,
  "id_type" int4 NOT NULL,
  "id_creator" int4 NOT NULL,
  "id_goods" int4 NOT NULL,
  "price_unit" float4,
  "quantity" int4,
  "price_total" float4,
  "rate" float4,
  "created" timestamp,
  "updated" timestamp,
  "status" char default '0'::bpchar,
  PRIMARY KEY ("id")
);
COMMENT ON COLUMN "orders"."id" IS 'ID';
COMMENT ON COLUMN "orders"."id_type" IS '类型ID';
COMMENT ON COLUMN "orders"."id_creator" IS '创建者ID';
COMMENT ON COLUMN "orders"."id_goods" IS '商品ID';
COMMENT ON COLUMN "orders"."price_unit" IS '单价';
COMMENT ON COLUMN "orders"."quantity" IS '数量';
COMMENT ON COLUMN "orders"."price_total" IS '总价';
COMMENT ON COLUMN "orders"."rate" IS '折扣（0~10）';
COMMENT ON COLUMN "orders"."created" IS '创建时间';
COMMENT ON COLUMN "orders"."updated" IS '更新时间';
COMMENT ON COLUMN "orders"."status" IS '状态';

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO "orders" ("id_type", "id_creator", "id_goods", "price_unit", "rate", "quantity", "price_total", "created", "updated", "status") VALUES (1, 7, 1, 12.00, 8.0, 1, 12.00, now(), now(), 1);
INSERT INTO "orders" ("id_type", "id_creator", "id_goods", "price_unit", "rate", "quantity", "price_total", "created", "updated", "status") VALUES (1, 8, 1, 12.00, 8.0, 2, 24.00, now(), now(), 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "users";
CREATE TABLE "users" (
  "id" serial NOT NULL,
  "id_creator" int4 NOT NULL,
  "username" varchar(20) NOT NULL,
  "purse" varchar(128) NOT NULL,
  "role" varchar(20),
  PRIMARY KEY ("id")
);
COMMENT ON COLUMN "users"."id" IS 'ID';
COMMENT ON COLUMN "users"."id_creator" IS '创建者ID';
COMMENT ON COLUMN "users"."username" IS '用户名';
COMMENT ON COLUMN "users"."purse" IS '访问口令';
COMMENT ON COLUMN "users"."role" IS '角色';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "users" ("id_creator", "username", "purse", "role") VALUES (1, 'super', '123456', 'super');
INSERT INTO "users" ("id_creator", "username", "purse", "role") VALUES (1, 'admin', '123456', 'admin');
INSERT INTO "users" ("id_creator", "username", "purse", "role") VALUES (2, '小白', '123456', 'business');
INSERT INTO "users" ("id_creator", "username", "purse", "role") VALUES (2, '小花', '123456', 'business');
INSERT INTO "users" ("id_creator", "username", "purse", "role") VALUES (2, '小亮', '123456', 'business');
INSERT INTO "users" ("id_creator", "username", "purse", "role") VALUES (2, '小明', '123456', 'business');
INSERT INTO "users" ("id_creator", "username", "purse", "role") VALUES (2, '坏蛋', '123456', 'consumer');
INSERT INTO "users" ("id_creator", "username", "purse", "role") VALUES (2, '笨蛋', '123456', 'consumer');