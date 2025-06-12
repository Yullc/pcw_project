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

CREATE TABLE reply (
                       id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                       regDate DATETIME NOT NULL,
                       updateDate DATETIME NOT NULL,
                       memberId INT(10) UNSIGNED NOT NULL,
                       relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
                       relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
                       `body` TEXT NOT NULL
);
SELECT * FROM teamArticle;
SELECT * FROM `member`;
ALTER TABLE ftArticle ADD matchId INT AFTER fsId;
UPDATE ftArticle SET matchId = id WHERE matchId IS NULL;

INSERT INTO `match_participant`
SET matchId = 1,
memberId = 2;

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
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;


SELECT *FROM team;

INSERT INTO `team`
SET regDate = NOW(),
updateDate = NOW(),
teamName = '최강',
teamRank = 4,
`area` = '서울',
teamLeader = 'qwe';

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


DROP TABLE match_participant;
UPDATE ftArticle SET playDate = '2024-06-01 15:00:00' WHERE id = 1015;
UPDATE ftArticle SET playDate = '2024-06-02 15:00:00' WHERE id = 810;

SELECT * FROM match_participant;
SELECT * FROM reply;
SELECT * FROM ftArticle;
SELECT * FROM teamArticle;
SELECT * FROM team;
DROP TABLE `teamArticle`;

DROP TABLE `teamArticle`;
SELECT * FROM board;
UPDATE `member`
SET teamId = '2'
WHERE id = 2;

UPDATE ftArticle SET avgLevel = 5 WHERE avgLevel = '아마추어';

ALTER TABLE `ftArticle`
    MODIFY COLUMN avgLevel INT;
ALTER TABLE `member` ADD COLUMN `teamId` INT NOT NULL AFTER `manner`;
SELECT * FROM football_stadium;
DROP TABLE message;
SELECT * FROM message;
SELECT * FROM `member`;
SELECT * FROM team;
SELECT * FROM football_stadium ORDER BY id DESC;

SELECT * FROM soccer_stadium ORDER BY id DESC;

DELETE FROM match_participant
WHERE matchId = 0;
ALTER TABLE `member` DROP COLUMN teamNm;

SELECT fa.*, fs.img
FROM ftArticle fa
         INNER JOIN match_participant mp ON fa.id = mp.matchId
         INNER JOIN football_stadium fs ON fa.id=fs.id
WHERE mp.memberId = 1
  AND fa.playDate < NOW()
ORDER BY fa.playDate DESC
    LIMIT 3;


SELECT *
FROM `member`
WHERE nickName = 'test11';

           