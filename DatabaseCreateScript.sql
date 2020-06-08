/* Database opzetten */

USE sys;
DROP SCHEMA IF EXISTS JiraSyncMachine;

CREATE DATABASE JiraSyncMachine;
USE JiraSyncMachine;

/*==============================================================*/
/* TABLE: sync_machine_account                                  */
/*==============================================================*/
CREATE TABLE sync_machine_account (
   user_id              INT AUTO_INCREMENT  NOT NULL,
   username             VARCHAR(30)         NOT NULL,
   password             CHAR(64)       NOT NULL,
   CONSTRAINT PK_SYNC_MACHINE_ACCOUNT PRIMARY KEY (user_id)
);

/*==============================================================*/
/* TABLE: jira_user                                             */
/*==============================================================*/
CREATE TABLE jira_user (
   user_id							INT                  NOT NULL,
   origin_instance_user_key			CHAR(13)          NULL,
   destination_instance_user_key	CHAR(13)          NULL,
   auto_sync						BIT                  NULL,
   CONSTRAINT PK_JIRA_USER PRIMARY KEY NONCLUSTERED (user_id),
   CONSTRAINT AK_ORIGIN_USER_KEY UNIQUE (origin_instance_user_key),
   CONSTRAINT AK_DESTINATION_USER_KEY UNIQUE (destination_instance_user_key),
   CONSTRAINT FK_SYNC_MACHINE_ACCOUNT_JIRA_USER FOREIGN KEY (user_id)
      REFERENCES sync_machine_account (user_id)
         ON UPDATE CASCADE 
         ON DELETE CASCADE
);

/*==============================================================*/
/* TABLE: worklog                                               */
/*==============================================================*/
CREATE TABLE worklog (
   worklog_id			 INT                  NOT NULL,
   CONSTRAINT PK_WORKLOG PRIMARY KEY (worklog_id)
);

/*==============================================================*/
/* TABLE: error_logs                                             */
/*==============================================================*/
CREATE TABLE error_logs (
  error_id							INT AUTO_INCREMENT  NOT NULL,
  error_timestamp					timestamp 			NOT NULL 
      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  class_name 						VARCHAR(255)		NOT NULL,
  method_name						VARCHAR(50)			NOT NULL,
  error_message						text				NOT NULL,
  CONSTRAINT PK_ERROR_ID PRIMARY KEY (error_id)
);
