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
   password             CHAR(64)       		NOT NULL,
   CONSTRAINT PK_SYNC_MACHINE_ACCOUNT PRIMARY KEY (user_id)
);

/*==============================================================*/
/* TABLE: jira_user                                             */
/*==============================================================*/
CREATE TABLE jira_user (
   user_id							INT                NOT NULL,
   origin_instance_user_key			CHAR(13)           NULL,
   destination_instance_user_key	CHAR(13)           NULL,
   auto_sync						TINYINT            NOT NULL,
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
/* TABLE: automatic_synchronisation                             */
/*==============================================================*/
CREATE TABLE automatic_synchronisation (
	synchronisation_moment DATETIME NOT NULL,
    CONSTRAINT PK_AUTOMATIC_SYNCHRONISATION PRIMARY KEY (synchronisation_date)
);