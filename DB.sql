


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
                          `teamNm` CHAR(20) NULL,
                          teamId INT NOT NULL DEFAULT '0',
                          profileImg VARCHAR(1000),
                          intro VARCHAR(1000)
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
                        teamLeader CHAR(20) NOT NULL,
                        intro	TEXT
);
DROP TABLE team;
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
                                   memberId INT NOT NULL,
                                   `position` CHAR(20),
                                   `type` 	CHAR(20) NOT NULL
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

CREATE TABLE reactionPoint (
                               id INT PRIMARY KEY AUTO_INCREMENT,
                               regDate DATETIME NOT NULL,
                               updateDate DATETIME NOT NULL,
                               fromMemberId INT NOT NULL,
                               toMemberId INT NOT NULL,
                               UNIQUE KEY uniq_like (fromMemberId, toMemberId)
);

CREATE TABLE teamChatMessage (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 teamId INT NOT NULL,
                                 memberId INT NOT NULL,
                                 nickName VARCHAR(20) NOT NULL,
                                 message TEXT NOT NULL,
                                 sendTime DATETIME DEFAULT NOW()
);

CREATE TABLE trophy (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        `rank` INT NOT NULL UNIQUE,   -- 1~12: 루키1~프로3
                        svg TEXT                    -- SVG 코드 저장
);

CREATE TABLE teamAlert (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           teamId INT NOT NULL,
                           memberId INT NOT NULL,
                           content TEXT NOT NULL,
                           regDate DATETIME DEFAULT NOW()
);

CREATE TABLE match_evaluation (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  matchId INT NOT NULL,
                                  memberId INT NOT NULL,       -- 평가받는 사람
                                  evaluatorId INT NOT NULL,    -- 평가하는 사람
                                  hasEvaluated BOOLEAN DEFAULT FALSE,
                                  UNIQUE (matchId, memberId, evaluatorId)
);

SELECT * FROM teamAlert;
DROP TABLE teamAlert;

INSERT INTO trophy (`rank`, svg) VALUES
                                     (1, '<svg>루키1</svg>'),
                                     (2, '<svg>루키2</svg>'),
                                     (3, '<svg>루키3</svg>'),
                                     (4, '<svg>아마추어1</svg>'),
                                     (5, '<svg>아마추어2</svg>'),
                                     (6, '<svg>아마추어3</svg>'),
                                     (7, '<svg>세미프로1</svg>'),
                                     (8, '<svg>세미프로2</svg>'),
                                     (9, '<svg>세미프로3</svg>'),
                                     (10, '<svg>프로1</svg>'),
                                     (11, '<svg>프로2</svg>'),
                                     (12, '<svg>프로3</svg>');
INSERT INTO trophy (RANK, svg) VALUES (
                                          12,
                                          '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path fill="#bb56c2" d="M400 0L176 0c-26.5 0-48.1 21.8-47.1 48.2c.2 5.3 .4 10.6 .7 15.8L24 64C10.7 64 0 74.7 0 88c0 92.6 33.5 157 78.5 200.7c44.3 43.1 98.3 64.8 138.1 75.8c23.4 6.5 39.4 26 39.4 45.6c0 20.9-17 37.9-37.9 37.9L192 448c-17.7 0-32 14.3-32 32s14.3 32 32 32l192 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-26.1 0C337 448 320 431 320 410.1c0-19.6 15.9-39.2 39.4-45.6c39.9-11 93.9-32.7 138.2-75.8C542.5 245 576 180.6 576 88c0-13.3-10.7-24-24-24L446.4 64c.3-5.2 .5-10.4 .7-15.8C448.1 21.8 426.5 0 400 0zM48.9 112l84.4 0c9.1 90.1 29.2 150.3 51.9 190.6c-24.9-11-50.8-26.5-73.2-48.3c-32-31.1-58-76-63-142.3zM464.1 254.3c-22.4 21.8-48.3 37.3-73.2 48.3c22.7-40.3 42.8-100.5 51.9-190.6l84.4 0c-5.1 66.3-31.1 111.2-63 142.3z"/></svg>'
                                      );
