/*
Navicat MySQL Data Transfer

Source Server         : MYSQL55
Source Server Version : 50561
Source Host           : localhost:3306
Source Database       : survey

Target Server Type    : MYSQL
Target Server Version : 50561
File Encoding         : 65001

Date: 2021-06-27 16:04:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_admin
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin`;
CREATE TABLE `tb_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_admin
-- ----------------------------
INSERT INTO `tb_admin` VALUES ('1', 'admin', '433db2fa87c8e880868dcf6ae9c2fca2', 'admin', '17805016202', null);
INSERT INTO `tb_admin` VALUES ('2', 'lyf', '433db2fa87c8e880868dcf6ae9c2fca2', 'lyf', null, null);
INSERT INTO `tb_admin` VALUES ('3', 'slx', '433db2fa87c8e880868dcf6ae9c2fca2', 'slx', null, null);
INSERT INTO `tb_admin` VALUES ('4', 'llh', '433db2fa87c8e880868dcf6ae9c2fca2', 'llh', null, null);
INSERT INTO `tb_admin` VALUES ('5', 'ly', '433db2fa87c8e880868dcf6ae9c2fca2', 'ly', null, null);

-- ----------------------------
-- Table structure for tb_answer_opt
-- ----------------------------
DROP TABLE IF EXISTS `tb_answer_opt`;
CREATE TABLE `tb_answer_opt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `opt_id` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL COMMENT '1radio|2checkbox',
  `create_time` datetime DEFAULT NULL,
  `voter` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_2` (`opt_id`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`opt_id`) REFERENCES `tb_question_opt` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_answer_opt
-- ----------------------------
INSERT INTO `tb_answer_opt` VALUES ('7', '6', '6', '13', '1', '2021-06-04 19:41:02', 'ff5f3052-6cc7-41ef-8aaa-0801ea87b04f');
INSERT INTO `tb_answer_opt` VALUES ('8', '6', '7', '15', '2', '2021-06-04 19:41:03', 'ff5f3052-6cc7-41ef-8aaa-0801ea87b04f');
INSERT INTO `tb_answer_opt` VALUES ('9', '6', '7', '16', '2', '2021-06-04 19:41:03', 'ff5f3052-6cc7-41ef-8aaa-0801ea87b04f');
INSERT INTO `tb_answer_opt` VALUES ('10', '6', '11', '23', '1', '2021-06-04 19:41:03', 'ff5f3052-6cc7-41ef-8aaa-0801ea87b04f');
INSERT INTO `tb_answer_opt` VALUES ('11', '6', '18', '49', '2', '2021-06-04 19:41:03', 'ff5f3052-6cc7-41ef-8aaa-0801ea87b04f');
INSERT INTO `tb_answer_opt` VALUES ('12', '6', '18', '50', '2', '2021-06-04 19:41:03', 'ff5f3052-6cc7-41ef-8aaa-0801ea87b04f');

-- ----------------------------
-- Table structure for tb_answer_txt
-- ----------------------------
DROP TABLE IF EXISTS `tb_answer_txt`;
CREATE TABLE `tb_answer_txt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `result` varchar(200) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `voter` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_answer_txt
-- ----------------------------
INSERT INTO `tb_answer_txt` VALUES ('3', '6', '8', 'asd', '2021-06-04 19:41:03', 'ff5f3052-6cc7-41ef-8aaa-0801ea87b04f');
INSERT INTO `tb_answer_txt` VALUES ('4', '6', '9', 'asd', '2021-06-04 19:41:03', 'ff5f3052-6cc7-41ef-8aaa-0801ea87b04f');

-- ----------------------------
-- Table structure for tb_question
-- ----------------------------
DROP TABLE IF EXISTS `tb_question`;
CREATE TABLE `tb_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `type` int(1) DEFAULT NULL COMMENT '1radio|2checkbox|3text|4textarea',
  `required` int(1) DEFAULT NULL COMMENT '0�Ǳ���1����',
  `check_style` varchar(50) DEFAULT NULL COMMENT 'text;number;date',
  `order_style` int(1) DEFAULT NULL COMMENT '0˳��1���',
  `show_style` int(1) DEFAULT NULL COMMENT '1;2;3;4',
  `test` int(1) DEFAULT NULL COMMENT '0������1����',
  `score` int(3) DEFAULT NULL,
  `orderby` int(11) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `survey_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_1` (`survey_id`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`survey_id`) REFERENCES `tb_survey` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_question
-- ----------------------------
INSERT INTO `tb_question` VALUES ('6', '性别', '', '1', '1', null, null, null, '0', '0', null, null, '2021-06-03 20:28:35', '6');
INSERT INTO `tb_question` VALUES ('7', '你喜欢什么', '爱好', '2', '1', null, null, null, '0', '0', null, null, '2021-06-03 20:29:41', '6');
INSERT INTO `tb_question` VALUES ('8', '为什么喜欢', '', '3', '1', null, null, null, null, null, null, null, '2021-06-03 20:31:49', '6');
INSERT INTO `tb_question` VALUES ('9', '有什么不喜欢的', '', '4', '1', null, null, null, null, null, null, null, '2021-06-03 20:31:58', '6');
INSERT INTO `tb_question` VALUES ('11', '会不会汇编', '描述', '1', '1', null, null, null, '0', '0', null, null, '2021-06-04 09:19:58', '6');
INSERT INTO `tb_question` VALUES ('18', '你想学什么技术', '描述', '2', '1', null, null, null, '0', '0', null, null, '2021-06-04 11:06:07', '6');

-- ----------------------------
-- Table structure for tb_question_opt
-- ----------------------------
DROP TABLE IF EXISTS `tb_question_opt`;
CREATE TABLE `tb_question_opt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL COMMENT '1radio|2checkbox',
  `opt` varchar(200) DEFAULT NULL,
  `orderby` int(11) DEFAULT NULL,
  `answer` int(1) DEFAULT NULL COMMENT 'Ĭ��ΪNULL��1��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_question_opt
-- ----------------------------
INSERT INTO `tb_question_opt` VALUES ('13', '6', '6', '1', '男', '1', null);
INSERT INTO `tb_question_opt` VALUES ('14', '6', '6', '1', '女', '2', null);
INSERT INTO `tb_question_opt` VALUES ('15', '6', '7', '2', '计算机网络', '1', null);
INSERT INTO `tb_question_opt` VALUES ('16', '6', '7', '2', '算法', '2', null);
INSERT INTO `tb_question_opt` VALUES ('17', '6', '7', '2', '操作系统', '3', null);
INSERT INTO `tb_question_opt` VALUES ('18', '6', '7', '2', 'java', '4', null);
INSERT INTO `tb_question_opt` VALUES ('23', '6', '11', '1', '会', '1', null);
INSERT INTO `tb_question_opt` VALUES ('24', '6', '11', '1', '不会', '2', null);
INSERT INTO `tb_question_opt` VALUES ('49', '6', '18', '2', 'Spring', '1', null);
INSERT INTO `tb_question_opt` VALUES ('50', '6', '18', '2', 'SpringMVC', '2', null);
INSERT INTO `tb_question_opt` VALUES ('51', '6', '18', '2', 'mybatis', '3', null);
INSERT INTO `tb_question_opt` VALUES ('52', '6', '18', '2', 'SpringBoot', '4', null);

-- ----------------------------
-- Table structure for tb_survey
-- ----------------------------
DROP TABLE IF EXISTS `tb_survey`;
CREATE TABLE `tb_survey` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `bounds` int(1) DEFAULT NULL COMMENT '0:������;1:����',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `rules` int(1) DEFAULT NULL COMMENT '0����;1����',
  `password` varchar(50) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL COMMENT '������ִ���С�����',
  `logo` varchar(200) DEFAULT NULL,
  `bgimg` varchar(200) DEFAULT NULL,
  `anon` int(1) DEFAULT NULL COMMENT '0������1������',
  `creator` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_survey
-- ----------------------------
INSERT INTO `tb_survey` VALUES ('6', '我的第一份问卷', '关于计算机的问卷', '0', '2021-06-04 00:00:00', '2021-06-06 00:00:00', '0', '', 'http://localhost:8080/survey/dy/797cf09c-1332-4f65-8cc8-1a7e5d63c543', '结束', null, '31e717822a6c44b59a897c65d6c848a2_3dd72557611c4cef91871cdc31210abc_8309.jpg_wh1200.jpg', '0', '1', '2021-06-03 20:04:30');
