


CREATE DATABASE `pcw_project_DB`;
USE `pcw_project_DB`;
SHOW DATABASES;
`pcw_project`
SELECT * FROM team;

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
                          `rank` CHAR(20) NOT NULL DEFAULT '1',
                          `delStatus` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
                          `delDate` DATETIME NULL,
                          `manner` FLOAT NULL DEFAULT '36.0',
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
DELETE FROM MEMBER
WHERE id = 1;

SELECT * FROM MEMBER;
CREATE TABLE `match` (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         articleId INT NOT NULL
);
CREATE TABLE `scArticle` (
                             `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             `regDate`	DATETIME	NOT NULL,
                             `playDate`	DATETIME	NOT NULL,
                             `title`	CHAR(100)	NOT NULL,
                             `body`	CHAR(200)	NOT NULL,
                             `area`	CHAR(20)	NOT NULL,
                             `stadium`	CHAR(100)	NOT NULL,
                             `avgLevel`	INT	NOT NULL,
                             `boardId`	INT	NOT NULL,
                             ssId INT NOT NULL,
                             matchId INT NOT NULL
);
DROP TABLE scArticle;
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

CREATE TABLE board (
                       id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                       regDate DATETIME NOT NULL,
                       updateDate DATETIME NOT NULL,

                       `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
                       delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
                       delDate DATETIME COMMENT '삭제 날짜'
);

DROP TABLE board;

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

CREATE TABLE message (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         senderId INT NOT NULL,
                         senderNickname VARCHAR(50) NOT NULL,
                         receiverId INT NOT NULL,
                         receiverNickname VARCHAR(50) NOT NULL,
                         content TEXT NOT NULL,
                         sendDate DATETIME DEFAULT NOW()
);

