--
-- Скрипт сгенерирован Devart dbForge Studio for SQL Server, Версия 4.5.79.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/sql/studio
-- Дата скрипта: 12.10.2015 19:01:40
-- Версия сервера: 12.00.2269
-- Версия клиента: 
--


USE master
GO

IF DB_NAME() <> N'master' SET NOEXEC ON

--
-- Создать базу данных "LiveChatDb"
--
PRINT (N'Создать базу данных "LiveChatDb"')
GO
CREATE DATABASE LiveChatDb
ON PRIMARY(
    NAME = N'LiveChatDb',
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\LiveChatDb.mdf',
    SIZE = 5120KB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 1024KB
)
LOG ON(
    NAME = N'LiveChatDb_log',
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\LiveChatDb_log.ldf',
    SIZE = 1024KB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10%
)
GO

--
-- Изменить базу данных
--
PRINT (N'Изменить базу данных')
GO
ALTER DATABASE LiveChatDb
  SET
    ANSI_NULL_DEFAULT OFF,
    ANSI_NULLS OFF,
    ANSI_PADDING OFF,
    ANSI_WARNINGS OFF,
    ARITHABORT OFF,
    AUTO_CLOSE OFF,
    AUTO_CREATE_STATISTICS ON,
    AUTO_SHRINK OFF,
    AUTO_UPDATE_STATISTICS ON,
    AUTO_UPDATE_STATISTICS_ASYNC OFF,
    COMPATIBILITY_LEVEL = 120,
    CONCAT_NULL_YIELDS_NULL OFF,
    CURSOR_CLOSE_ON_COMMIT OFF,
    CURSOR_DEFAULT GLOBAL,
    DATE_CORRELATION_OPTIMIZATION OFF,
    DB_CHAINING OFF,
    HONOR_BROKER_PRIORITY OFF,
    MULTI_USER,
    NUMERIC_ROUNDABORT OFF,
    PAGE_VERIFY CHECKSUM,
    PARAMETERIZATION SIMPLE,
    QUOTED_IDENTIFIER OFF,
    READ_COMMITTED_SNAPSHOT OFF,
    RECOVERY FULL,
    RECURSIVE_TRIGGERS OFF,
    TRUSTWORTHY OFF
    WITH ROLLBACK IMMEDIATE
GO

ALTER DATABASE LiveChatDb
  SET DISABLE_BROKER
GO

ALTER DATABASE LiveChatDb
  SET ALLOW_SNAPSHOT_ISOLATION OFF
GO

ALTER DATABASE LiveChatDb
  SET FILESTREAM (NON_TRANSACTED_ACCESS = OFF)
GO

USE LiveChatDb
GO

IF DB_NAME() <> N'LiveChatDb' SET NOEXEC ON
GO

--
-- Создать таблицу "dbo.UserLogin"
--
PRINT (N'Создать таблицу "dbo.UserLogin"')
GO
CREATE TABLE dbo.UserLogin (
  LoginProvider nvarchar(128) NOT NULL,
  ProviderKey nvarchar(128) NOT NULL,
  UserId int NOT NULL,
  CONSTRAINT [PK_dbo.UserLogin] PRIMARY KEY CLUSTERED (LoginProvider, ProviderKey)
)
ON [PRIMARY]
GO

--
-- Создать индекс "IX_UserId" для объекта типа таблица "dbo.UserLogin"
--
PRINT (N'Создать индекс "IX_UserId" для объекта типа таблица "dbo.UserLogin"')
GO
CREATE INDEX IX_UserId
  ON dbo.UserLogin (UserId)
  ON [PRIMARY]
GO