INSERT INTO trophy (RANK, svg) VALUES (
                                          3,
                                          '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path fill="#814d22" d="M400 0L176 0c-26.5 0-48.1 21.8-47.1 48.2c.2 5.3 .4 10.6 .7 15.8L24 64C10.7 64 0 74.7 0 88c0 92.6 33.5 157 78.5 200.7c44.3 43.1 98.3 64.8 138.1 75.8c23.4 6.5 39.4 26 39.4 45.6c0 20.9-17 37.9-37.9 37.9L192 448c-17.7 0-32 14.3-32 32s14.3 32 32 32l192 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-26.1 0C337 448 320 431 320 410.1c0-19.6 15.9-39.2 39.4-45.6c39.9-11 93.9-32.7 138.2-75.8C542.5 245 576 180.6 576 88c0-13.3-10.7-24-24-24L446.4 64c.3-5.2 .5-10.4 .7-15.8C448.1 21.8 426.5 0 400 0zM48.9 112l84.4 0c9.1 90.1 29.2 150.3 51.9 190.6c-24.9-11-50.8-26.5-73.2-48.3c-32-31.1-58-76-63-142.3zM464.1 254.3c-22.4 21.8-48.3 37.3-73.2 48.3c22.7-40.3 42.8-100.5 51.9-190.6l84.4 0c-5.1 66.3-31.1 111.2-63 142.3z"/></svg>'
                                      );
INSERT INTO trophy (RANK, svg) VALUES (
                                          6,
                                          '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path fill="#323d95" d="M400 0L176 0c-26.5 0-48.1 21.8-47.1 48.2c.2 5.3 .4 10.6 .7 15.8L24 64C10.7 64 0 74.7 0 88c0 92.6 33.5 157 78.5 200.7c44.3 43.1 98.3 64.8 138.1 75.8c23.4 6.5 39.4 26 39.4 45.6c0 20.9-17 37.9-37.9 37.9L192 448c-17.7 0-32 14.3-32 32s14.3 32 32 32l192 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-26.1 0C337 448 320 431 320 410.1c0-19.6 15.9-39.2 39.4-45.6c39.9-11 93.9-32.7 138.2-75.8C542.5 245 576 180.6 576 88c0-13.3-10.7-24-24-24L446.4 64c.3-5.2 .5-10.4 .7-15.8C448.1 21.8 426.5 0 400 0zM48.9 112l84.4 0c9.1 90.1 29.2 150.3 51.9 190.6c-24.9-11-50.8-26.5-73.2-48.3c-32-31.1-58-76-63-142.3zM464.1 254.3c-22.4 21.8-48.3 37.3-73.2 48.3c22.7-40.3 42.8-100.5 51.9-190.6l84.4 0c-5.1 66.3-31.1 111.2-63 142.3z"/></svg>'

                                      );
INSERT INTO trophy (RANK, svg) VALUES (
                                          9,
                                          '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path fill="#c6ac4e" d="M400 0L176 0c-26.5 0-48.1 21.8-47.1 48.2c.2 5.3 .4 10.6 .7 15.8L24 64C10.7 64 0 74.7 0 88c0 92.6 33.5 157 78.5 200.7c44.3 43.1 98.3 64.8 138.1 75.8c23.4 6.5 39.4 26 39.4 45.6c0 20.9-17 37.9-37.9 37.9L192 448c-17.7 0-32 14.3-32 32s14.3 32 32 32l192 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-26.1 0C337 448 320 431 320 410.1c0-19.6 15.9-39.2 39.4-45.6c39.9-11 93.9-32.7 138.2-75.8C542.5 245 576 180.6 576 88c0-13.3-10.7-24-24-24L446.4 64c.3-5.2 .5-10.4 .7-15.8C448.1 21.8 426.5 0 400 0zM48.9 112l84.4 0c9.1 90.1 29.2 150.3 51.9 190.6c-24.9-11-50.8-26.5-73.2-48.3c-32-31.1-58-76-63-142.3zM464.1 254.3c-22.4 21.8-48.3 37.3-73.2 48.3c22.7-40.3 42.8-100.5 51.9-190.6l84.4 0c-5.1 66.3-31.1 111.2-63 142.3z"/></svg>'


                                      );