CREATE TABLE `team` (
                        `id`	INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        `regDate`	DATETIME	NOT NULL,
                        `updateDate`	DATETIME	NOT NULL,
                        `teamName`	CHAR(20)	NOT NULL,
                        `teamRank`	INT	NOT NULL,
                        `area` CHAR(20) NOT NULL,
                        teamLeader CHAR(20) NOT NULL
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
CREATE TABLE `match` (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         articleId INT NOT NULL
);

CREATE TABLE match_participant (
                                   id INT AUTO_INCREMENT PRIMARY KEY,
                                   matchId INT NOT NULL,
                                   memberId INT NOT NULL

);

CREATE TABLE teamArticle (
                             id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                             regDate DATETIME NOT NULL,
                             updateDate DATETIME NOT NULL,
                             title CHAR(100) NOT NULL,
                             `body` TEXT NOT NULL,
                             teamLeader CHAR(20) NOT NULL,
                             memberId INT NOT NULL,
                             teamId INT NOT NULL
);

CREATE TABLE mercenaryArticle (
                                  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                                  regDate DATETIME NOT NULL,
                                  updateDate DATETIME NOT NULL,
                                  title CHAR(100) NOT NULL,
                                  `body` TEXT NOT NULL,
                                  memberId INT NOT NULL
);

CREATE TABLE reply (
                       id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                       regDate DATETIME NOT NULL,
                       updateDate DATETIME NOT NULL,
                       memberId INT(10) UNSIGNED NOT NULL,
                       relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
                       relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
                       `body` TEXT NOT NULL
);
SELECT * FROM mercenaryArticle;
SELECT * FROM teamArticle;
SELECT * FROM `member`;
SELECT * FROM `match_participant`;
ALTER TABLE `mercenaryArticle` ADD `area` CHAR(20) AFTER `body`;
ALTER TABLE `member` ADD `teamNm` CHAR(20) AFTER `manner`;
ALTER TABLE `teamArticle` ADD `teamId` INT NOT NULL AFTER `memberId`;
ALTER TABLE MEMBER MODIFY COLUMN teamId INT DEFAULT 0;
DROP TABLE message;
UPDATE soccer_stadium
SET img = '/img/default_sta.jpg'
WHERE img IS NULL;

UPDATE `member`
SET profileImg = '/img/profile.jpg'
WHERE profileImg IS NULL;

UPDATE ftArticle SET matchId = id WHERE matchId IS NULL;
ALTER TABLE ftArticle ADD COLUMN matchId INT;
INSERT INTO `match_participant`
SET matchId = 1,
memberId = 2;

INSERT INTO `mercenaryArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '6월 13일 서울 경기장 용병 뛰실 분~',
`body`= "6월 13일 서울 경기장 용병 뛰실 분",
memberId =1;

INSERT INTO match_participant (matchId, memberId) VALUES (101, 2);
INSERT INTO match_participant (matchId, memberId) VALUES (102, 2);
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;


INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;

INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;
ALTER TABLE teamArticle
DROP COLUMN teamLeader;

SELECT *FROM teamArticle;

INSERT INTO `team`
SET regDate = NOW(),
updateDate = NOW(),
teamName = '지구방위대',
teamRank = 8,
`area` = '대전',
teamLeader = '박철우';

INSERT INTO `team`
SET regDate = NOW(),
updateDate = NOW(),
teamName = 'APKQWD',
teamRank = 8,
`area` = '경기',
teamLeader = 'test11';

INSERT INTO `team`
SET regDate = NOW(),
updateDate = NOW(),
teamName = 'KLPPM',
teamRank = 1,
`area` = '부산',
teamLeader = 'zzzz';

INSERT INTO `team`
SET regDate = NOW(),
updateDate = NOW(),
teamName = '9DKLN',
teamRank = 9,
`area` = '대전',
teamLeader = 'dddd';

INSERT INTO `team`
SET regDate = NOW(),
updateDate = NOW(),
teamName = 'JKLBDV',
teamRank = 4,
`area` = '충남',
teamLeader = 'qwe';

INSERT INTO `team`
SET regDate = NOW(),
updateDate = NOW(),
teamName = 'KLEOIQ',
teamRank = 7,
`area` = '전남',
teamLeader = 'qwe';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = '풋살게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = '축구게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),

`name` = '팀구하기';
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),

`name` = '용병구하기';

SELECT * FROM board;

DROP TABLE match_participant;
SELECT * FROM board;
UPDATE ftArticle SET playDate = '2024-06-01 15:00:00' WHERE id = 1015;
UPDATE ftArticle SET playDate = '2024-06-02 15:00:00' WHERE id = 810;
ALTER TABLE ftArticle ADD COLUMN matchId INT;
SELECT * FROM match_participant;
SELECT * FROM reply;
SELECT * FROM ftArticle;
SELECT * FROM scArticle;
DROP TABLE scArticle;
`area`
SELECT * FROM team;
DROP TABLE `teamArticle`;
SELECT id, title, BODY FROM teamArticle WHERE id = 25;
UPDATE teamArticle
SET BODY = '초기화된 내용입니다. 다시 수정해 보세요!'
WHERE id = 25;
DROP TABLE `teamArticle`;
SELECT * FROM board;
UPDATE `member`
SET teamId = '2'
WHERE id = 2;

UPDATE ftArticle
SET fsId = id;

UPDATE `member` SET manner = 36.5;
SELECT * FROM soccer_stadium;
ALTER TABLE `ftArticle`
    MODIFY COLUMN avgLevel INT;
ALTER TABLE `teamArticle` ADD COLUMN `area` CHAR(20) NOT NULL AFTER `body`;
ALTER TABLE `member`
    MODIFY COLUMN `rank` INT NOT NULL;

DESC teamArticle;
SELECT * FROM football_stadium;
SELECT * FROM soccer_stadium;
DROP TABLE message;
SELECT * FROM message;
SELECT * FROM `member`;
SELECT * FROM team;
SELECT * FROM `board`
SELECT * FROM football_stadium ORDER BY id DESC;
SELECT * FROM `member`;
SELECT * FROM `scArticle`;
SELECT * FROM soccer_stadium ORDER BY id DESC;

SELECT * FROM teamArticle;
DELETE FROM match_participant
WHERE matchId = 0;
ALTER TABLE `member` DROP COLUMN teamNm;

SELECT fa.*, fs.img
FROM ftArticle fa
         INNER JOIN match_participant mp ON fa.id = mp.matchId
         INNER JOIN football_stadium fs ON fa.id=fs.id
WHERE mp.memberId = 2
  AND fa.playDate < NOW()
ORDER BY fa.playDate DESC
    LIMIT 3;

INSERT INTO match_participant (matchId, memberId)
VALUES (1015, 2);


SELECT *
FROM `member`
WHERE nickName = 'test11';
UPDATE scArticle SET matchId = id;

INSERT INTO ftArticle (regDate, playDate, title, `BODY`, `AREA`, stadium, avgLevel, boardId, fsId, matchId)
SELECT
    NOW() AS regDate,
    STR_TO_DATE(
            CONCAT('2025-', FLOOR(6 + (RAND() * 7)), '-', FLOOR(1 + (RAND() * 28)), ' ', FLOOR(10 + (RAND() * 13)), ':00:00'),
            '%Y-%m-%d %H:%i:%s'
    ) AS playDate,
    f.stadiumName AS title,
    CONCAT(f.stadiumName, '에서 풋살 경기가 열립니다.') AS BODY,
    f.area AS AREA,
    f.stadiumName AS stadium,
    FLOOR(1 + (RAND() * 12)) AS avgLevel,
    1 AS boardId,
    f.id AS fsId,
    2000 + FLOOR(RAND() * 100000) AS matchId
FROM football_stadium f
ORDER BY RAND()
    LIMIT 3000;


           