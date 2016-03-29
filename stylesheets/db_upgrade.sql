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