DROP TABLE teamChatMessage;
ALTER TABLE reactionPoint
    ADD COLUMN memberId INT NOT NULL;

ALTER TABLE `member`
    ADD COLUMN `goodReactionPoint` INT DEFAULT 0;

ALTER TABLE reactionPoint ADD toMemberId INT ;
DROP TABLE reactionPoint;
ALTER TABLE reactionPoint DROP COLUMN relId;
###################################################################################


SELECT * FROM ftArticle;
SELECT * FROM scArticle;
SELECT * FROM teamChatMessage;
SELECT * FROM mercenaryArticle;
SELECT * FROM teamArticle;
SELECT * FROM `member`;
SELECT * FROM `match_participant`;
SELECT * FROM `teamChatMessage`;
SELECT * FROM `team`
SELECT * FROM `teamAlert`;
SELECT * FROM `reply`;
SELECT * FROM `board`;
SELECT * FROM `mercenaryArticle`;
SELECT * FROM `message`
SELECT * FROM `trophy`;
SELECT * FROM match_evaluation;


###################################################################################
ALTER TABLE match_participant
    ADD COLUMN evaluatorId  INT;

SELECT * FROM message;
ALTER TABLE `mercenaryArticle` ADD `area` CHAR(20) AFTER `body`;
ALTER TABLE `match_participant` ADD `regDate` DATETIME;
ALTER TABLE match_participant MODIFY COLUMN memberId INT NULL;

ALTER TABLE `teamArticle` ADD `teamId` INT NOT NULL AFTER `memberId`;
ALTER TABLE MEMBER MODIFY COLUMN teamId INT DEFAULT 0;
DROP TABLE message;
UPDATE soccer_stadium
SET img = '/img/default_sta.jpg'
WHERE img IS NULL;
SELECT * FROM team;
UPDATE `member`
SET teamNm = '토트넘'
WHERE id =1;

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
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 2);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 3);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 4);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 5);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 6);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 7);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 8);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 9);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 10);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 14);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 12);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 13);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 15);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 16);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 17);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 18);
INSERT INTO match_participant (matchId, memberId) VALUES (3060, 19);
INSERT INTO `teamArticle`
SET regDate = NOW(),
updateDate = NOW(),
title = '최강팀 멤버 구해요 !!',
`body`= "최강팀 멤버 구합니다 !",
teamLeader = 'qwe',
memberId =1,
teamId =1;

SELECT
    m.teamNm ,
    t.teamLeader ,
    ROUND(AVG(m.rank)) AS avgRank
FROM
    match_participant mp
        JOIN
    MEMBER m ON mp.memberId = m.id
        JOIN
    team t ON m.teamNm = t.teamName
WHERE
    mp.matchId = 4083
  AND m.teamNm IS NOT NULL
GROUP BY
    m.teamNm, t.teamLeader;

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

`name` = '팀 목록';


ALTER TABLE match_participant
    ADD COLUMN teamId INT DEFAULT NULL;


SELECT * FROM board;

DROP TABLE match_participant;
SELECT * FROM board;

UPDATE ftArticle SET playDate = '2025-06-23 16:00:00' WHERE id = 60;
UPDATE ftArticle SET playDate = '2025-06-23 17:00:00' WHERE id = 130;
UPDATE ftArticle SET playDate = '2025-06-23 18:20:00' WHERE id = 501;

INSERT INTO match_participant (matchId, memberId, `position`, `type`)
VALUES

    (501, 2,'','풋살');

