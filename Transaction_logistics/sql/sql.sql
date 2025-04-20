/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80019 (8.0.19)
 Source Host           : localhost:3306
 Source Schema         : transaction_logistics

 Target Server Type    : MySQL
 Target Server Version : 80019 (8.0.19)
 File Encoding         : 65001

 Date: 20/04/2025 13:56:23
*/
use transaction_logistics;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
                            `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系人',
                            `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系地址',
                            `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
                            `user_id` int NULL DEFAULT NULL COMMENT '关联用户',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收货地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (4, '陈俊圻', '西安培华学院', '13398776644', 7);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
                          `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                          `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
                          `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
                          `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
                          `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
                          `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
                          `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
                          `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/1745076296130-极限竞速：地平线 4 2024_11_26 18_44_12 (1).png', 'ADMIN', '13677889922', 'admin@xm.com');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
                             `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                             `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '日常用品');
INSERT INTO `category` VALUES (2, '电子设备');
INSERT INTO `category` VALUES (3, '服装鞋帽');
INSERT INTO `category` VALUES (4, '运动及户外装备');
INSERT INTO `category` VALUES (5, '玩具与收藏品');
INSERT INTO `category` VALUES (6, '婴儿用品');

-- ----------------------------
-- Table structure for chat_group
-- ----------------------------
DROP TABLE IF EXISTS `chat_group`;
CREATE TABLE `chat_group`  (
                               `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                               `chat_user_id` int NULL DEFAULT NULL COMMENT '聊天用户ID',
                               `user_id` int NULL DEFAULT NULL COMMENT '当前用户ID',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天组' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_group
-- ----------------------------
INSERT INTO `chat_group` VALUES (6, 6, 7);
INSERT INTO `chat_group` VALUES (7, 7, 6);

