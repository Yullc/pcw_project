CREATE DATABASE `pcw_project`;
USE `pcw_project`;

CREATE TABLE `User` (
                        `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        `loginId`	CHAR(30)	NOT NULL,
                        `loginPw`	CHAR(100)	NOT NULL,
                        `poneNm`	INT	NOT NULL,
                        `bornDate`	DATETIME	NOT NULL,
                        `area`	CHAR(20)	NOT NULL,
                        `gender`	CHAR(20)	NOT NULL,
                        `name`	CHAR(20)	NOT NULL,
                        `nickName`	CHAR(20)	NOT NULL,
                        `regDate`	DATETIME	NOT NULL,
                        `authLevel`	CHAR(20)	NOT NULL,
                        `rank`	CHAR(20)	NOT NULL,
                        `delStatus`	TINYINT(1) UNSIGNED	NOT NULL,
                        `delDate`	DATETIME	NULL,
                        `manner`	FLOAT	NULL,
                        `teamNm`	CHAR(20)	NULL
);

CREATE TABLE `scArticle` (
                             `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             `regDate`	DATETIME	NOT NULL,
                             `playDate`	DATETIME	NOT NULL,
                             `title`	CHAR(100)	NOT NULL,
                             `body`	CHAR(200)	NOT NULL,
                             `area`	CHAR(20)	NOT NULL,
                             `stadium`	CHAR(100)	NOT NULL,
                             `avgLevel`	CHAR(20)	NOT NULL,
                             `boardId`	INT	NOT NULL
);

CREATE TABLE `ftArticle` (
                             `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             `regDate`	DATETIME	NOT NULL,
                             `playDate`	DATETIME	NOT NULL,
                             `title`	CHAR(100)	NOT NULL,
                             `body`	CHAR(200)	NOT NULL,
                             `area`	CHAR(20)	NOT NULL,
                             `stadium`	CHAR(100)	NOT NULL,
                             `avgLevel`	CHAR(20)	NOT NULL,
                             `boardId`	INT	NOT NULL
);

CREATE TABLE `board` (
                         `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         `regDate` DATETIME NOT NULL,
                         `updateDate` DATETIME NOT NULL,
                         `name` CHAR(20) NOT NULL,
                         `delStatus` TINYINT(1) UNSIGNED NOT NULL,
                         `delDate` DATETIME
);


CREATE TABLE `like` (
                        `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        `regDate`	DATETIME	NOT NULL,
                        `updateDate`	DATETIME	NOT NULL,
                        `likePoint`	INT	NOT NULL,
                        `userId`	INT	NOT NULL
);

CREATE TABLE `manner` (
                          `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          `regDate`	DATETIME	NOT NULL,
                          `updateDate`	DATETIME	NOT NULL,
                          `manner`	FLOAT	NOT NULL,
                          `userId`	INT	NOT NULL
);

CREATE TABLE `message` (
                           `id`	INT	NOT NULL,
                           `regDate`	DATETIME	NOT NULL,x
                           `title`	CHAR(100)	NOT NULL,
                           `body`	CHAR(200)	NOT NULL,
                           `userId`	CHAR(20)	NOT NULL
);

CREATE TABLE `team` (
                        `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        `regDate`	DATETIME	NOT NULL,
                        `updateDate`	DATETIME	NOT NULL,
                        `teamNm`	CHAR(20)	NOT NULL,
                        `teamRank`	CHAR(20)	NOT NULL
);