USE master
IF EXISTS(SELECT * FROM sys.databases WHERE NAME='JiraSyncMachine')
DROP DATABASE JiraSyncMachine

CREATE DATABASE JiraSyncMachine


IF EXISTS (SELECT 1
   FROM sys.sysreferences r JOIN sys.sysobjects o ON (o.id = r.constid AND o.type = 'F')
   WHERE r.fkeyid = object_id('JIRA_USER') AND o.name = 'FK_JIRA_USE_REFERENCE_SYNC_MACHINE')
ALTER TABLE JIRA_USER
   DROP CONSTRAINT FK_JIRA_USE_REFERENCE_SYNC_MACHINE
go

IF EXISTS (SELECT 1
           FROM  sysobjects
           WHERE id = object_id('JIRA_USER')
           AND   type = 'U')
   DROP TABLE JIRA_USER
go

IF EXISTS (SELECT 1
           FROM  sysobjects
           WHERE id = object_id('SYNC_MACHINE_ACCOUNT')
           AND   type = 'U')
   DROP TABLE SYNC_MACHINE_ACCOUNT
go

IF EXISTS (SELECT 1
           FROM  sysobjects
           WHERE id = object_id('WORKLOG')
           AND   type = 'U')
   DROP TABLE WORKLOG
go

/*==============================================================*/
/* Table: JIRA_USER                                             */
/*==============================================================*/
CREATE TABLE JIRA_USER (
   ORIGIN_INSTANTCE_USER_KEY VARCHAR(13)     NOT NULL,
   DESTINATION_INSTANCE_USER_KEY VARCHAR(13) NOT NULL,
   USER_ID              INT                  NOT NULL,
   AUTO_SYNC            BIT                  NOT NULL,
   CONSTRAINT PK_JIRA_USER PRIMARY KEY NONCLUSTERED (ORIGIN_INSTANTCE_USER_KEY)
)
go

/*==============================================================*/
/* Table: SYNC_MACHINE_ACCOUNT                                  */
/*==============================================================*/
CREATE TABLE SYNC_MACHINE_ACCOUNT (
   USER_ID              INT                  NOT NULL,
   USERNAME             VARCHAR(MAX)         NOT NULL,
   PASSWORD             CHARACTER(30)        NOT NULL,
   CONSTRAINT PK_SYNC_MACHINE_ACCOUNT PRIMARY KEY (USER_ID)
)
go

/*==============================================================*/
/* Table: WORKLOG                                               */
/*==============================================================*/
CREATE TABLE WORKLOG (
   WORKLOG_ID           INT                  NOT NULL,
   CONSTRAINT PK_WORKLOG PRIMARY KEY (WORKLOG_ID)
)
go

ALTER TABLE JIRA_USER
   ADD CONSTRAINT FK_JIRA_USE_REFERENCE_SYNC_MACHINE FOREIGN KEY (USER_ID)
      REFERENCES SYNC_MACHINE_ACCOUNT (USER_ID)
         ON UPDATE CASCADE ON DELETE CASCADE
go
