/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50622
Source Host           : localhost:3306
Source Database       : bbs

Target Server Type    : MYSQL
Target Server Version : 50622
File Encoding         : 65001

Date: 2016-07-03 22:57:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `publish_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `view_count` int(11) DEFAULT '0',
  `reply_count` int(11) DEFAULT '0',
  `last_reply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('2', 'dsa', '2016-06-03 20:19:36', '1', '1', '0', '0', '2016-06-03 20:49:33');
INSERT INTO `article` VALUES ('11', 'manager', '2016-06-03 22:36:04', '2', '1', '5', '0', '2016-06-03 22:36:04');
INSERT INTO `article` VALUES ('12', 'manager test打', '2016-06-03 22:37:56', '2', '1', '67', '3', '2016-06-03 22:37:56');
INSERT INTO `article` VALUES ('13', 'dsa', '2016-06-03 22:40:34', '1', '1', '101', '5', '2016-06-20 22:11:51');
INSERT INTO `article` VALUES ('15', '中文', '2016-06-14 08:42:56', '1', '1', '36', '3', '2016-06-14 08:42:56');
INSERT INTO `article` VALUES ('27', 'c#', '2016-06-19 13:00:15', '1', '2', '32', '3', '2016-06-20 00:08:22');
INSERT INTO `article` VALUES ('31', 'test', '2016-06-20 23:06:32', '1', '1', '19', '8', '2016-06-23 15:33:24');
INSERT INTO `article` VALUES ('32', '发帖测试', '2016-06-23 16:37:28', '2', '10', '1', '0', '2016-06-23 16:37:28');

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', 'Java专区');
INSERT INTO `category` VALUES ('2', 'C#专区');
INSERT INTO `category` VALUES ('3', '灌水专区');
INSERT INTO `category` VALUES ('10', '自由专区');