SELECT fa.*, fs.img
FROM ftArticle fa
         INNER JOIN match_participant mp ON fa.id = mp.matchId
         INNER JOIN football_stadium fs ON fa.id = fs.id
WHERE mp.memberId = 1
  AND mp.type = '풋살'
  AND fa.playDate < NOW()
ORDER BY fa.playDate DESC
    LIMIT 3;


UPDATE ftArticle
SET `code` = '개인'
WHERE `code` IS NULL OR `code` = '';

SELECT * FROM MEMBER;

ALTER TABLE ftArticle ADD COLUMN `code` CHAR(20) NOT NULL AFTER matchId;
ALTER TABLE scArticle ADD COLUMN `matchId` INT NOT NULL AFTER ssId;
SELECT * FROM match_participant;
SELECT * FROM mercenaryArticle;
SELECT * FROM reply;
SELECT * FROM ftArticle;
SELECT * FROM scArticle;
DROP TABLE scArticle;
`area`
SELECT * FROM team;
DROP TABLE `teamArticle`;
SELECT id, title, BODY FROM teamArticle WHERE id = 25;

ALTER TABLE MEMBER
    MODIFY profileImg VARCHAR(1000) DEFAULT '/img/profile.jpg';


UPDATE `member`
SET profileImg = '/img/profile.jpg'
WHERE profileImg = '/img/progile.jpg';

DROP TABLE `teamArticle`;
SELECT * FROM board;

UPDATE `member`
SET phoneNumber = 0103331541
WHERE id = 9;

UPDATE ftArticle
SET `code` = '팀'
WHERE `code` IS NULL;

SELECT * FROM board;
UPDATE `member` SET manner = 36.5;
SELECT * FROM soccer_stadium;
ALTER TABLE `ftArticle`
    MODIFY COLUMN avgLevel INT;
ALTER TABLE `teamArticle` ADD COLUMN `area` CHAR(20) NOT NULL AFTER `body`;
ALTER TABLE `match_participant` ADD COLUMN `positon` CHAR(20) NOT NULL AFTER `memberId`;
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
SELECT * FROM `ftArticle`;
SELECT * FROM soccer_stadium ORDER BY id DESC;
SELECT * FROM match_participant;
SELECT * FROM teamArticle;
SELECT * FROM reactionPoint;
DELETE FROM match_participant
WHERE matchId = 0;
UPDATE football_stadium
SET address = '부산 기장군 장안읍 고무로 270 풋살장'
WHERE address = '부산 기장군 장안읍';

ALTER TABLE team ADD UNIQUE (teamName);
ALTER TABLE team ADD UNIQUE (teamLeader);
ALTER TABLE message ADD is_handled BOOLEAN DEFAULT FALSE;

ALTER TABLE `member` DROP COLUMN teamNm;
ALTER TABLE match_participant DROP COLUMN positon;

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
ALTER TABLE message DROP COLUMN is_Handled;

SELECT * FROM team;

SELECT *
FROM `member`

WHERE nickName = 'test11';

UPDATE `member` SET RANK = 10 WHERE id = 7;

SELECT m.*
FROM team t
         JOIN MEMBER m ON t.teamName = m.teamNm
WHERE t.id = 3;

SELECT * FROM MEMBER WHERE teamNm = '토트넘';

INSERT INTO ftArticle (regDate, playDate, title, `BODY`, `AREA`, stadium, avgLevel, boardId, fsId, matchId)
SELECT
    NOW() AS regDate,
    STR_TO_DATE(
            CONCAT('2025-', FLOOR(6 + (RAND() * 7)), '-', FLOOR(1 + (RAND() * 28)), ' ', FLOOR(10 + (RAND() * 13)), ':00:00'),
            '%Y-%m-%d %H:%i:%s'
    ) AS playDate,
    f.stadiumName AS title,
    CONCAT(f.stadiumName, '에서 축구 경기가 열립니다.') AS BODY,
    f.area AS AREA,
    f.stadiumName AS stadium,
    FLOOR(1 + (RAND() * 12)) AS avgLevel,
    1 AS boardId,
    f.id AS fsId,
    2000 + FLOOR(RAND() * 100000) AS matchId