--
-- Создать таблицу "dbo.UserClaim"
--
PRINT (N'Создать таблицу "dbo.UserClaim"')
GO
CREATE TABLE dbo.UserClaim (
  Id int IDENTITY,
  UserId int NULL,
  ClaimType nvarchar(max) NULL,
  ClaimValue nvarchar(max) NULL,
  CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Создать индекс "IX_UserId" для объекта типа таблица "dbo.UserClaim"
--
PRINT (N'Создать индекс "IX_UserId" для объекта типа таблица "dbo.UserClaim"')
GO
CREATE INDEX IX_UserId
  ON dbo.UserClaim (UserId)
  ON [PRIMARY]
GO

--
-- Создать таблицу "dbo.[User]"
--
PRINT (N'Создать таблицу "dbo.[User]"')
GO
CREATE TABLE dbo.[User] (
  Id int IDENTITY,
  Email nvarchar(256) NULL,
  EmailConfirmed bit NOT NULL,
  PasswordHash nvarchar(max) NULL,
  SecurityStamp nvarchar(max) NULL,
  PhoneNumber nvarchar(max) NULL,
  PhoneNumberConfirmed bit NOT NULL,
  TwoFactorEnabled bit NOT NULL,
  LockoutEndDateUtc datetime NULL,
  LockoutEnabled bit NOT NULL,
  AccessFailedCount int NOT NULL,
  UserName nvarchar(256) NOT NULL,
  RelatedApplication_Id int NULL,
  CONSTRAINT PK_AspNetUsers PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Создать индекс "UserNameIndex" для объекта типа таблица "dbo.[User]"
--
PRINT (N'Создать индекс "UserNameIndex" для объекта типа таблица "dbo.[User]"')
GO
CREATE UNIQUE INDEX UserNameIndex
  ON dbo.[User] (UserName)
  ON [PRIMARY]
GO

--
-- Создать таблицу "dbo.Role"
--
PRINT (N'Создать таблицу "dbo.Role"')
GO
CREATE TABLE dbo.Role (
  Id int IDENTITY,
  Name nvarchar(256) NOT NULL,
  CONSTRAINT PK_AspNetRoles PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

--
-- Создать индекс "RoleNameIndex" для объекта типа таблица "dbo.Role"
--
PRINT (N'Создать индекс "RoleNameIndex" для объекта типа таблица "dbo.Role"')
GO
CREATE UNIQUE INDEX RoleNameIndex
  ON dbo.Role (Name)
  ON [PRIMARY]
GO

--
-- Создать таблицу "dbo.Message"
--
PRINT (N'Создать таблицу "dbo.Message"')
GO
CREATE TABLE dbo.Message (
  Id bigint IDENTITY,
  Dialog_id int NOT NULL,
  Text text NOT NULL,
  SendedAt datetime NOT NULL,
  Sender_id int NOT NULL,
  CONSTRAINT PK_Massege PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Создать таблицу "dbo.CustomerApplication"
--
PRINT (N'Создать таблицу "dbo.CustomerApplication"')
GO
CREATE TABLE dbo.CustomerApplication (
  Id int IDENTITY,
  AppKey nvarchar(255) NOT NULL,
  OwnerUser_Id int NOT NULL,
  WebsiteUrl nvarchar(50) NOT NULL,
  SubjectScope nvarchar(50) NULL,
  ContactEmail nvarchar(50) NOT NULL,
  CONSTRAINT PK_CustomerApplication PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

--
-- Создать таблицу "dbo.UserRole"
--
PRINT (N'Создать таблицу "dbo.UserRole"')
GO
CREATE TABLE dbo.UserRole (
  UserId int NOT NULL,
  RoleId int NOT NULL,
  CONSTRAINT [PK_dbo.UserRoles] PRIMARY KEY CLUSTERED (RoleId, UserId)
)
ON [PRIMARY]
GO

--
-- Создать индекс "IX_RoleId" для объекта типа таблица "dbo.UserRole"
--
PRINT (N'Создать индекс "IX_RoleId" для объекта типа таблица "dbo.UserRole"')
GO
CREATE INDEX IX_RoleId
  ON dbo.UserRole (RoleId)
  ON [PRIMARY]
GO

--
-- Создать индекс "IX_UserId" для объекта типа таблица "dbo.UserRole"
--
PRINT (N'Создать индекс "IX_UserId" для объекта типа таблица "dbo.UserRole"')
GO
CREATE INDEX IX_UserId
  ON dbo.UserRole (UserId)
  ON [PRIMARY]
GO

--
-- Создать таблицу "dbo.UserDialog"
--
PRINT (N'Создать таблицу "dbo.UserDialog"')
GO
CREATE TABLE dbo.UserDialog (
  User_Id int NOT NULL,
  Dialog_Id int NOT NULL,
  CONSTRAINT PK_UserDialog PRIMARY KEY CLUSTERED (User_Id, Dialog_Id)
)
ON [PRIMARY]
GO

--
-- Создать таблицу "dbo.Dialog"
--
PRINT (N'Создать таблицу "dbo.Dialog"')
GO
CREATE TABLE dbo.Dialog (
  Id int IDENTITY,
  StartedAt datetime NOT NULL,
  ClosedAt datetime NOT NULL,
  CONSTRAINT PK_Dialog PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO
-- 
-- Вывод данных для таблицы CustomerApplication
--
-- Таблица LiveChatDb.dbo.CustomerApplication не содержит данных
-- 
-- Вывод данных для таблицы Dialog
--
-- Таблица LiveChatDb.dbo.Dialog не содержит данных
-- 
-- Вывод данных для таблицы Message
--
-- Таблица LiveChatDb.dbo.Message не содержит данных
-- 
-- Вывод данных для таблицы Role
--
-- Таблица LiveChatDb.dbo.Role не содержит данных
-- 
-- Вывод данных для таблицы [User]
--
SET IDENTITY_INSERT dbo.[User] ON
GO
INSERT dbo.[User](Id, Email, EmailConfirmed, PasswordHash, SecurityStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEndDateUtc, LockoutEnabled, AccessFailedCount, UserName, RelatedApplication_Id) VALUES (1, N'antonbeletskty@gmail.com', CONVERT(bit, 'False'), N'AIDtKWJQK9VjwUXJ+u8SlMC1iY/QULEqJ5/qMl7pfDqq5hyYFpeQ5aPKCVVDp09AiQ==', N'e0e4368a-62d4-44f1-91fb-0d279f67e5a2', NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'True'), 0, N'antonbeletskty@gmail.com', NULL)
GO
SET IDENTITY_INSERT dbo.[User] OFF
GO
-- 
-- Вывод данных для таблицы UserClaim
--
-- Таблица LiveChatDb.dbo.UserClaim не содержит данных
-- 
-- Вывод данных для таблицы UserDialog
--
-- Таблица LiveChatDb.dbo.UserDialog не содержит данных
-- 
-- Вывод данных для таблицы UserLogin
--
-- Таблица LiveChatDb.dbo.UserLogin не содержит данных
-- 
-- Вывод данных для таблицы UserRole
--
-- Таблица LiveChatDb.dbo.UserRole не содержит данных

USE LiveChatDb
GO

IF DB_NAME() <> N'LiveChatDb' SET NOEXEC ON
GO

--
-- Создать внешний ключ "FK_UserRole_Role" для объекта типа таблица "dbo.UserRole"
--
PRINT (N'Создать внешний ключ "FK_UserRole_Role" для объекта типа таблица "dbo.UserRole"')
GO
ALTER TABLE dbo.UserRole
  ADD CONSTRAINT FK_UserRole_Role FOREIGN KEY (RoleId) REFERENCES dbo.Role (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_UserRole_User_Id" для объекта типа таблица "dbo.UserRole"
--
PRINT (N'Создать внешний ключ "FK_UserRole_User_Id" для объекта типа таблица "dbo.UserRole"')
GO
ALTER TABLE dbo.UserRole
  ADD CONSTRAINT FK_UserRole_User_Id FOREIGN KEY (UserId) REFERENCES dbo.[User] (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_UserLogin_User_Id" для объекта типа таблица "dbo.UserLogin"
--
PRINT (N'Создать внешний ключ "FK_UserLogin_User_Id" для объекта типа таблица "dbo.UserLogin"')
GO
ALTER TABLE dbo.UserLogin
  ADD CONSTRAINT FK_UserLogin_User_Id FOREIGN KEY (UserId) REFERENCES dbo.[User] (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_UserDialog_Dialog" для объекта типа таблица "dbo.UserDialog"
--
PRINT (N'Создать внешний ключ "FK_UserDialog_Dialog" для объекта типа таблица "dbo.UserDialog"')
GO
ALTER TABLE dbo.UserDialog
  ADD CONSTRAINT FK_UserDialog_Dialog FOREIGN KEY (Dialog_Id) REFERENCES dbo.Dialog (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_UserDialog_User_Id" для объекта типа таблица "dbo.UserDialog"
--
PRINT (N'Создать внешний ключ "FK_UserDialog_User_Id" для объекта типа таблица "dbo.UserDialog"')
GO
ALTER TABLE dbo.UserDialog
  ADD CONSTRAINT FK_UserDialog_User_Id FOREIGN KEY (User_Id) REFERENCES dbo.[User] (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_UserClaim_User_Id" для объекта типа таблица "dbo.UserClaim"
--
PRINT (N'Создать внешний ключ "FK_UserClaim_User_Id" для объекта типа таблица "dbo.UserClaim"')
GO
ALTER TABLE dbo.UserClaim
  ADD CONSTRAINT FK_UserClaim_User_Id FOREIGN KEY (UserId) REFERENCES dbo.[User] (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_Message_Dialog" для объекта типа таблица "dbo.Message"
--
PRINT (N'Создать внешний ключ "FK_Message_Dialog" для объекта типа таблица "dbo.Message"')
GO
ALTER TABLE dbo.Message
  ADD CONSTRAINT FK_Message_Dialog FOREIGN KEY (Dialog_id) REFERENCES dbo.Dialog (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_Message_User" для объекта типа таблица "dbo.Message"
--
PRINT (N'Создать внешний ключ "FK_Message_User" для объекта типа таблица "dbo.Message"')
GO
ALTER TABLE dbo.Message
  ADD CONSTRAINT FK_Message_User FOREIGN KEY (Sender_id) REFERENCES dbo.[User] (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_CustomerApplication_Owner" для объекта типа таблица "dbo.CustomerApplication"
--
PRINT (N'Создать внешний ключ "FK_CustomerApplication_Owner" для объекта типа таблица "dbo.CustomerApplication"')
GO
ALTER TABLE dbo.CustomerApplication
  ADD CONSTRAINT FK_CustomerApplication_Owner FOREIGN KEY (OwnerUser_Id) REFERENCES dbo.[User] (Id) ON UPDATE CASCADE
GO

--
-- Создать внешний ключ "FK_User_CustomerApplication" для объекта типа таблица "dbo.[User]"
--
PRINT (N'Создать внешний ключ "FK_User_CustomerApplication" для объекта типа таблица "dbo.[User]"')
GO
ALTER TABLE dbo.[User]
  ADD CONSTRAINT FK_User_CustomerApplication FOREIGN KEY (RelatedApplication_Id) REFERENCES dbo.CustomerApplication (Id) ON DELETE CASCADE
GO
SET NOEXEC OFF
GO