-- ----------------------------
-- Table structure for `category_master`
-- ----------------------------
DROP TABLE IF EXISTS `category_master`;
CREATE TABLE `category_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `category_master_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_master_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of category_master
-- ----------------------------
INSERT INTO `category_master` VALUES ('1', '1', '2');
INSERT INTO `category_master` VALUES ('6', '1', '3');
INSERT INTO `category_master` VALUES ('7', '2', '2');
INSERT INTO `category_master` VALUES ('8', '3', '2');

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comment_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `parent_id` (`parent_id`),
  KEY `comment_ibfk_2` (`article_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', 'this is manager', '2016-06-03 22:36:04', '2', '11', null, '1');
INSERT INTO `comment` VALUES ('2', '中文能存吗', '2016-06-03 22:37:56', '2', '12', null, '1');
INSERT INTO `comment` VALUES ('3', 'dsadsa', '2016-06-03 22:40:34', '1', '13', null, '1');
INSERT INTO `comment` VALUES ('6', 'abcd', '2016-06-07 00:01:10', '1', '13', null, '3');
INSERT INTO `comment` VALUES ('7', '测试', '2016-06-14 08:42:56', '1', '15', null, '1');
INSERT INTO `comment` VALUES ('28', 'c#c#c#c#c#c#c#c#c#c#', '2016-06-19 13:00:15', '1', '27', null, '1');
INSERT INTO `comment` VALUES ('33', 'dsadsa', '2016-06-19 13:39:59', '36', '27', null, '3');
INSERT INTO `comment` VALUES ('35', 'dsadsa', '2016-06-19 23:49:54', '1', '12', '2', '3');
INSERT INTO `comment` VALUES ('36', 'dsadsa', '2016-06-19 23:50:03', '1', '12', '35', '4');
INSERT INTO `comment` VALUES ('37', 'dsadsa', '2016-06-20 00:08:22', '1', '27', '33', '4');
INSERT INTO `comment` VALUES ('38', '回复', '2016-06-20 08:57:44', '36', '13', '6', '4');
INSERT INTO `comment` VALUES ('40', 'dsa', '2016-06-20 22:11:51', '1', '13', '39', '6');
INSERT INTO `comment` VALUES ('41', '1', '2016-06-20 23:06:32', '1', '31', null, '1');
INSERT INTO `comment` VALUES ('43', '2', '2016-06-20 23:06:44', '1', '31', '42', '3');
INSERT INTO `comment` VALUES ('45', '4', '2016-06-20 23:09:09', '1', '31', '44', '5');
INSERT INTO `comment` VALUES ('47', 'abc', '2016-06-23 15:32:50', '2', '31', '46', '7');
INSERT INTO `comment` VALUES ('48', '11', '2016-06-23 15:33:07', '2', '31', '47', '8');
INSERT INTO `comment` VALUES ('49', '111', '2016-06-23 15:33:24', '2', '31', '48', '9');
INSERT INTO `comment` VALUES ('50', '这里是帖子的内容', '2016-06-23 16:37:28', '2', '32', null, '1');

-- ----------------------------
-- Table structure for `permission`
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '添加用户', 'admin/user/add');
INSERT INTO `permission` VALUES ('2', '删除用户', 'admin/user/delete');
INSERT INTO `permission` VALUES ('3', '增加板块', 'admin/category/add');
INSERT INTO `permission` VALUES ('4', '删除板块', 'admin/category/delete');
INSERT INTO `permission` VALUES ('5', '任命版主', 'admin/category/authorize');
INSERT INTO `permission` VALUES ('6', '删除帖子', 'article/delete');
INSERT INTO `permission` VALUES ('7', '发表帖子', 'article/publish');
INSERT INTO `permission` VALUES ('8', '发表回复', 'comment/add');
INSERT INTO `permission` VALUES ('9', '删除回复', 'comment/delete');
INSERT INTO `permission` VALUES ('10', '删除自己帖子', 'article/delown');
INSERT INTO `permission` VALUES ('11', '删除自己回复', 'comment/delown');
INSERT INTO `permission` VALUES ('12', '删除自己帖子回复', 'article/delowncmt');
INSERT INTO `permission` VALUES ('13', '用户管理', 'admin/user');
INSERT INTO `permission` VALUES ('14', '板块管理', 'admin/category');
INSERT INTO `permission` VALUES ('15', '撤销版主', 'admin/category/revoke');
INSERT INTO `permission` VALUES ('16', '版主管理', 'admin/category/master');
INSERT INTO `permission` VALUES ('17', '修改板块', 'admin/category/edit');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '系统管理员');
INSERT INTO `role` VALUES ('2', '板块管理员');
INSERT INTO `role` VALUES ('3', '普通用户');

-- ----------------------------
-- Table structure for `role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('1', '1', '1');
INSERT INTO `role_permission` VALUES ('2', '1', '2');
INSERT INTO `role_permission` VALUES ('3', '1', '3');
INSERT INTO `role_permission` VALUES ('4', '1', '4');
INSERT INTO `role_permission` VALUES ('5', '1', '5');
INSERT INTO `role_permission` VALUES ('6', '1', '6');
INSERT INTO `role_permission` VALUES ('7', '1', '7');
INSERT INTO `role_permission` VALUES ('8', '1', '8');
INSERT INTO `role_permission` VALUES ('9', '1', '9');
INSERT INTO `role_permission` VALUES ('10', '1', '10');
INSERT INTO `role_permission` VALUES ('11', '1', '11');
INSERT INTO `role_permission` VALUES ('12', '1', '12');
INSERT INTO `role_permission` VALUES ('13', '2', '6');
INSERT INTO `role_permission` VALUES ('14', '2', '7');
INSERT INTO `role_permission` VALUES ('15', '2', '8');
INSERT INTO `role_permission` VALUES ('16', '2', '9');
INSERT INTO `role_permission` VALUES ('17', '2', '10');
INSERT INTO `role_permission` VALUES ('18', '2', '11');
INSERT INTO `role_permission` VALUES ('19', '2', '12');
INSERT INTO `role_permission` VALUES ('20', '3', '7');
INSERT INTO `role_permission` VALUES ('21', '3', '8');
INSERT INTO `role_permission` VALUES ('22', '3', '10');
INSERT INTO `role_permission` VALUES ('23', '3', '11');
INSERT INTO `role_permission` VALUES ('24', '3', '12');
INSERT INTO `role_permission` VALUES ('25', '1', '13');
INSERT INTO `role_permission` VALUES ('26', '1', '14');
INSERT INTO `role_permission` VALUES ('27', '1', '15');
INSERT INTO `role_permission` VALUES ('28', '1', '16');
INSERT INTO `role_permission` VALUES ('29', '1', '17');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `icon_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'static/images/head.gif',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '1234', 'upload/01250d25-b4d3-4108-a06a-6b8273177501.png', null);
INSERT INTO `user` VALUES ('2', 'manager', '1234', 'static/images/head.gif', null);
INSERT INTO `user` VALUES ('3', 'zhangsan', '1234', 'static/images/head.gif', null);
INSERT INTO `user` VALUES ('31', '33', '1', 'static/images/head.gif', 'test@qq.com');
INSERT INTO `user` VALUES ('36', 'sad', 'sad', 'static/images/head.gif', null);
INSERT INTO `user` VALUES ('39', 'test', '1234', 'static/images/head.gif', 'test@qq.com');
INSERT INTO `user` VALUES ('41', '1', '1', '1', '1');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1', '1');
INSERT INTO `user_role` VALUES ('2', '2', '2');
INSERT INTO `user_role` VALUES ('3', '3', '2');
INSERT INTO `user_role` VALUES ('4', '31', '3');
INSERT INTO `user_role` VALUES ('8', '36', '3');
INSERT INTO `user_role` VALUES ('11', '39', '3');