-- ----------------------------
-- Table structure for chat_info
-- ----------------------------
DROP TABLE IF EXISTS `chat_info`;
CREATE TABLE `chat_info`  (
                              `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                              `chat_user_id` int NULL DEFAULT NULL COMMENT '聊天用户ID',
                              `user_id` int NULL DEFAULT NULL COMMENT '当前用户ID',
                              `text` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '聊天内容',
                              `isread` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '否' COMMENT '是否已读',
                              `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '时间',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '聊天信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_info
-- ----------------------------
INSERT INTO `chat_info` VALUES (13, 6, 7, '可以便宜点吗\n', '否', '2025-04-19 23:48:34');

-- ----------------------------
-- Table structure for circles
-- ----------------------------
DROP TABLE IF EXISTS `circles`;
CREATE TABLE `circles`  (
                            `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图',
                            `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '圈子' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of circles
-- ----------------------------
INSERT INTO `circles` VALUES (6, 'http://localhost:9090/files/1744951160443-OIP-C.jpg', '测试');
INSERT INTO `circles` VALUES (7, NULL, '测试2');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
                            `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `fid` int NULL DEFAULT NULL COMMENT '关联ID',
                            `user_id` int NULL DEFAULT NULL COMMENT '收藏人ID',
                            `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收藏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (10, 23, 7, NULL);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
                            `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
                            `user_id` int NULL DEFAULT NULL COMMENT '评论人',
                            `pid` int NULL DEFAULT NULL COMMENT '父级ID',
                            `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论时间',
                            `fid` int NULL DEFAULT NULL COMMENT '关联ID',
                            `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
                            `root_id` int NULL DEFAULT NULL COMMENT '根节点ID',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (14, '1', 6, NULL, '2025-04-19 23:14:56', 8, 'help', 14);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
                             `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                             `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '主题',
                             `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
                             `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
                             `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
                             `reply` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '回复',
                             `createtime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
                             `user_id` int NULL DEFAULT NULL COMMENT '提交人ID',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '反馈信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (15, '商品内容', '内容太少', NULL, NULL, NULL, '2025-04-19 23:47:54', 7);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
                          `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                          `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
                          `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
                          `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '详情',
                          `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发货地址',
                          `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
                          `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上架日期',
                          `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
                          `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类',
                          `user_id` int NULL DEFAULT NULL COMMENT '所属用户ID',
                          `sale_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上架状态',
                          `read_count` int NULL DEFAULT 0 COMMENT '浏览量',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '二手商品' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (26, '全套厨房用具', 10.00, '<p>一整套厨房用具九成新</p>', '西安培华学院', 'http://localhost:9090/files/1744951160443-OIP-C.jpg', '2025-04-18', '通过', '日常用品', 6, '上架', 4);
INSERT INTO `goods` VALUES (28, '二手手机', 1500.00, '<p>九成新</p>', '西安培华学院', 'http://localhost:9090/files/1744952146236-18037323_115952892108_2.jpg', '2025-04-18', '通过', '电子设备', 6, '上架', 0);
INSERT INTO `goods` VALUES (29, '二手短袖', 5.00, '<p>只穿过一次的衣服</p>', '西安', 'http://localhost:9090/files/1744952429886-R-C.jpg', '2025-04-18', '通过', '服装鞋帽', 6, '上架', 1);
INSERT INTO `goods` VALUES (30, '运用设备', 20.00, '<p>个人的一整套运动用品，略有磨损</p>', '西安', 'http://localhost:9090/files/1744952522108-true.jpg', '2025-04-18', '通过', '运动及户外装备', 6, '上架', 0);
INSERT INTO `goods` VALUES (31, '玩偶', 5.00, '<p>里面玩偶任选一个，一律五元</p>', '西安', 'http://localhost:9090/files/1744952615145-7120.jpg_wh860.jpg', '2025-04-18', '通过', '玩具与收藏品', 6, '上架', 0);
INSERT INTO `goods` VALUES (32, '婴儿奶瓶', 2.00, '<p>岗拆封，未使用过的</p>', '西安', 'http://localhost:9090/files/1744952712189-OIP-C (1).jpg', '2025-04-18', '通过', '婴儿用品', 6, '上架', 0);
INSERT INTO `goods` VALUES (33, '夏季短袖', 0.01, '', '西安', 'http://localhost:9090/files/1745072472205-R-C.jpg', '2025-04-19', '通过', '服装鞋帽', 6, '上架', 0);
INSERT INTO `goods` VALUES (34, '夏季短袖', 0.01, '', '西安', 'http://localhost:9090/files/1745072472205-R-C.jpg', '2025-04-19', '通过', '服装鞋帽', 6, '上架', 0);
INSERT INTO `goods` VALUES (35, '九成新帽子', 30.00, '<p>自用九成新</p>', '西安', 'http://localhost:9090/files/1745077398430-0e230b3110232efd.jpg', '2025-04-19', '通过', '服装鞋帽', 6, '上架', 0);
INSERT INTO `goods` VALUES (36, '婴儿奶瓶', 5.00, '', '西安', 'http://localhost:9090/files/1745077434182-8923225828_1629657878.jpg', '2025-04-19', '通过', '婴儿用品', 6, '上架', 0);
INSERT INTO `goods` VALUES (37, '相机', 500.00, '<p>八成新</p>', '北京', 'http://localhost:9090/files/1745077501263-90.jpg', '2025-04-19', '通过', '电子设备', 6, '上架', 0);
INSERT INTO `goods` VALUES (38, '益智玩具', 20.00, '', '上海', 'http://localhost:9090/files/1745077544953-3512.jpg_wh860.jpg', '2025-04-19', '通过', '玩具与收藏品', 6, '上架', 0);
INSERT INTO `goods` VALUES (39, '苹果手机', 2000.00, '<p>全新自用未拆封</p>', '西安', 'http://localhost:9090/files/1745077579004-8fcaf35aba037bfb.png!q80.png', '2025-04-19', '通过', '电子设备', 6, '上架', 0);

-- ----------------------------
-- Table structure for help
-- ----------------------------
DROP TABLE IF EXISTS `help`;
CREATE TABLE `help`  (
                         `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                         `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
                         `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
                         `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
                         `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '状态',
                         `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
                         `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
                         `solved` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否解决',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '求助信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of help
-- ----------------------------
INSERT INTO `help` VALUES (8, '急需一个二手手机', '2000块钱以内，需要卖家会进行数据转移', NULL, '通过', 6, '2025-04-18 13:08:18', '未解决');
INSERT INTO `help` VALUES (9, '急需一台二手相机', '急需一台二手相机', 'http://localhost:9090/files/1745077766363-9664.jpg_wh860.jpg', '待审核', 7, '2025-04-19 23:49:38', '未解决');

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
                          `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                          `fid` int NULL DEFAULT NULL COMMENT '关联ID',
                          `user_id` int NULL DEFAULT NULL COMMENT '点赞人ID',
                          `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '模块',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '点赞' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of likes
-- ----------------------------
INSERT INTO `likes` VALUES (16, 23, 7, NULL);
INSERT INTO `likes` VALUES (17, 25, 7, NULL);

-- ----------------------------
-- Table structure for logistics
-- ----------------------------
DROP TABLE IF EXISTS `logistics`;
CREATE TABLE `logistics`  (
                              `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                              `sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发货人',
                              `trackingNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '快递单号',
                              `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人',
                              `coordinates` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经纬度坐标',
                              `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '状态',
                              `shippingTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发货时间',
                              `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
                              `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '维度',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '物流信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of logistics
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
                           `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
                           `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
                           `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
                           `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (4, '双十一抢购', '活动期间满200立减五十，满三百立减六十，以此类推。', '2025-04-19', 'admin');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
                           `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
                           `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品图片',
                           `order_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单编号',
                           `total` decimal(10, 2) NULL DEFAULT NULL COMMENT '总价',
                           `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下单时间',
                           `pay_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付单号',
                           `pay_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付时间',
                           `user_id` int NULL DEFAULT NULL COMMENT '下单人ID',
                           `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货地址',
                           `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
                           `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人名称',
                           `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单状态',
                           `sale_id` int NULL DEFAULT NULL COMMENT '卖家ID',
                           `trackingNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (12, '全套厨房用具', 'http://localhost:9090/files/1744951160443-OIP-C.jpg', '17450778443568008146', 10.00, '2025-04-19 23:50:44', NULL, NULL, 7, '西安培华学院', '13398776644', NULL, '待支付', 6, NULL);

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
                          `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                          `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
                          `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
                          `img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
                          `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
                          `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发布时间',
                          `circle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '圈子',
                          `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
                          `read_count` int NULL DEFAULT 0 COMMENT '浏览量',
                          `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (10, '测试', '<p>这个东西非常好</p>', 'http://localhost:9090/files/1745075521178-7120.jpg_wh860.jpg', 6, '2025-04-19 23:12:14', '测试2', '测试', 0, '通过');
INSERT INTO `posts` VALUES (11, '测试11111', '<p>111</p>', 'http://localhost:9090/files/1745075613402-R-C.jpg', 6, '2025-04-19 23:13:35', '测试', '111', 1, '通过');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
                         `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
                         `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
                         `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
                         `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
                         `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
                         `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
                         `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (6, 'cjq', '123', 'cjq', 'http://localhost:9090/files/1745077297135-极限竞速：地平线 4 2024_11_9 8_48_51.png', 'USER', NULL, NULL);
INSERT INTO `user` VALUES (7, 'ylj', '123', 'ylj', 'http://localhost:9090/files/1745077731135-Naraka 2022_4_15 22_45_12.png', 'USER', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
