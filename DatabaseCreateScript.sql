USE master
IF EXISTS(SELECT * FROM sys.databases WHERE NAME='JiraSyncMachine')
DROP DATABASE JiraSyncMachine

CREATE DATABASE JiraSyncMachine


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('JIRA_USER') and o.name = 'FK_JIRA_USE_REFERENCE_SYNC_MAC')
alter table JIRA_USER
   drop constraint FK_JIRA_USE_REFERENCE_SYNC_MAC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('JIRA_USER')
            and   type = 'U')
   drop table JIRA_USER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYNC_MACHINE_ACCOUNT')
            and   type = 'U')
   drop table SYNC_MACHINE_ACCOUNT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WORKLOG')
            and   type = 'U')
   drop table WORKLOG
go

/*==============================================================*/
/* Table: JIRA_USER                                             */
/*==============================================================*/
create table JIRA_USER (
   USER_ID              int                  not null,
   ORIGIN_INSTANCE_USER_KEY varchar(13)          not null,
   DESTINATION_INSTANCE_USER_KEY varchar(13)          not null,
   AUTO_SYNC            bit                  not null,
   constraint PK_JIRA_USER primary key nonclustered (USER_ID),
   constraint AK_ORIGIN_USER_KEY unique (),
   constraint AK_DESTINATION_USE unique ()
)
go

/*==============================================================*/
/* Table: SYNC_MACHINE_ACCOUNT                                  */
/*==============================================================*/
create table SYNC_MACHINE_ACCOUNT (
   USER_ID              int                  not null,
   USERNAME             varchar(Max)         not null,
   PASSWORD             character(30)        not null,
   constraint PK_SYNC_MACHINE_ACCOUNT primary key (USER_ID)
)
go

/*==============================================================*/
/* Table: WORKLOG                                               */
/*==============================================================*/
create table WORKLOG (
   WORKLOG_ID           int                  not null,
   constraint PK_WORKLOG primary key (WORKLOG_ID)
)
go

alter table JIRA_USER
   add constraint FK_JIRA_USE_REFERENCE_SYNC_MAC foreign key (USER_ID)
      references SYNC_MACHINE_ACCOUNT (USER_ID)
         on update cascade on delete cascade
go