FROM football_stadium f
ORDER BY RAND()
    LIMIT 5000;


DELETE FROM team
WHERE id = '7';

SELECT * FROM match_participant;

DROP TABLE match_participant;

ALTER TABLE message
    ADD COLUMN teamId INT ;



UPDATE match_participant
SET TYPE = '축구'
WHERE id = 17;
UPDATE match_participant
SET TYPE = '축구'
WHERE id = 19;
SELECT * FROM scArticle

SELECT sa.*, ss.img
FROM scArticle sa
         INNER JOIN match_participant mp ON sa.id = mp.matchId
         INNER JOIN soccer_stadium ss ON sa.id = ss.id
WHERE mp.memberId = 2
  AND mp.type = '축구'
  AND sa.playDate < NOW()
ORDER BY sa.playDate DESC
    LIMIT 3;

SELECT m.phoneNumber, matches.stadium
FROM match_participant mp
         INNER JOIN MEMBER m ON mp.memberId = m.id
         INNER JOIN (
    SELECT id, playDate, stadium
    FROM ftArticle
    WHERE playDate BETWEEN DATE_ADD(NOW(), INTERVAL 59 MINUTE)
              AND DATE_ADD(NOW(), INTERVAL 61 MINUTE)
    UNION
    SELECT id, playDate, stadium
    FROM scArticle
    WHERE playDate BETWEEN DATE_ADD(NOW(), INTERVAL 59 MINUTE)
              AND DATE_ADD(NOW(), INTERVAL 61 MINUTE)
) AS matches ON mp.matchId = matches.id
WHERE mp.type IN ('풋살', '축구');

ALTER TABLE reactionPoint
    ADD COLUMN POINT INT DEFAULT 1;

ALTER TABLE reactionPoint
DROP COLUMN `member`
UPDATE `team`
SET intro = '아스날에 오신걸 환영해요.'
WHERE id = 12;

UPDATE MEMBER
SET phoneNumber = '01033894452';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
`l` = '축구게시판';

SELECT m.*
FROM team t
         JOIN MEMBER m ON t.teamName = m.teamNm
WHERE t.id = 1;
SELECT * FROM `member`;

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test9',
loginPw = 'test9',
loginPwCheck = 'test9',
email = 'test9',
phoneNumber = '1111',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test9',
nickName = 'test9',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test10',
loginPw = 'test10',
loginPwCheck = 'test10',
email = 'test10',
phoneNumber = '1111',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test10',
nickName = 'test10',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test11',
loginPw = 'test11',
loginPwCheck = 'test11',
email = 'test11',
phoneNumber = '2222',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test11',
nickName = 'test11',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';


INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test12',
loginPw = 'test12',
loginPwCheck = 'test12',
email = 'test12',
phoneNumber = '2222',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test12',
nickName = 'test12',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test13',
loginPw = 'test13',
loginPwCheck = 'test13',
email = 'test13',
phoneNumber = '2222',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test13',
nickName = 'test13',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test14',
loginPw = 'test14',
loginPwCheck = 'test14',
email = 'test14',
phoneNumber = '2222',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test14',
nickName = 'test14',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test15',
loginPw = 'test15',
loginPwCheck = 'test15',
email = 'test15',
phoneNumber = '2222',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test15',
nickName = 'test15',
authLevel = 'noraml',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test16',
loginPw = 'test16',
loginPwCheck = 'test16',
email = 'test16',
phoneNumber = '2222',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test16',
nickName = 'test16',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test17',
loginPw = 'test17',
loginPwCheck = 'test17',
email = 'test17',
phoneNumber = '2222',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test17',
nickName = 'test17',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test18',
loginPw = 'test18',
loginPwCheck = 'test18',
email = 'test18',
phoneNumber = '2222',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test18',
nickName = 'test18',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test19',
loginPw = 'test19',
loginPwCheck = 'test19',
email = 'test19',
phoneNumber = '3333',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test19',
nickName = 'test19',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test20',
loginPw = 'test20',
loginPwCheck = 'test20',
email = 'test20',
phoneNumber = '3333',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test20',
nickName = 'test20',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test21',
loginPw = 'test21',
loginPwCheck = 'test21',
email = 'test21',
phoneNumber = '3333',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test21',
nickName = 'test21',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test22',
loginPw = 'test22',
loginPwCheck = 'test22',
email = 'test22',
phoneNumber = '3333',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test22',
nickName = 'test22',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test23',
loginPw = 'test23',
loginPwCheck = 'test23',
email = 'test23',
phoneNumber = '3333',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test23',
nickName = 'test23',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test24',
loginPw = 'test24',
loginPwCheck = 'test24',
email = 'test24',
phoneNumber = '3333',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test24',
nickName = 'test24',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test25',
loginPw = 'test25',
loginPwCheck = 'test25',
email = 'test25',
phoneNumber = '1111',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test25',
nickName = 'test25',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test26',
loginPw = 'test26',
loginPwCheck = 'test26',
email = 'test26',
phoneNumber = '1111',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test26',
nickName = 'test26',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';.

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test27',
loginPw = 'test27',
loginPwCheck = 'test27',
email = 'test27',
phoneNumber = '1111',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test27',
nickName = 'test27',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test28',
loginPw = 'test28',
loginPwCheck = 'test28',
email = 'test28',
phoneNumber = 'test28',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test28',
nickName = 'test28',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test29',
loginPw = 'test29',
loginPwCheck = 'test29',
email = 'test29',
phoneNumber = 'test29',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test29',
nickName = 'test29',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test30',
loginPw = 'test30',
loginPwCheck = 'test30',
email = 'test30',
phoneNumber = 'test30',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test30',
nickName = 'test30',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test31',
loginPw = 'test31',
loginPwCheck = 'test31',
email = 'test31',
phoneNumber = 'test31',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test31',
nickName = 'test31',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test32',
loginPw = 'test32',
loginPwCheck = 'test32',
email = 'test32',
phoneNumber = 'test32',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test32',
nickName = 'test32',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test33',
loginPw = 'test33',
loginPwCheck = 'test33',
email = 'test33',
phoneNumber = 'test33',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test33',
nickName = 'test33',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test34',
loginPw = 'test34',
loginPwCheck = 'test34',
email = 'test34',
phoneNumber = 'test34',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test34',
nickName = 'test34',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test35',
loginPw = 'test35',
loginPwCheck = 'test35',
email = 'test35',
phoneNumber = 'test35',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test35',
nickName = 'test35',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test36',
loginPw = 'test36',
loginPwCheck = 'test36',
email = 'test36',
phoneNumber = 'test36',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test36',
nickName = 'test36',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test37',
loginPw = 'test37',
loginPwCheck = 'test37',
email = 'test37',
phoneNumber = 'test37',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test37',
nickName = 'test37',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test38',
loginPw = 'test38',
loginPwCheck = 'test38',
email = 'test38',
phoneNumber = 'test38',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test38',
nickName = 'test38',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test39',
loginPw = 'test39',
loginPwCheck = 'test39',
email = 'test39',
phoneNumber = 'test39',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test39',
nickName = 'test39',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test40',
loginPw = 'test40',
loginPwCheck = 'test40',
email = 'test40',
phoneNumber = 'test40',
bornDate = '2025-06-11 09:11:11',
`area` = '서울',
gender = '남자',
`name` = 'test40',
nickName = 'test40',
authLevel = 'normal',
`rank` = '4',
delStatus = '1',
manner = '36',
teamNm = '아스날',
teamId = '12',
`profileImg` = '/img/profile.jpg',
intro = '안녕하세요';
