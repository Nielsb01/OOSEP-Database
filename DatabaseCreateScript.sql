/* Database Opzetten */

USE master
IF EXISTS(SELECT * FROM sys.databases WHERE NAME='JiraSyncMachine')
DROP DATABASE JiraSyncMachine

CREATE DATABASE JiraSyncMachine
USE JiraSyncMachine


/*==============================================================*/
/* TABLE: jira_user                                             */
/*==============================================================*/
CREATE TABLE jira_user (
   user_id							INT                  NOT NULL,
   origin_instance_user_key		VARCHAR(13)          NOT NULL,
   destination_instance_user_key	VARCHAR(13)          NOT NULL,
   auto_sync						BIT                  NOT NULL,
   CONSTRAINT PK_JIRA_USER PRIMARY KEY NONCLUSTERED (user_id),
   CONSTRAINT AK_ORIGIN_USER_KEY UNIQUE (origin_instance_user_key),
   CONSTRAINT AK_DESTINATION_USER_KEY UNIQUE (destination_instance_user_key)
)
GO

/*==============================================================*/
/* TABLE: sync_machine_account                                  */
/*==============================================================*/
CREATE TABLE sync_machine_account (
   user_id              INT                  NOT NULL,
   username             VARCHAR(Max)         NOT NULL,
   password             CHARACTER(30)        NOT NULL,
   CONSTRAINT PK_SYNC_MACHINE_ACCOUNT PRIMARY KEY (user_id)
)
GO

/*==============================================================*/
/* TABLE: worklog                                               */
/*==============================================================*/
CREATE TABLE worklog (
   worklog_id			 INT                  NOT NULL,
   CONSTRAINT PK_WORKLOG PRIMARY KEY (worklog_id)
)
GO


ALTER TABLE jira_user
   ADD CONSTRAINT FK_SYNC_MACHINE_ACCOUNT_JIRA_USER FOREIGN KEY (user_id)
      REFERENCES sync_machine_account (user_id)
         ON UPDATE CASCADE ON DELETE CASCADE
GO
