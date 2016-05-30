DROP PROCEDURE IF EXISTS upgrade_users;
DELIMITER // 
CREATE PROCEDURE upgrade_users() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='users' AND column_name ='ts_register') 
THEN 
	ALTER TABLE users ADD ts_register BIGINT(20) NOT NULL DEFAULT 0;
END IF;

IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='users' AND column_name ='blocked') 
THEN 
	ALTER TABLE users ADD blocked tinyint(1) DEFAULT 0;
END IF;

IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='users' AND column_name ='ts_block') 
THEN 
	ALTER TABLE users ADD ts_block bigint(20) DEFAULT 0;
END IF;

END;
//  
DELIMITER ;
CALL upgrade_users();

DROP PROCEDURE IF EXISTS upgrade_notifications;
DELIMITER // 
CREATE PROCEDURE upgrade_notifications() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='notifications' AND column_name ='validhours') 
THEN 
	ALTER TABLE notifications ADD validhours INT NOT NULL DEFAULT 72;
END IF;
END;
//  
DELIMITER ;
CALL upgrade_notifications();

DROP PROCEDURE IF EXISTS upgrade_topics;
DELIMITER // 
CREATE PROCEDURE upgrade_topics() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='topics' AND column_name ='activityId') 
THEN 
	ALTER TABLE topics ADD activityId BIGINT(20) NOT NULL DEFAULT 0;
END IF;
END;
//  
DELIMITER ;
CALL upgrade_topics();


DROP PROCEDURE IF EXISTS upgrade_categories;
DELIMITER // 
CREATE PROCEDURE upgrade_categories() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='categories' AND column_name ='position') 
THEN 
	ALTER TABLE categories ADD position INT DEFAULT 0;
END IF;

IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='categories' AND column_name ='enable') 
THEN 
	ALTER TABLE categories ADD enable TINYINT(1) DEFAULT 0;
END IF;

END;
//  
DELIMITER ;
CALL upgrade_categories();


DROP PROCEDURE IF EXISTS upgrade_tags;
DELIMITER // 
CREATE PROCEDURE upgrade_tags() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='tags' AND column_name ='position') 
THEN 
	ALTER TABLE tags ADD position INT DEFAULT 0;
END IF;

IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='tags' AND column_name ='enable') 
THEN 
	ALTER TABLE tags ADD enable TINYINT(1) DEFAULT 0;
END IF;

END;
//  
DELIMITER ;
CALL upgrade_tags();


DROP PROCEDURE IF EXISTS upgrade_circles;
DELIMITER // 
CREATE PROCEDURE upgrade_circles() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='circles' AND column_name ='categories') 
THEN 
	ALTER TABLE circles DROP COLUMN categories;
END IF;

IF EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='circles' AND column_name ='tags') 
THEN 
	ALTER TABLE circles DROP COLUMN tags;
END IF;

END;
//  
DELIMITER ;
CALL upgrade_circles();


DROP PROCEDURE IF EXISTS upgrade_activity;
DELIMITER // 
CREATE PROCEDURE upgrade_activity() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='activity' AND column_name ='ts_create') 
THEN 
	ALTER TABLE activity ADD ts_create BIGINT(20) DEFAULT 0;
END IF;
END;
//  
DELIMITER ;
CALL upgrade_activity();


DROP PROCEDURE IF EXISTS upgrade_user_like_topic;
DELIMITER // 
CREATE PROCEDURE upgrade_user_like_topic() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='user_like_topic' AND column_name ='publishTime') 
THEN 
	ALTER TABLE user_like_topic ADD publishTime BIGINT(20) DEFAULT 0;
END IF;
END;
//  
DELIMITER ;
CALL upgrade_user_like_topic();

DROP PROCEDURE IF EXISTS upgrade_circle_categories;
DELIMITER // 
CREATE PROCEDURE upgrade_circle_categories() 
BEGIN   
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS 
	(SELECT * FROM information_schema.columns 
		WHERE table_schema='spark' AND table_name ='circle_categories' AND column_name ='isTop') 
THEN 
	ALTER TABLE circle_categories ADD isTop tinyint(1) DEFAULT 0;
END IF;
END;
//  
DELIMITER ;
CALL upgrade_circle_categories();

DROP PROCEDURE IF EXISTS upgrade_comments_blocked;
DELIMITER //
CREATE PROCEDURE upgrade_comments_blocked()
BEGIN
DECLARE spark VARCHAR(100);
SELECT DATABASE() INTO spark;
IF NOT EXISTS
	(SELECT * FROM information_schema.columns
		WHERE table_schema='spark' AND table_name ='comments' AND column_name ='blocked')
THEN
	ALTER TABLE comments ADD blocked BOOL DEFAULT FALSE;
END IF;
END;
//
DELIMITER ;
CALL upgrade_comments_blocked();