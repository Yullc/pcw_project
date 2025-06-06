CREATE DATABASE `pcw_project_DB`;
USE `pcw_project_DB`;
SHOW DATABASES;
`pcw_project`


DROP TABLE `member`;
CREATE TABLE `member` (
                          `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          `regDate` DATETIME NOT NULL,
                          `updateDate` DATETIME NOT NULL,
                          `loginId` CHAR(30) NOT NULL,
                          `loginPw` CHAR(100) NOT NULL,
                          `loginPwCheck` CHAR(100) NOT NULL,
                          email CHAR(100) NOT NULL,
                          `poneNm` INT NOT NULL,
                          `bornDate` DATETIME NOT NULL,
                          `area` CHAR(20) NOT NULL,
                          `gender` CHAR(20) NOT NULL,
                          `name` CHAR(20) NOT NULL,
                          `nickName` CHAR(20) NOT NULL,
                          `authLevel` CHAR(20) NOT NULL DEFAULT 'normal',
                          `rank` CHAR(20) NOT NULL DEFAULT 'rookie',
                          `delStatus` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
                          `delDate` DATETIME NULL,
                          `manner` FLOAT NULL,
                          `teamNm` CHAR(20) NULL
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
SELECT * FROM MEMBER;
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
                             `boardId`	INT	NOT NULL,
                             fsId INT NOT NULL
);

CREATE TABLE `board` (
                         `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         `regDate` DATETIME NOT NULL,
                         `updateDate` DATETIME NOT NULL,
                         `name` CHAR(20) NOT NULL,
                         `delStatus` TINYINT(1) UNSIGNED NOT NULL,
                         `delDate` DATETIME
);
INSERT INTO `board` (regDate, updateDate, NAME, delStatus)
VALUES
    (NOW(), NOW(), '풋살 게시판', 0),
    (NOW(), NOW(), '축구 게시판', 0),
    (NOW(), NOW(), '팀 구하기 게시판', 0),
    (NOW(), NOW(), '용병 구하기 게시판', 0);

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
                                `area` VARCHAR(50),
                                stadiumName VARCHAR(100),
                                address VARCHAR(255),
                                img VARCHAR(1000)
);


CREATE TABLE football_stadium (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  `area` VARCHAR(50),
                                  stadiumName VARCHAR(100),
                                  address VARCHAR(255),
                                  img VARCHAR(1000)
);

INSERT INTO ftArticle (regDate, playDate, title, BODY, AREA, stadium, avgLevel, boardId, fsId)
SELECT
    NOW() AS regDate,
    NOW() + INTERVAL 1 DAY AS playDate,
    f.stadiumName AS title,
    CONCAT(f.stadiumName, '에서 풋살 경기가 열립니다.') AS BODY,
    f.area,
    f.stadiumName AS stadium,
    '아마추어' AS avgLevel,
    1 AS boardId,
    f.id AS fsId
FROM football_stadium f;



CREATE TABLE reactionPoint (
                               id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                               regDate DATETIME NOT NULL,
                               updateDate DATETIME NOT NULL,
                               memberId INT(10) UNSIGNED NOT NULL,
                               relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
                               relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
                               `point` INT(10) NOT NULL
);

SELECT DISTINCT boardId FROM FtArticle;

UPDATE MEMBER SET profileImg = '/img/pcw.jpeg' WHERE id = 1;



UPDATE ftArticle
SET playDate = (
    -- 무작위 날짜 생성
    DATE_ADD(
            '2025-06-01',
            INTERVAL FLOOR(RAND() * DATEDIFF('2025-12-25', '2025-06-01') + 1) DAY
  )
        +
        -- 무작위 시간 (10시 ~ 22시)
        INTERVAL (FLOOR(RAND() * 13) + 10) HOUR
    );
ALTER TABLE MEMBER CHANGE poneNm phoneNumber VARCHAR(20);

DROP TABLE soccer_stadium;
DROP TABLE ftArticle;
SELECT * FROM board;
SELECT * FROM ftArticle;
ALTER TABLE `member` ADD COLUMN intro VARCHAR(1000) AFTER profileImg;
SELECT * FROM football_stadium;
SELECT * FROM `member`;
SELECT * FROM football_stadium ORDER BY id DESC;
SELECT * FROM soccer_stadium ORDER BY id DESC;