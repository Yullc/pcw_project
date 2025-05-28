CREATE DATABASE `pcw_project`;
USE `pcw_project`;

CREATE TABLE `member` (
                          `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          `regDate`	DATETIME	NOT NULL,
                          `updateDate`	DATETIME	NOT NULL,
                          `loginId`	CHAR(30)	NOT NULL,
                          `loginPw`	CHAR(100)	NOT NULL,
                          `poneNm`	INT	NOT NULL,
                          `bornDate`	DATETIME	NOT NULL,
                          `area`	CHAR(20)	NOT NULL,
                          `gender`	CHAR(20)	NOT NULL,
                          `name`	CHAR(20)	NOT NULL,
                          `nickName`	CHAR(20)	NOT NULL,
                          `authLevel`	CHAR(20)	NOT NULL,
                          `rank`	CHAR(20)	NOT NULL,
                          `delStatus`	TINYINT(1) UNSIGNED	NOT NULL,
                          `delDate`	DATETIME	NULL,
                          `manner`	FLOAT	NULL,
                          `teamNm`	CHAR(20)	NULL
);
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '회원1_이름',
bornDate = NOW(),
`area` = '대전',
`gender` = '남자',
nickName = '회원1_닉네임',
authLevel = '회원',
`rank` = '아마추어',
delStatus = 1,
delDate = NOW(),
`manner` = 34.1,
teamNm = '최강';

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
                        `memberId`	INT	NOT NULL
);

CREATE TABLE `manner` (
                          `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          `regDate`	DATETIME	NOT NULL,
                          `updateDate`	DATETIME	NOT NULL,
                          `manner`	FLOAT	NOT NULL,
                          `memberId`	INT	NOT NULL
);

CREATE TABLE `message` (
                           `id`	INT	NOT NULL,
                           `regDate`	DATETIME	NOT NULL,
                           `title`	CHAR(100)	NOT NULL,
                           `body`	CHAR(200)	NOT NULL,
                           `memberId`	CHAR(20)	NOT NULL
);

CREATE TABLE `team` (
                        `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        `regDate`	DATETIME	NOT NULL,
                        `updateDate`	DATETIME	NOT NULL,
                        `teamNm`	CHAR(20)	NOT NULL,
                        `teamRank`	CHAR(20)	NOT NULL
);

CREATE TABLE soccer_stadium (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                rsrc_no CHAR(50),
                                rsrc_nm CHAR(255),
                                zip CHAR(20),
                                addr CHAR(255),
                                daddr CHAR(255),
                                lot CHAR(50),
                                lat CHAR(50),
                                inst_url_addr TEXT,
                                img_file_url_addr TEXT
);

CREATE TABLE football_stadium (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  rsrc_no CHAR(50),
                                  rsrc_nm CHAR(255),
                                  zip CHAR(20),
                                  addr CHAR(255),
                                  daddr CHAR(255),
                                  lot CHAR(50),
                                  lat CHAR(50),
                                  inst_url_addr TEXT,
                                  img_file_url_addr TEXT
);

DROP TABLE `message`;
SELECT * FROM `member`;
SELECT * FROM football_stadium ORDER BY id DESC;
SELECT * FROM soccer_stadium ORDER BY id DESC;
