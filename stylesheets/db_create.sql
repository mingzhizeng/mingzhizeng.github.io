CREATE DATABASE IF NOT EXISTS spark DEFAULT CHARACTER SET utf8mb4;

use spark;

CREATE TABLE IF NOT EXISTS `users`(
  `innerUserId` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userId` varchar(50)  CHARACTER SET latin1 NOT NULL,
  `sexId` varchar(10)  CHARACTER SET latin1,
  `nickname` varchar(30),
  `age` INT,
  `portraitUrl` varchar(255),
  `userInfoJson` TEXT,
  `tokenId` varchar(255),
  `ts_register` BIGINT(20) NOT NULL DEFAULT 0,
  UNIQUE INDEX(`userId`)
)
ENGINE=INNODB
DEFAULT CHARACTER SET=utf8mb4
;

-- set SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';
-- INSERT into users (innerUserId, userId) values(0, '');
-- INSERT into users (innerUserId, userId) values(9223372036854775807, 'root');

CREATE TABLE IF NOT EXISTS `circles`(
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(190) NOT NULL,
  `description` TEXT ,
  `iconUrl` varchar(255)  CHARACTER SET latin1,
  `memberCount` INT NOT NULL DEFAULT 0,
  `masterId` BIGINT(20) ,
  `topicCount` INT NOT NULL ,
  `courseId` varchar(50) CHARACTER SET latin1,
  `categories` TEXT ,
  `tags` TEXT ,
  `online` BOOL NOT NULL DEFAULT TRUE,
  `deleted` BOOL NOT NULL DEFAULT FALSE,
  `ts_create` BIGINT(20),
  `ts_online` BIGINT(20),
  `ts_delete` BIGINT(20),
  INDEX(`name`),
  UNIQUE INDEX (`courseId`, `name`)

)
ENGINE=INNODB
DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if NOT EXISTS `topics`(
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` TEXT,
  `picJsonStr` TEXT,
  `owner` BIGINT(20) NOT NULL,
  `publishTime` BIGINT(20) NOT NULL,
  `lastModifyTime` BIGINT(20) NOT NULL DEFAULT 0,
  `lastReplyTime` BIGINT(20) NOT NULL DEFAULT 0,
  `circleId` BIGINT(20) NOT NULL,
  `isTop` BOOL NOT NULL DEFAULT FALSE,
  `likeCount` INT NOT NULL DEFAULT 0,
  `commentCount` INT NOT NULL DEFAULT 0,
  `deleted` INT NOT NULL DEFAULT 0,
  `blocked` BOOL DEFAULT FALSE,
  `audit` TINYINT DEFAULT 0,
  `isHighLight` BOOL DEFAULT FALSE,
  `lessonId` varchar(50) CHARACTER SET latin1 DEFAULT "",
  `isAsk` BOOL DEFAULT FALSE,
  `totalReplyCount` INT NOT NULL DEFAULT 0,
  `visitCount` BIGINT(20) NOT NULL DEFAULT 0,
  `recommend` BOOL DEFAULT FALSE,
  `activityId` BIGINT(20) NOT NULL DEFAULT 0,
  INDEX(`circleId`, `id`),
  INDEX(`circleId`, `lastReplyTime`),
  INDEX(`circleId`, `publishTime`),
  INDEX(`circleId`,`isAsk`, `id`),
  INDEX(`circleId`,`isAsk`, `lastReplyTime`),
  INDEX(`circleId`,`isAsk`, `publishTime`),
  INDEX(`circleId`, `lessonId`,`isAsk`,`id`),
  INDEX(`circleId`, `lessonId`, `isAsk`, `publishTime`),
  INDEX(`circleId`, `lessonId`, `isAsk`, `lastReplyTime`),
  INDEX(`publishTime`)

)
ENGINE=INNODB
DEFAULT CHARACTER SET=utf8mb4
  COLLATE utf8mb4_general_ci  
;

