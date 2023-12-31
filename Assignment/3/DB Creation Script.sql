USE [master]
GO
/****** Object:  Database [StudentDB_1174066]    Script Date: 12/2/2023 11:52:08 AM ******/
CREATE DATABASE [StudentDB_1174066]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StudentDB_1174066', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\StudentDB_1174066.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StudentDB_1174066_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\StudentDB_1174066_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [StudentDB_1174066] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StudentDB_1174066].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StudentDB_1174066] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET ARITHABORT OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StudentDB_1174066] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StudentDB_1174066] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StudentDB_1174066] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StudentDB_1174066] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StudentDB_1174066] SET  MULTI_USER 
GO
ALTER DATABASE [StudentDB_1174066] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StudentDB_1174066] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StudentDB_1174066] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StudentDB_1174066] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StudentDB_1174066] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StudentDB_1174066] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [StudentDB_1174066] SET QUERY_STORE = ON
GO
ALTER DATABASE [StudentDB_1174066] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [StudentDB_1174066]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 12/2/2023 11:52:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseNum] [varchar](20) NOT NULL,
	[CourseName] [varchar](50) NOT NULL,
	[Description] [text] NULL,
	[Credits] [int] NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[CourseNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 12/2/2023 11:52:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[StudentId] [int] NOT NULL,
	[CourseNum] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Enrollments] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC,
	[CourseNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 12/2/2023 11:52:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentId] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NULL,
	[Cellphone] [varchar](50) NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/2/2023 11:52:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_name] [varchar](50) NULL,
	[password] [varchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Enrollments] FOREIGN KEY([CourseNum])
REFERENCES [dbo].[Courses] ([CourseNum])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Courses_Enrollments]
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK_Enrollments_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([StudentId])
GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK_Enrollments_Students]
GO
USE [master]
GO
ALTER DATABASE [StudentDB_1174066] SET  READ_WRITE 
GO