CREATE TABLE if NOT EXISTS `comments`(
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `content` TEXT,
  `owner` BIGINT(20) NOT NULL,
  `publishTime` BIGINT(20) NOT NULL,
  `lastReplyTime` BIGINT(20) NOT NULL,
  `topicId` BIGINT(20) NOT NULL,
  `blocked` BOOL DEFAULT FALSE,
  `replyCount` INT DEFAULT 0,
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX(`topicId`,`lastReplyTime`),
  INDEX(`owner`)

)
ENGINE=INNODB
DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if NOT EXISTS `replies`(
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `content` TEXT,
  `owner` BIGINT(20) NOT NULL,
  `publishTime` BIGINT(20) NOT NULL,
  `commentId` BIGINT(20) NOT NULL,
  `replyTo` BIGINT(20) DEFAULT -1,
  `replyToUser` BIGINT(20) NOT NULL,
  `blocked` BOOL DEFAULT FALSE,
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX(`owner`),
  INDEX(`commentId`,`publishTime`)

)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;


CREATE TABLE if not EXISTS `topic_picture`(
  `pid` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `longTypeId` BIGINT(20) ,
  `name` varchar(50),
  `uploadTime` BIGINT(20) ,
  `size` INT ,
  `width` INT ,
  `height` INT,
  `relatedKey` BIGINT(20),
  `flag` INT,
  `uploader` BIGINT(20),
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX (`relatedKey`),
  INDEX (`longTypeId`)
)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;


CREATE TABLE if not EXISTS `comment_picture`(
  `pid` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `longTypeId` BIGINT(20) ,
  `name` varchar(50),
  `uploadTime` BIGINT(20) ,
  `size` INT ,
  `width` INT ,
  `height` INT,
  `relatedKey` BIGINT(20),
  `flag` INT,
  `uploader` BIGINT(20),
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX (`relatedKey`),
  INDEX (`longTypeId`)

)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if not EXISTS `circle_picture`(
  `pid` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `longTypeId` BIGINT(20) ,
  `name` varchar(50),
  `uploadTime` BIGINT(20) ,
  `size` INT ,
  `width` INT ,
  `height` INT,
  `relatedKey` BIGINT(20),
  `flag` INT,
  `uploader` BIGINT(20),
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX (`relatedKey`),
  INDEX (`longTypeId`)
)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if NOT EXISTS `course_comments`(
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `content` TEXT,
  `owner` BIGINT(20) NOT NULL,
  `publishTime` BIGINT(20) NOT NULL,
  `lastReplyTime` BIGINT(20) NOT NULL,
  `courseId` varchar(50) NOT NULL,
  `replyCount` INT DEFAULT 0,
  `deleted` INT NOT NULL DEFAULT 0,
  `score1` TINYINT DEFAULT 0,
  `score2` TINYINT DEFAULT 0,
  `score3` TINYINT DEFAULT 0,
  `score4` TINYINT DEFAULT 0,
  `score5` TINYINT DEFAULT 0,
  `averageScore` DOUBLE DEFAULT 0,
  `blocked` BOOL DEFAULT FALSE,

  INDEX(`courseId`,`lastReplyTime`),
  INDEX(`courseId`,`publishTime`),
  INDEX(`courseId`,`replyCount`),
  INDEX(`courseId`,`owner`),
  INDEX(`owner`)

)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;
CREATE TABLE if NOT EXISTS `course_replies`(
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `content` TEXT,
  `owner` BIGINT(20) NOT NULL,
  `publishTime` BIGINT(20) NOT NULL,
  `commentId` BIGINT(20) NOT NULL,
  `replyTo` BIGINT(20) DEFAULT -1,
  `replyToUser` BIGINT(20) NOT NULL,
  `deleted` INT NOT NULL DEFAULT 0,
  `blocked` BOOL DEFAULT FALSE,

  INDEX(`owner`),
  INDEX(`commentId`,`publishTime`)

)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if not EXISTS `coursecomment_picture`(
  `pid` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `longTypeId` BIGINT(20) ,
  `name` varchar(50),
  `uploadTime` BIGINT(20) ,
  `size` INT ,
  `width` INT ,
  `height` INT,
  `relatedKey` BIGINT(20),
  `flag` INT,
  `uploader` BIGINT(20),
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX (`relatedKey`),
  INDEX (`longTypeId`)

)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if not EXISTS `coursereply_picture`(
  `pid` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `longTypeId` BIGINT(20) ,
  `name` varchar(50),
  `uploadTime` BIGINT(20) ,
  `size` INT ,
  `width` INT ,
  `height` INT,
  `relatedKey` BIGINT(20),
  `flag` INT,
  `uploader` BIGINT(20),
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX (`relatedKey`),
  INDEX (`longTypeId`)

)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if not EXISTS `user_picture`(
  `pid` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `longTypeId` BIGINT(20) ,
  `name` varchar(50)  CHARACTER SET latin1,
  `uploadTime` BIGINT(20) ,
  `size` INT ,
  `width` INT ,
  `height` INT,
  `relatedKey` BIGINT(20),
  `flag` INT,
  `uploader` BIGINT(20),
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX (`relatedKey`),
  INDEX (`longTypeId`)
)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if not EXISTS  `user_in_circle` (
  `userId` bigint(20) NOT NULL,
  `circleId` bigint(20) NOT NULL,
  `joinTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`userId`,`circleId`),
  INDEX(`userId`, `joinTime`)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE  if not EXISTS `user_like_topic` (
  `userId` BIGINT(20) NOT NULL ,
  `topicId` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`userId`,`topicId`),
  INDEX(`topicId`)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE  if not EXISTS `token_user` (
  `tokenId` varchar(50) NOT NULL PRIMARY KEY ,
  `innerId` BIGINT(20) NOT NULL,
  `validTo` BIGINT(20) NOT NULL
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE  if not EXISTS `top_topic` (
  `circleId` BIGINT(20) NOT NULL ,
  `topicId` BIGINT(20) NOT NULL,
  PRIMARY KEY (`circleId`, `topicId`),
  INDEX(`topicId`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `report_topic` (
  `reportId` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `reporter` BIGINT(20),
  `reportTime` BIGINT(20),
  `type` varchar(30),
  `destId` BIGINT(20),
  `handleTime` BIGINT(20),
  `status` varchar(255),
  INDEX (`reporter`),
  INDEX (`type`, `destId`),
  INDEX (`reportTime`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `reports` (
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `reporter` BIGINT(20),
  `reportTime` BIGINT(20),
  `type` varchar(20),
  `destId` BIGINT(20),
  `reason` varchar(20),
  `content` TEXT,
  `handleTime` BIGINT(20) DEFAULT 0,
  `status` int DEFAULT 0,
  INDEX (`reporter`),
  INDEX (`type`, `destId`),
  INDEX (`reportTime`,`status`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `sensitiveWords` (
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `word` varchar(20),
  `wordid` varchar(20),
  `slevel` INT DEFAULT 1,
  UNIQUE INDEX (`word`)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `categories` (
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(20),
  `level` INT DEFAULT 0,
  `parentId` INT DEFAULT 0,
  `position` INT DEFAULT 0,
  UNIQUE INDEX (`id`, `name`),
  UNIQUE INDEX (`level`, `name`)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `tags` (
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(20),
  `level` INT DEFAULT 0,
  `parentId` INT DEFAULT 0,
  `position` INT DEFAULT 0,
  `enable` TINYINT(1) DEFAULT 0,
  UNIQUE INDEX (`id`, `name`),
  UNIQUE INDEX (`level`, `name`)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `circle_categories` (
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `circleId` BIGINT(20) NOT NULL,
  `categoryId` BIGINT(20) NOT NULL,
  INDEX (`circleId`)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `circle_tags` (
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `circleId` BIGINT(20) NOT NULL,
  `tagId` BIGINT(20) NOT NULL,
  INDEX (`circleId`)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `notifications` (
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(64),
  `type` INT,
  `priority` INT,
  `content` TEXT,
  `contentType` INT,
  `contentSource` INT,
  `postAction` TEXT,
  `deleted` BOOL DEFAULT FALSE,
  `ts_post` BIGINT(20),
  `ts_delete` BIGINT(20),
  `isBroadcast` BOOL DEFAULT FALSE,
  `uid_file_id` TEXT,
  `umeng_task_status` TEXT,
  `validhours` INT NOT NULL DEFAULT 72,
  `extra` TEXT,
  `cnt_post` INT,
  `cnt_open` INT,
  `cnt_read` INT,
  INDEX(`id`, `type`),
  INDEX(`id`, `type`, `ts_post`),
  INDEX(`ts_post`)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE if not EXISTS `notification_picture`(
  `pid` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `longTypeId` BIGINT(20) ,
  `name` varchar(50)  CHARACTER SET latin1,
  `uploadTime` BIGINT(20) ,
  `size` INT ,
  `width` INT ,
  `height` INT,
  `relatedKey` BIGINT(20),
  `flag` INT,
  `uploader` BIGINT(20),
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX (`relatedKey`),
  INDEX (`longTypeId`)
)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE IF NOT EXISTS  `notification_flags` (
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `uid` varchar(50)  CHARACTER SET latin1 NOT NULL,
  `notificationId` bigint(20) NOT NULL,
  `isBroadcast` BOOL DEFAULT FALSE,
  `isOpen` BOOL DEFAULT FALSE,
  `isRead` BOOL DEFAULT FALSE,
  `deleted` BOOL DEFAULT FALSE,
  `ts_open` BIGINT(20),
  `ts_read` BIGINT(20),
  `ts_delete` BIGINT(20),
  INDEX(`id`, `uid`, `ts_read`),
  INDEX(`id`, `uid`, `notificationId`, `ts_read`),
  UNIQUE INDEX(`uid`, `notificationId`),
  INDEX(`ts_read`)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
;

CREATE TABLE if NOT EXISTS `activity`(
  `id` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `title` TEXT,
  `content` TEXT,
  `ts_start` BIGINT(20) NOT NULL,
  `ts_end` BIGINT(20) NOT NULL,
  `place` TEXT,
  `telephone` TEXT,
  `circleId` BIGINT(20) NOT NULL,
  `memberlimit` INT DEFAULT 0,
  `ts_register_due` BIGINT(20) NOT NULL,
  `manaul_audit` BOOL DEFAULT FALSE,
  `status` INT DEFAULT 1,
  `b_name` BOOL DEFAULT TRUE,
  `b_phone` BOOL DEFAULT FALSE,
  `b_genda` BOOL DEFAULT FALSE,
  `b_age` BOOL DEFAULT FALSE,
  `b_mailbox` BOOL DEFAULT FALSE,
  `b_company` BOOL DEFAULT FALSE,
  `b_position` BOOL DEFAULT FALSE,
  `b_remark` BOOL DEFAULT FALSE,
  UNIQUE KEY(`id`)
)
ENGINE=INNODB
DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if not EXISTS `activity_picture`(
  `pid` BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `longTypeId` BIGINT(20) ,
  `name` varchar(50),
  `uploadTime` BIGINT(20) ,
  `size` INT ,
  `width` INT ,
  `height` INT,
  `relatedKey` BIGINT(20),
  `flag` INT,
  `uploader` BIGINT(20),
  `deleted` INT NOT NULL DEFAULT 0,
  INDEX (`relatedKey`),
  INDEX (`longTypeId`)
)
  ENGINE=INNODB
  DEFAULT CHARACTER SET=utf8mb4
;

CREATE TABLE if NOT EXISTS `activity_enrollment` (
  `userId` BIGINT(20) NOT NULL,
  `activityId` BIGINT(20) NOT NULL,
  `name` VARCHAR(30) NULL,
  `phone` VARCHAR(20) NULL,
  `sexId` VARCHAR(10) NULL,
  `age` INT(11) NULL,
  `mailbox` VARCHAR(50) NULL,
  `company` VARCHAR(100) NULL,
  `position` VARCHAR(20) NULL,
  `remark` VARCHAR(200) NULL,
  `state` INT NULL DEFAULT 0,
  `enrollTime` BIGINT(20) NOT NULL,
  `stateChangeTime` BIGINT(20) NULL,
  PRIMARY KEY (`userId`, `activityId`)
  )
ENGINE=INNODB
DEFAULT CHARACTER SET=utf8mb4
  ;
