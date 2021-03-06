USE [master]
GO
/****** Object:  Database [CinemaDatabase]    Script Date: 5/4/2016 11:23:00 AM ******/
CREATE DATABASE [CinemaDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CinemaDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.ARTEMMAZUR\MSSQL\DATA\CinemaDatabase.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CinemaDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.ARTEMMAZUR\MSSQL\DATA\CinemaDatabase_log.ldf' , SIZE = 8384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CinemaDatabase] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CinemaDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CinemaDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CinemaDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CinemaDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CinemaDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CinemaDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CinemaDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CinemaDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CinemaDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CinemaDatabase] SET RECOVERY FULL 
GO
ALTER DATABASE [CinemaDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [CinemaDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CinemaDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CinemaDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CinemaDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [CinemaDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CinemaDatabase', N'ON'
GO
USE [CinemaDatabase]
GO
/****** Object:  UserDefinedFunction [dbo].[AverageMovieRating]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AverageMovieRating] (@movieId int)
returns float
as
	begin
	return
		(select AVG(Rate) from Ratings where MovieId = @movieId)
	end


GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](128) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Salt] [varchar](128) NOT NULL,
	[ProfileId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NOT NULL,
	[CommentText] [nvarchar](max) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[ProfileId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExternalAccounts]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExternalAccounts](
	[ExternalProviderId] [int] NOT NULL,
	[UserIdentity] [varchar](256) NOT NULL,
	[ProfileId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExternalProviderId] ASC,
	[UserIdentity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExternalProviders]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExternalProviders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GenreLocalization]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenreLocalization](
	[GenreId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genres]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Halls]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Halls](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](128) NOT NULL,
	[HallPicture] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovieLocalization]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieLocalization](
	[MovieId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MoviePersonsJunction]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MoviePersonsJunction](
	[MovieId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movies]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Length] [int] NOT NULL,
	[GenreId] [int] NULL,
	[ReleaseDate] [datetime] NOT NULL,
	[DirectorId] [int] NULL,
	[Rating]  AS ([dbo].[AverageMovieRating]([Id])),
	[PhotoId] [int] NULL,
	[VideoLink] [varchar](max) NULL,
	[IsDeleted] [bit] NOT NULL DEFAULT ((0)),
	[RemoveExecutorId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonLocalization]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonLocalization](
	[PersonId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persons]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotoId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Photos]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Filename] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Phone] [varchar](15) NULL,
	[Email] [varchar](128) NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsBlocked] [bit] NOT NULL DEFAULT ((0)),
	[Name] [nvarchar](128) NOT NULL,
	[Surname] [nvarchar](128) NOT NULL,
	[ImageData] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[Rate] [int] NOT NULL,
	[MovieId] [int] NOT NULL,
	[ProfileId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[ProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seances]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seances](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[HallId] [int] NOT NULL,
	[MovieId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeatTypes]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SeatTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sectors]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sectors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromRow] [int] NOT NULL,
	[ToRow] [int] NOT NULL,
	[FromPlace] [int] NOT NULL,
	[ToPlace] [int] NOT NULL,
	[SectorTypeId] [int] NOT NULL,
	[HallId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SectorTypePrices]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SectorTypePrices](
	[SectorTypeId] [int] NOT NULL,
	[SeanceId] [int] NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SectorTypeId] ASC,
	[SeanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SecurityToken]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityToken](
	[Id] [uniqueidentifier] NOT NULL,
	[AccountId] [int] NOT NULL,
	[ResetRequestDateTime] [datetime] NOT NULL,
	[IsUsed] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TicketPreOrders]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketPreOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Place] [int] NOT NULL,
	[SeanceId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[ProfileId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TicketPreOrdersDeleted]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketPreOrdersDeleted](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Place] [int] NOT NULL,
	[SeanceId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[ProfileId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Place] [int] NOT NULL,
	[SeanceId] [int] NOT NULL,
	[SaleDate] [datetime] NOT NULL,
	[ProfileId] [int] NULL,
	[Guid] [uniqueidentifier] NOT NULL DEFAULT (newid()),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([Id], [Login], [Password], [Salt], [ProfileId]) VALUES (10, N'artemmazur', N'g7JJGlwzGLqmTOWWchX/IA==', N'pAlzxevLbY4c/rBYW9gTrg==', 1)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [Salt], [ProfileId]) VALUES (11, N'artemmazur2', N'zHcaSdIFkEIi6cIBiHEjnQ==', N'wz1iENGjZLEu2eCjYz7MYA==', 2)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [Salt], [ProfileId]) VALUES (12, N'artemmazur3', N'46ZY7/q1Ap5xq8mXLox+jw==', N'cEdSe3eiFfxS1QttL/XVnw==', 3)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [Salt], [ProfileId]) VALUES (64, N'artemmazur4', N'6w73YFjDcxJYjq0q2jZGKA==', N'vX8QDdMIjE+VNa6Tm69bcw==', 58)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [Salt], [ProfileId]) VALUES (67, N'artemmazur6', N'HQyGHnwjBz+l+MhfnCN1ZQ==', N'wEy8xCgVNeSyI9RthWM+qg==', 61)
INSERT [dbo].[Accounts] ([Id], [Login], [Password], [Salt], [ProfileId]) VALUES (69, N'artemmazur5', N'VqsRY970pD3KBBt7hA14wg==', N'8bwZ8QiJMB2ORUklpDeaVg==', 63)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
INSERT [dbo].[ExternalAccounts] ([ExternalProviderId], [UserIdentity], [ProfileId]) VALUES (1, N'1533645540272789', 85)
INSERT [dbo].[ExternalAccounts] ([ExternalProviderId], [UserIdentity], [ProfileId]) VALUES (2, N'111499410035637801079', 85)
SET IDENTITY_INSERT [dbo].[ExternalProviders] ON 

INSERT [dbo].[ExternalProviders] ([Id], [Name]) VALUES (1, N'Facebook')
INSERT [dbo].[ExternalProviders] ([Id], [Name]) VALUES (2, N'Google')
SET IDENTITY_INSERT [dbo].[ExternalProviders] OFF
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (1, 1, N'Drama', N'In the context of film, television, and radio, drama describes a genre of narrative fiction (or semi-fiction) intended to be more serious than humorous in tone, focusing on in-depth development of realistic characters who must deal with realistic emotional struggles. A drama is commonly considered the opposite of a comedy, but may also be considered separate from other works of some broad genre, such as a fantasy. To distinguish drama as a genre of fiction from the use of the same word to mean the general storytelling mode of live performance, the word drama is often included as part of a phrase to specify its meaning. For instance, in the sense of a television genre, more common specific terms are a drama show, drama series, or television drama in the United States; dramatic programming in the United Kingdom; or teledrama in Sri Lanka. In the sense of a film genre, the common term is a drama film.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (2, 1, N'Action', N'Action films usually include high energy, big-budget physical stunts and chases, possibly with rescues, battles, fights, escapes, destructive crises (floods, explosions, natural disasters, fires, etc.), non-stop motion, spectacular rhythm and pacing, and adventurous, often two-dimensional ''good-guy'' heroes (or recently, heroines) battling ''bad guys'' - all designed for pure audience escapism.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (5, 1, N'Adventure', N'Adventure films are usually exciting stories, with new experiences or exotic locales, very similar to or often paired with the action film genre. They can include traditional swashbucklers, serialized films, and historical spectacles (similar to the epics film genre), searches or expeditions for lost continents, "jungle" and "desert" epics, treasure hunts, disaster films, or searches for the unknown.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (6, 1, N'Comedy', N'Comedies are light-hearted plots consistently and deliberately designed to amuse and provoke laughter (with one-liners, jokes, etc.) by exaggerating the situation, the language, action, relationships and characters. This section describes various forms of comedy through cinematic history, including slapstick, screwball, spoofs and parodies, romantic comedies, black comedy (dark satirical comedy), and more.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (7, 1, N'Crime & Gangster', N'Crime (gangster) films are developed around the sinister actions of criminals or mobsters, particularly bankrobbers, underworld figures, or ruthless hoodlums who operate outside the law, stealing and murdering their way through life. Criminal and gangster films are often categorized as film noir or detective-mystery films - because of underlying similarities between these cinematic forms. This category includes a description of various ''serial killer'' films.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (8, 1, N'Epics / Historical', N'Epics include costume dramas, historical dramas, war films, medieval romps, or ''period pictures'' that often cover a large expanse of time set against a vast, panoramic backdrop. Epics often share elements of the elaborate adventure films genre. Epics take an historical or imagined event, mythic, legendary, or heroic figure, and add an extravagant setting and lavish costumes, accompanied by grandeur and spectacle, dramatic scope, high production values, and a sweeping musical score. Epics are often a more spectacular, lavish version of a biopic film.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (9, 1, N'Horror', N'Horror films are designed to frighten and to invoke our hidden worst fears, often in a terrifying, shocking finale, while captivating and entertaining us at the same time in a cathartic experience. Horror films feature a wide range of styles, from the earliest silent Nosferatu classic, to today''s CGI monsters and deranged humans. They are often combined with science fiction when the menace or monster is related to a corruption of technology, or when Earth is threatened by aliens. The fantasy and supernatural film genres are not usually synonymous with the horror genre.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (10, 1, N'Musicals / Dance', N'Musical/dance films are cinematic forms that emphasize full-scale scores or song and dance routines in a significant way (usually with a musical or dance performance integrated as part of the film narrative), or they are films that are centered on combinations of music, dance, song or choreography.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (11, 1, N'Science fiction', N'Sci-fi films are often quasi-scientific, visionary and imaginative - complete with heroes, aliens, distant planets, impossible quests, improbable settings, fantastic places, great dark and shadowy villains, futuristic technology, unknown and unknowable forces, and extraordinary monsters (''things or creatures from space''), either created by mad scientists or by nuclear havoc. They are sometimes an offshoot of fantasy films (or superhero films), or they share some similarities with action/adventure films.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (12, 1, N'War', N'War (and anti-war) films acknowledge the horror and heartbreak of war, letting the actual combat fighting (against nations or humankind) on land, sea, or in the air provide the primary plot or background for the action of the film. War films are often paired with other genres, such as action, adventure, drama, romance, comedy (black), suspense, and even epics and westerns, and they often take a denunciatory approach toward warfare.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (13, 1, N'Western', N'Westerns are the major defining genre of the American film industry - a eulogy to the early days of the expansive American frontier. They are one of the oldest, most enduring genres with very recognizable plots, elements, and characters (six-guns, horses, dusty towns and trails, cowboys, Indians, etc.).')
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([Id]) VALUES (1)
INSERT [dbo].[Genres] ([Id]) VALUES (2)
INSERT [dbo].[Genres] ([Id]) VALUES (5)
INSERT [dbo].[Genres] ([Id]) VALUES (6)
INSERT [dbo].[Genres] ([Id]) VALUES (7)
INSERT [dbo].[Genres] ([Id]) VALUES (8)
INSERT [dbo].[Genres] ([Id]) VALUES (9)
INSERT [dbo].[Genres] ([Id]) VALUES (10)
INSERT [dbo].[Genres] ([Id]) VALUES (11)
INSERT [dbo].[Genres] ([Id]) VALUES (12)
INSERT [dbo].[Genres] ([Id]) VALUES (13)
SET IDENTITY_INSERT [dbo].[Genres] OFF
SET IDENTITY_INSERT [dbo].[Halls] ON 

INSERT [dbo].[Halls] ([Id], [Name], [HallPicture]) VALUES (1, N'Green', NULL)
INSERT [dbo].[Halls] ([Id], [Name], [HallPicture]) VALUES (2, N'Red', NULL)
SET IDENTITY_INSERT [dbo].[Halls] OFF
SET IDENTITY_INSERT [dbo].[Languages] ON 

INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (1, N'EN')
INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (2, N'RU')
INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (3, N'UK')
SET IDENTITY_INSERT [dbo].[Languages] OFF
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (6, 1, N'The Godfather', N'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (11, 1, N'q', N'q')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (14, 1, N'new', N'new')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (15, 1, N'new movie 2', N'new description')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (16, 1, N'moi film', N'moyo opisanie')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (17, 1, N't', N't')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (18, 1, N'm', N'm')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (19, 1, N'o', N'o')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (20, 1, N'5', N'5')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (21, 1, N'xomne', N'some')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (22, 1, N'my movie', N'my description')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (23, 1, N'some movie', N'no genre while adding')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (24, 1, N'Troy', N'An adaptation of Homer''s great epic, the film follows the assault on Troy by the united Greek forces and chronicles the fates of the men involved.')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (25, 1, N'The Great Gatsby', N'A writer and wall street trader, Nick, finds himself drawn to the past and lifestyle of his millionaire neighbor, Jay Gatsby.')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (26, 1, N'new movie', N'new description')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (27, 1, N'my new movie', N'my new desc')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (28, 1, N't', N'dfg')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (29, 1, N'smth', N'smth desc')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (30, 1, N'sd', N'ddd')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (31, 1, N'fhhj', N'dfgf')
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 9)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 10)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 11)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (11, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (11, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (14, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (15, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (15, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (16, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (16, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (17, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (17, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (19, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (24, 11)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (24, 12)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (25, 14)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (25, 15)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (26, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (26, 9)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (26, 11)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (27, 10)
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (6, 175, 1, CAST(N'1972-03-15 00:00:00.000' AS DateTime), 2, 10, N'https://www.youtube.com/embed/sY1S34973zA?rel=0', 0, NULL)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (11, 4, 1, CAST(N'2016-02-20 00:00:00.000' AS DateTime), 2, 20, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (14, 4, 1, CAST(N'2016-02-05 00:00:00.000' AS DateTime), 2, 23, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (15, 187, 1, CAST(N'2016-02-20 00:00:00.000' AS DateTime), 4, 31, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (16, 100, 1, CAST(N'2016-03-04 00:00:00.000' AS DateTime), 2, 26, N'https://www.youtube.com/embed/3Kze_J_BtxY?rel=0', 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (17, 2, 2, CAST(N'1999-10-10 00:00:00.000' AS DateTime), 4, 37, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (18, 1, 1, CAST(N'2011-01-01 00:00:00.000' AS DateTime), NULL, 39, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (19, 1, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL, 40, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (20, 5, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL, 41, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (21, 100, 1, CAST(N'2000-02-02 00:00:00.000' AS DateTime), NULL, 42, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (22, 15, NULL, CAST(N'1999-01-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (23, 30, NULL, CAST(N'1956-12-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (24, 162, 8, CAST(N'2004-05-14 00:00:00.000' AS DateTime), 10, 53, N'https://www.youtube.com/embed/Voai-4GS848', 0, NULL)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (25, 142, 1, CAST(N'2013-05-01 00:00:00.000' AS DateTime), 13, 54, N'https://www.youtube.com/embed/sN183rJltNM', 0, NULL)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (26, 4, 9, CAST(N'1900-01-01 00:00:00.000' AS DateTime), 11, 56, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (27, 140, 6, CAST(N'1999-01-01 00:00:00.000' AS DateTime), 9, NULL, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (28, 5, NULL, CAST(N'2012-12-12 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (29, 30, NULL, CAST(N'2011-12-12 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (30, 1, NULL, CAST(N'2023-01-01 00:00:00.000' AS DateTime), 2, NULL, NULL, 1, 1)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (31, 2, NULL, CAST(N'2017-01-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[Movies] OFF
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (2, 1, N'Francis Ford Coppola')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (4, 1, N'Marlon Brando')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (9, 1, N'Al Pacino')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (10, 1, N'Wolfgang Petersen')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (11, 1, N'Brad Pitt')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (12, 1, N'Eric Bana')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (13, 1, N'Baz Luhrmann')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (14, 1, N'Leonardo DiCaprio')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (15, 1, N'Tobey Maguire')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (17, 1, N'Carey Mulligan')
SET IDENTITY_INSERT [dbo].[Persons] ON 

INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (2, 43)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (4, 44)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (9, 45)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (10, 46)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (11, 47)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (12, 48)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (13, 49)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (14, 50)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (15, 51)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (17, 55)
SET IDENTITY_INSERT [dbo].[Persons] OFF
SET IDENTITY_INSERT [dbo].[Photos] ON 

INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (10, N'/uploadFiles/800fc71c-c4a7-4876-976f-159f740d4a28.jpg', N'800fc71c-c4a7-4876-976f-159f740d4a28', N'1972.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (20, N'/uploadFiles/6fd0e4c4-2a47-4580-8ffa-ceae371112f3.jpg', N'6fd0e4c4-2a47-4580-8ffa-ceae371112f3', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (23, N'/uploadFiles/461d8c17-60ec-4c64-aec2-9e5047dcfe11.jpg', N'461d8c17-60ec-4c64-aec2-9e5047dcfe11', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (26, N'/uploadFiles/c8100cc3-74fe-481e-81df-dc674b2669d4.jpg', N'c8100cc3-74fe-481e-81df-dc674b2669d4', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (31, N'/uploadFiles/f4e8cfdf-5ad2-4097-91fd-e46173f1fe04.jpg', N'f4e8cfdf-5ad2-4097-91fd-e46173f1fe04', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (37, N'/uploadFiles/f8468870-c363-40b1-90fe-20764f880a13.jpg', N'f8468870-c363-40b1-90fe-20764f880a13', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (39, N'/uploadFiles/a00fea49-df78-4102-9c5f-8e6a0d944f3e.jpg', N'a00fea49-df78-4102-9c5f-8e6a0d944f3e', N'Robert_Downey_Jr_2014_Comic_Con_(cropped).jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (40, N'/uploadFiles/9629ccd8-9eae-4f91-bb8d-d20625d376da.jpg', N'9629ccd8-9eae-4f91-bb8d-d20625d376da', N'49e23d74c5bd677f_robertdowneyjr.xxxlarge_2.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (41, N'/uploadFiles/7c5ab7c4-f3bf-4991-b2e0-2e65596d0962.jpg', N'7c5ab7c4-f3bf-4991-b2e0-2e65596d0962', N'49e23d74c5bd677f_robertdowneyjr.xxxlarge_2.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (42, N'/uploadFiles/9bb45a2b-a50b-4ed4-827d-a991508b6e30.jpg', N'9bb45a2b-a50b-4ed4-827d-a991508b6e30', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (43, N'/uploadFiles/ca68b3d1-5de6-49af-bfd1-b29d5111cd90.jpg', N'ca68b3d1-5de6-49af-bfd1-b29d5111cd90', N'Francis-Ford-Coppola.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (44, N'/uploadFiles/35a70029-35c3-46ec-8177-d35a55d273e8.jpg', N'35a70029-35c3-46ec-8177-d35a55d273e8', N'Marlon_Brando.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (45, N'/uploadFiles/22b48771-23d8-4347-8b05-3cc7de8f5209.jpg', N'22b48771-23d8-4347-8b05-3cc7de8f5209', N'220px-Al_Pacino.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (46, N'/uploadFiles/52c3e8cf-6d23-471b-8781-055648295e12.jpg', N'52c3e8cf-6d23-471b-8781-055648295e12', N'Wolfgang_Petersen.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (47, N'/uploadFiles/44b8a4f7-fda7-41b8-9c04-ba92456ea5e1.jpg', N'44b8a4f7-fda7-41b8-9c04-ba92456ea5e1', N'Brad-Pitt.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (48, N'/uploadFiles/a965d315-3c4c-41d4-9415-01f153c43565.jpg', N'a965d315-3c4c-41d4-9415-01f153c43565', N'Eric_Bana_2014_WonderCon_(cropped).jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (49, N'/uploadFiles/b325cdb1-b811-4147-a100-b100429f28ac.jpg', N'b325cdb1-b811-4147-a100-b100429f28ac', N'220px-Baz_Luhrmann.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (50, N'/uploadFiles/78778e14-b93a-493d-a254-9ae0f119158f.jpg', N'78778e14-b93a-493d-a254-9ae0f119158f', N'422817_original-jpg.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (51, N'/uploadFiles/e076eedf-4f48-46c8-b0e2-6ad8a49d09c7.jpg', N'e076eedf-4f48-46c8-b0e2-6ad8a49d09c7', N'Tobey_Maguire_2014.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (53, N'/uploadFiles/7a310bf5-a8aa-4eef-b954-daca0f2064b9.jpg', N'7a310bf5-a8aa-4eef-b954-daca0f2064b9', N'defa55086d1d29228b0290b71a07486d.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (54, N'/uploadFiles/453cb555-77ee-4275-a772-313d76c6c57a.jpg', N'453cb555-77ee-4275-a772-313d76c6c57a', N'a-great-gatsby.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (55, N'/uploadFiles/72535d5c-efab-403d-a90e-f2479cc860bc.jpg', N'72535d5c-efab-403d-a90e-f2479cc860bc', N'carey-mulligan-435.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (56, N'/uploadFiles/c04eb1c4-583f-4d9a-84bd-13ee6c75d817.jpg', N'c04eb1c4-583f-4d9a-84bd-13ee6c75d817', N'images.jpg')
SET IDENTITY_INSERT [dbo].[Photos] OFF
SET IDENTITY_INSERT [dbo].[Profiles] ON 

INSERT [dbo].[Profiles] ([Id], [Phone], [Email], [IsAdmin], [IsBlocked], [Name], [Surname], [ImageData]) VALUES (1, N'8888888882', N'2artemmazur94@gmail.com', 1, 0, N'Artem', N'Mazur', 0xFFD8FFE1001845786966000049492A00080000000000000000000000FFEC00114475636B79000100040000003C0000FFE10369687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F003C3F787061636B657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B633964223F3E203C783A786D706D65746120786D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F726520352E302D633036302036312E3133343737372C20323031302F30322F31322D31373A33323A30302020202020202020223E203C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E7323223E203C7264663A4465736372697074696F6E207264663A61626F75743D222220786D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F2220786D6C6E733A73745265663D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F73547970652F5265736F75726365526566232220786D6C6E733A786D703D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220786D704D4D3A4F726967696E616C446F63756D656E7449443D22757569643A37433337333138323838303531314445413338313932423341363944463344332220786D704D4D3A446F63756D656E7449443D22786D702E6469643A44414635443042434146433631314446393945344544433433453734324345382220786D704D4D3A496E7374616E636549443D22786D702E6969643A44414635443042424146433631314446393945344544433433453734324345382220786D703A43726561746F72546F6F6C3D2241646F62652050686F746F73686F7020435334204D6163696E746F7368223E203C786D704D4D3A4465726976656446726F6D2073745265663A696E7374616E636549443D22786D702E6969643A4438373530323544323032313131363841334331423338363837434332323835222073745265663A646F63756D656E7449443D22757569643A3743333733313832383830353131444541333831393242334136394446334433222F3E203C2F7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C2F783A786D706D6574613E203C3F787061636B657420656E643D2272223F3EFFEE000E41646F62650064C000000001FFDB0084000604040405040605050609060506090B080606080B0C0A0A0B0A0A0C100C0C0C0C0C0C100C0E0F100F0E0C1313141413131C1B1B1B1C1F1F1F1F1F1F1F1F1F1F010707070D0C0D181010181A1511151A1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1FFFC00011080145010403011100021101031101FFC400850000010501010100000000000000000000050102030406000708010100000000000000000000000000000000100001030302030505050506050305010001110203002104311241510561712213068191321407A1B1C14215F0D1522333E1F1627282164324342517B25326A26373834408110100000000000000000000000000000000FFDA000C03010002110311003F00DB21E6A940ACBF70FB2817712081412C41C0AAFB2802C81A72A5375323947B6808C5B8C7702E14DA81B9206D01050561F0B7B0DC73A079DDC3DF411C8017ADC12AAA283A12BFE5B2505824EC288868017564697A9B696BA93418C0F964EAD930E3BDB09746D0E9480E401E7EFA0D747D0F37A844C3D5739B938ED2D631BE435AEDAD08D47AEE5EDA01DD7F0D9D0190CECC8964C391E7CD32147345906E074EFA091FF54FD1DD29A22932DD3CBB7C4D81A6400A0B17582D00FC9FADFE9773C362C7C991AEB39DB5AD4F6137A0BFD33EA57A533DC19F34719F701B3B4B015D10DC506C7A5E5636442C9209192B35DCC70758F750130A87D94114BA225FB682A4A4682C4A1BF2A074446D2389B28A0B517C20F31C6807F5E6A74ACC2A0244F5B7F84D077A7DADFD2F053842C03DD40718801E7410CFB3768A8541A0A39843227ED1E142B400A3C764D9B146F3B44643C0088E714B13CA835C268E08591E1B03370779CD1E26EDBD81EFA0CFFC9C1F35BF71F375DBF9555282E2855A0516B8EE140AD3AA7BE827853701AF1A006D7033B892BE3728FF005501360262D34E3EDA06CE0796D2E0838EB415D0060BAF2A07684FEDAD0444AC8D00AAEB40AC0428096D128260E262249B5001EA4FF14A84870D08D2F41858B260C2EAD999724AD6C30B5BB8B871739D7A07FA9BEB5B190458BD1602F7C2CBE54A89BB9060170283CCFAD7A9FAEF5A9DD3F52CB74A5DFF000D5183B0345A80617ABCB45FF0141CD2E0F20104F04D2815F24AC25BA11C415A0BFD2FD4BD6BA64ED97032A581E2E76145EF1A1A0F44F4DFD78EAD048D8BADC4DCA82DBA58C6C9401DD6341EAFD03D63D03D458FE6F4CC8DEF6B773E07F86568ED6D05C91C7437274E1412E38F08542A6E6F41618401CCF0A0A9EA0C4649E9ECF94CA06D81E5CC0112D6B9A04F4FB53A6E26E08444C6FD9406D9A905395055C9680A555C341A6B403B35CE38FB631E1252FDFAD00E6CA5D93230351CDF036C9623B680F6346E6C001F16D6D89BD870A015B7FEE5BD6FAA70D682D8DA9D941C2DDC681C2D6E5AF2A09E1F8F99A00311FE61714F89D71D8680A37FA2B70A1428EDA06CE5A803949EEE341010084758711408E706B5C375E822681E68D4926C4504AD6DDC469C12815EE0D891168323EADEB785D1B0E6932E6226DAB1401A373DEEF846B617D683C2FAD75ACEEA390F7BC86316D1B6C00171DF403839C11575BD035FDDEDE540E64614711C791A0730381F00B8ECFDF408439C85CB7BEB7A047B485734953A2F1A06A166AED6E0D05AC0EAB9B83911E562CEF832233E09633B48F7507AFF00A27EB1B72CC7D3FD4243263E1873DA11AE3A0F3070EF141EAD8EEDD08702A1DF0B9751CC50588CB80D17B4D00DF51B1EFE859EE4F088DC5C9EEBD05DE8D181838AB77794CFBA80B35368078D056CA432105B602D402BA882714B1A40B20ECA01F14A5F2BCC8747351DCD1A025069232D10A27E5B9A005B3FEE1B6FBB55F6E9DD417BF3507016D681CDB1B95E341343A870BF6D001840045D2E49EE2680A33FA42CE25281AF69F0AAA134113D4800E8BA9140C72069ED37A08210AE5E3CD787650480B48E4A5138AD00AF567A9B13D3FD2E4CBC804C855B0443573D2C283E7EF51FA83A875BEA32E6E53CB9EFD1BF95A1111A380A0121A0E9DDDB40819AA0BD04CC883DA36A271239D04F8B8524EF11C6C2405426808627A772F7B778686BFF00313CA82577A71DE6A4AF058A40017F0A089FE9E735C4976D1C1D72A2829CFD11EC72C68E04F8781A081DD3266F0B05257DE81282B80F6381D50043A507ADFD29FA872433C5D07A9C9BA09486614C6E58F360C24FE5341ED22C16E7B68047AA32447D0B39802974443F822E9A71A02BD25A1B8706A823658FF9450136A16837A0A595A901C6D6A015D45CD10917253F60B403F053CE2DB239DA735E541A60BB0800DB85067FC7FABEC4F122FB37501020D934D2F40E006BFB0A070ECD28258F43A581FBA833F8E14826CBA50156AED084A22D07481A1A0AA27DB6A08C68179DC50432B92C06ABDD4114680017F650383831AE7BC80C6AB9CE3A0035A0F04FA87EAE3EA0EB67CA0987884B318FF10E2E3EDA0CAB033C45E482961C492682C63E149283E5B0A25F822505FC6E8B19717CCE240B6C50280943878915A28C006DE242682C3311CE76E8EC1B6416FBA82663676B8F668355A0B5116007730877F11BAD055CD64A5A2C761E3403278BC3A95A081790ECF6D038438D280D91A09D0A5B4A08E7E8B26339991864F84EE0850822E08E341EFDF4FBAFC9EA1F4BE3E448F03271C7939AE3F95EDD11BC4B8504DEAC880F4FE506BB6B5A017B9D72E2E2001DA4D01FE98171A22742C6803D8280878762277D050CA45453E24012806F5123C92D22DCBBA82A74B23CF5B217201DB41A00518425C6BC28007F33F5A5E1B57D8B40401520F02B40F046897140AD55E3D8282660218FE684FD9419FC42AC6EA97A028D27CB6A0E0174A0499C4968D001A50464129DEBC3950579080081AA14D6813739AC5501468874A0CCFD47EAD274FF00486516BC324C82208D353BF5FB283C0C355C01F17202D7EFA021D370A39C9DE4F813C360280C9632156C7C751411891CE3AA29BDAF41771446D70333B685E4B6E69405B0A699ED0CC4C332389BBF536D12D40719E9FEBD27F3061B6F70E28BFB0A07CDD23AA490B587098CD82E402A7B6D403B37A6E736070F2ADC88B8ED140266E9B95B1DBE0467F15003C9C3998A4F3E1A8A0AEC3B4A1FEDA0358E416053C0120EB404BD03EA3C9E83EA99305A8DC1EA8E6B124366C84F81FEF28683D5FD505F8FE9F9E0710F7388324845CB8BC68795068BA78FF966145568D7BA82E84D82DAF04A01B96438EA6E52D6D280775070318055550FB682BF4963BCE500068255385D0501FB08D38F05E5419BDEEFD77CB51E66CDC97D375015F0F0140A178E8795039A2FAF7504A4910CA4E818EEFD2801628688E3D5CEE4744A0244911828DE1FB1A06CBE220E9DDDB40C7346E681C282B4B675C29768941D335ED0D0137259683CBBEB3E62BBA760823C21F3B80EFDA3F1A0F33631E413C0A58D89EEA03D83018606D86E2140FDF40E9654502E7F1A08D90BDC7739C422AF7D012C3F978DAD25AE7BCD8F2FB68361D1B3739807CB62343555BBB5BF05E541A9C2CCF53F961DB636B19A37FBF54A09DD91D6769778547E53A1A0079B36439C4BBC2E695704A00B9D34A850EE68B0B1A0CD67BC80742A1178AD003793BC5BB680974F90BAC75BA1A0EEB78EE10B666BB6C919DCD7F11EDA0F558BD42DEB5E87C3C9701E73DAC6CA02121EC7B5AF7BD3453F0D07A06082206EE21368FB8505B3F01437E0B40372B799006B86DE3402BA9B9858D687713A73A04E8E0688A7553DFC680DBBE02501A0CBEF3FEE0542BB1138FC5406CA2D070005B971A07B4DF91A07C84FCB4DD8C77DC6801E383B5AA0DC0A026090C0D40840E540C989516FEEA08E5F89A808ECA080217A71A049CACDB54237873A0F0EFA93952667ABB2626DD98FB6089A74040D07B4D006C6C2936012B7E12802F0EE1AD016D8D3A5AC817F1140C1002E57D82D8D04AC882028AE2554D05CC6F0C81CEF11FCA9A0A0D074ECECA678618C29215CED13D941A0C7CDEB0406B4B141456A93EFA0BD14F945ED131B9E1A50439F8A5CD54241297A0039D8EE6A0682EB2122C68337D47A6CBA86F893DB401E5C1983976F695A0B188C7B480E6D872EDA0B7998CC9A27C4E162D404D0683E9E48E6FA33AAE33FC220CE8909E4E2DB7BC507B4E1922162FF00084A099CEDCCF0141CCD00CC8DDE706836174ECA013D4880F6B55105FDB412F486FF002F75C9514069CDFE5AD978D065378FD7150F244E1A2D01D1C6C940E6A00A75D02E9AD02B6FA5A81F28FF00949CEAB1BADECA00B0208DAD1F0900A9B22501201A436E5282391A43947DB4114A5D60BCD6822008702BDFECA0864241748002E009DC7B2E1683E75EA72CD93D572F3253B6574CE794BA38B8D05FE9D8B31689267173D2F7B0A020D0DD75737DD4081AE99D6B93DBC076502CBD4307080F3DE3713668B900F3140D87AD3DCE127903C8BF96E25D74E7B41BADA8347D1BD54F6B621174D7995C50F9A431A1A9F11A0D761756CE9182776346C06CE637876D0178D91CFE5C9B401AB76AA1F6D024AD32BBCA6025A352135D68076461A4A4B9880283DFCE8004D2C5219D8E6001A5C1AB63E1FC28323D4FD418503F6BA0700540936F84EDB14A00AEF5518E525B10D9AEE3A11ECA02381EA5C1EA0E6449E54FA29F85C134A0D0FA3B293F57C5546493E33B9850683DDA14F2C03AA0B0EEA07BD00B69402E772E428704BFBA80467A39E0AA20D46B6A0B7D24781ADDA7505A7BC50179006C46DC3EDA0C779B27FB8D6FB3CBDFB138E941A4DD61D941DDA681CD04F68A0925FF00A498FF0081DF750068C80C0D23C48084E5417DAE08DB154B50248771BAA14B5041229700A142D042FF000BC3950A215FDD4114A0BA39838297308BE9F0945A0F9D445237224748F6C65A4E9752BA501BC06938EC711B1CFD12E9CA826F26DB07889F6276D0365C818CC3142D2FCA90231A971DB4177A17A4269E512E435B24A483248E2480BCB5D28368EF4774463639430B258D6F1B8804F1502D40E189818CC2D68F091B5C480AE5E652F412C32E3B623146EDAD75C1078FB6809606608C35BB94017E54165F951B0EE0CDBBB914BD00FCEEA6D734B41469041A0C765CB8D1BA56BA456BCF1FE1D4FBE8047CA63643EED2E436DC11A8BA0A0B4DF4CF44D8D7BD8D73D755B7725005EADE978635C8C3292C65431A1015A0B1E8BCA907509637D9F2491B8B79969A0FA37026DF134AAD8504F2A9052FD9402A6DC72111AD621B71A0119E4991C5A96041A0BDD25AE11C5E2BEE5212FA250159BC3095A0C7A1FF0074AAFF002FCAD56CB41A30E69D386BEDA0508B40E0508E54124CBF2731E1E5BBEEA011093E483FC67EEA0B8D202702962681AF75F976FB6818E6ABBB36DE820730B9ED235E24F6D045244E90C8C20A3DBB4B814D45A83E7BEA586EC6CF931A461324733D8178B5AE372280C74805D0154505001C050106C0092494E7412F43E92D766CB9929DCE2488D492805A834C7AAC3880004300D6803753F5CC10C8F884AC85E0286BD4B9E7800071EFA0CF45EB4CACECD7E3C5338C6D277485A036DC4AA2501AC7932E5607AEE50A1CCB020F114047A7F50CA8650D955C399A0D43C19304CBC1168303D5FAB643A73063D80284DD6823C4E8B91302E99FE5B1A37CF932290C6F60E24D009EBDD40E2C9938BD2FA74F2CF88D64F3E4E507A88D42BBCB6A0632E3E2E740270727D5797D372BAA63421D878B20F9A309F1460B75DA7876D014E8FD746586B5D20713E114098F13B1FD650152237B4BC3468787DF41EFBE9ACD1363343B540BDF407A54F2CA69401DEE3E6B82A340E6BC74A0119E52490D934B9A031D35A598D138D94924FDD40426FE9381D4DC7B68319E1FF76A2F8366D4F66941A02BCEFC281E1CE55E4528246BF8F0E06825C8FF00A0C80A3E03F6D00A62F94CB01C0A505C6EA15D73C6818F2AE3C50DA81AEDDB93B28217ED06DA9D68228DC1D21286E973C80A0F2DFA9FD18E3F5E8FA842764796C6822E9BC58FBE802F4205C656B92CEDBBB85B9501B2CF2DA3B6C4D02C192F8C96801BC001A25007EA27A9E775387030FC39133832391C51B1826EF24DA80BFD46FA6B8FD13A4F4ACDC3C6933446E27AB6505323DC50AF1DADD5395041F4A3A21EA7EB59B3F1304E3741899209F1E7591BE5BDA9B1CE7001D7BD06A327A4E074AEA9347853473F4F0F1B71C157441D721A428701F6504DD6E3C13931B31A2D8D6B15F755274A0B1166EDC174202D9128313343E5F52DEF0ACDCAEEC1C4D06C7A6A6675383372318CDD2F11E0C18B1398D8DC5A1048E5BB9DBB81B5005FAA3E9DC1EB19FF00AAE0CF2F4FCCC88F6E742E697C6E637897C45C38684500FE8F9DE99F4E7A726E958323FA9F52CC76FC93B0B6305136F8AE401419FC6F4C08330E4C71ECF3097A36CD6971540DE54047AAC51E1E474DCD9858BCC0E29C5F767DB41E99E90CD2BB0BED6048EEA0DBB9C0C25CBC280390449212805894A0179CC697BD10346D41DF40770584431803E1556D05A9806C7E2E084F21418D56FF00BB375B6AA767F4D6834A5AB721072A050DD09BAE846B40E6DC2917A0932CFF00DBB22DF912806B0344318E3F850596016B85A0638124700BAD071F8BB0EB4159C2EE5BDE8327EA8F52E574F9DB8D8F332090A12E91154F06EEB5065FD55D67A9F50C3C58F2F63CC4E73D990C6A3882111C34A013D031A58FCC2F3675C0283EEA03136EF39A1141B77505A8F05B24AD1C3F3505A93D3F0644BBD9D9DE08E541A0E8F0F5EC76083E726763B94797B9422582396D417337A5E5490EC7BB6C46FB4B8A1B27C0DDADFB282B331D9818EE3081BB40506B402CC6D05D2BCAB8AA9A056B9A1A5C4A84A00F9A231239C459C0FB283BD35D60E0E63F19C0BB1A42AE6F23FC42834B9D898B951EE00398E5522CE43DDF8D06767E8D8F03CB98D40B6E0795023630C09C57D940CF50E245374B8DD259B1CD1BC7639535F6D0683D1C5C646DB5361C2D6A0F417126120DDA75A018493BC223070E26806E56F748F5084BD809EE341A0C66BC46C0802F2BDE825C84F2DCA1568317E73FFDD09B7F97E7F97ECF975A0D55FDF41CD4DD6374D7FB281ED5E3A1D1281F9A53A7CFCF68B7B4500B637F96C3C48BA5ED41640E4468BA0A047214E25795034B51E42D042E05A49E2BA70A0C3FACBA2E1F52C894E544D9626AA822E0B235B1D78D062DB8F3E0E13586474B8251A19295731C4D834F114043A743B6C070F7505D2C3BC73E5404F05BB8E9C87BA8341D37164738580E5CA80FC11470A171B81C282BCA5D95216B416C6D372680575E2D6011B6C8113F1A0CFE4CE4BD9137E27024F70A058DB92E2D8DA091FC5411E774BCA2D7392FFBE800B5B263CCC6B9A7735CAD7730BA5069F0E67ECDCD3E12853BE81728EF700D06E6E7B28053B277B9EC0D20B0A762D00FF54E76CF4B649FCD118DC0F7482835DE831E6C304A6DB9A08F68141E8330031CDCDF54A0172B097B8E9C8F6D00B2E71C802E865174B5A834D8ED0D6B49B6EB95BD049948E84A9B731634184DF27EBDE670FD47CB5ECF97A0D81F86D6A0500EDB1B9D281CD4171FDF40BD45BFF6C9BB40D3BC500D6598C4544E3AEB41680280A2A8ECA0691E2052C3BA81AE284A0BA71A089CD37E37F75065BD551F971CD202A1EDB1EC734B7F0A012CE858F2E345E7B7CC6B9AA87828D4500BF224C590B4A80D03693C5A743F650597B0860901B382FB682E74F7B40DC48DA74341AEE8F3B365D0F02BC280C7CBC320DCC6A8E40A7F750749B2266D680D1C28339EA881F062BA770DD24882307B680174DE9B91349E6CE493A03C86B41A8E8D91D1F18B9F95019CA230028011CE829F56EA98B248FF002C358DFE11A506732628E66BA560050AA9A0BB144D18D1C8C0AC3A273A08E49DC1C5B7E5FBE805E61424B01F19B8B50657D6B9059E9C9D84DE69228DA071F12FE141E85E82CD8841042480E6B1A0703A0D683D16797763100AF67B6806EC217F2DEC154EB403834BB398746EF50782D0699A020DC3C29E13DB40B901622AE4EDA0C3AB3E6753B7F58DBBB8A79288B41AF2A500FB6F40B7E1A70A05684402C96341DD48A74D979787EF1403A376F6B1C1AE0C4DAA42024725A0B7B4ADD741C681BF771A0690373A82372808745A009EABC6F98C2F0A0DCAD1F785F6B682B617A83A7E2E3E36E83CD3E518DE0354FC2850731419093ABBF3607367C77636462BBCB0A2CF8D7C2E06826C67F9988E6950971EFA0740EDAE0D68EF5D28343D2F201795722A041C6835506537604B134136306CD92F2FFF0084035BED0A68007AEE6646EC07BCFF00243DC1EE170086F8450664F55F54666F87A0E04031A2F0BFA86749E5C6BC98C1E37FBA82069F5CB637B323A7473001464623D59ED6BBC42833FD50FAC618560C20D7484AE44AE1B07FA7E229410C6FEA3D330FE6B27D4116638DE4E9E2242A7831C3F7506A3D1D9B9F95D2A6933E238E2598BB1639023C47B40523829A0B3945AAEE6795008C992C40E1634197F57163A3C0C79012C93237392E9B45BEFA03FE92CD31F526B5C2E00FB4D07AFB66DD88D21A4E86DCE82073CB95C011B5517F75051C068767B4A7C25C483EFA0D346402D46E838DEE681725BBA2B845E3A5060F778BCDF2CAFEB9B578226D5F7D06D381E7CE8102284140E04A9B91410F597B63E932B9F70ADB712542500DC799D902295A2401DE16C4F45DC78045A0226373660C791B8057341500F25A0671370BDF40DB2B81BF75023434B8037056DDB410F54C76CD8B2C4501D438F04D34A0C6331B665B8B5BB246AEE1C01E245055EA989264C39392D07740CDC48B0241BD00BE99317AB40058BE0F7504D13A36CE5A7537A0338728686A04A03F87928C17576A94053032618DAF7C850F2B2760A015D732F0B2B19F89346266BCA90740798238D06561C48F0C96C7248E6EBB1CE5681407BA6F52FE46D1E1768E3D9414BD42F964C5297B6A6F4190C59A26CAAE037B7E1701717E74055D9B2B9A81CA7BE8164CB73F69704289EDA0A3391BD45C937A0CD7A9A0CC7E743344C74ECC484CB2C6DD76EEBBBD9413FA5730CBD4639D87F94F4008D15743DA283DC706471C0079007BD681267B830BC946952471ECA0A9D31E1B9AF91E0B83038A68A6D41A7542072454E140992D2E8C107B8D060AFF0023BFF2FEB69B7FFDA8AB41B7FBC50357DA7950398964F71A0A7EA5DDFA1646D0093B7C2742A5385009E87839B891B67CA95C7236F96C01D66B3950140259A50C894075820F113EDA0227D3EF107826DB917207E5EEE7403164648E832186399B62381EE3C681F1A79817FBA81D246763D4845245079DFAE3AD0E839032A4639F0B95AE2CD47B2831BD6FEAEE31E932E174C85C65986D748F1B5A17B353404BA1B97171A60A4CB1B4DBFC414D05BCA6480AB02B8154F6E9404A1C8DF1B069CCD01287291A80DC71A0B6ECF2E60635D73ECE1414E49DAD25CE234D280364656465CFE562B3CC428F7FE51DF407B0FD25953634729CFF002657FC2D02C08E6414A0A3D4FD39D571E4114F9E3218EBED61B7E1419CCBE8D3C277C4F1BDDF90D0561933B260D7B48FE2A0BF1C9E6B3703A5044BB9C835D1681DD0246C9EABCD8ECE6C58C18F04E82CBF7D0332BD353F4DEBA7A974EC7DFD2E4DA737163558DDC6563790E341EA1D365FF92601E26B9836B9A781E22827983844D79B784F87F0A05F4EE38C8CC99C5C58F6B4794DFF0052A9EC1406B1BA745890B237C921DA55A3C3B9C49DC5C495D5C78503F3034C650A1E0754A0C4DBF425DA53F55DCB645F9AA0D711709EFA0420AD02B05F4A087AC063BA63C3EEDDCDDCBDEB7F750078279A67FF0031001FD38C5D19FBCD06ABA2E340D8BCFF008E77047388236A7E50B40453FBE828F54E9ADCE80B43BCA9DB78A601483C8F31419EC4797BCC3334B7222716CCC3C08D08EC34169CD8DD190846E286FC8F0A0C17D53E9ADCAE9522355C1AE213B283E72902388E56A0F5CF4B4CE97D3FD3DED42910694FF092280BE63ACD40A5DFB5A818CC8688EC086E8BDDC682D4738F2F5B9161413634FF009B7152107B6D40DCE28D499FB75B7669C2822C7CA73E1F97C466C8789FCC4F15340F7753CC663EC57BE369F16C04A1F6505793AB666438371A39A62CE2E6B835789522807BBF507973E68DCD0C5D8DDAE529C53977D0508E5CD9F29EDF979031A1647ED200F69A0B189380F73772922EB6BD04EC2D8DCE92428C00B9C7800029A0C9F43F5141879F999D90D924F9925046509F16E0093C10507A9FA4BAF63F5381D9F047235AD0E6796EE0E002E9AEB4073A330C0D7464918EA3633442478BD9404F2896C24AA781072D75A0674BCC931E5872630D732489AD9DC9E101CF517E741A3C98F2E4EACD31ABA1735AEE6E703FFA40A0ECB6BDF16E42C571DA5DC434A2F75061BC1FED8DFBCA7EA3B93B3E6D1283657A0692ABFB2502B768239EB415FAC86BFA7398E28D2E6EE2792AD047D1F1E182139B3787714671B7BA80E439F88D25C256B5A4DDA8554F1D282D48F70690DB38D813A5E819BB6B034BAEB7B8A019D670E3959F331A372A31678FCCDD36BA806445AF89A4B0B7794705E47FB2829FA8BA78CAC095880EE6B82270341F2CFA8BA6C9D3FAACF8EF09B5C53BA836DE81CC2EF4FED26F8F2BD9DC0A38501EC8CC6B63602547E52791A08864B2C8493A1341721C96BF7B0820B74EEA0B11BD004284F1EEA0B2CE9DD37A9B9AF9A47B656F85D1176D53FC439D017C1E8B8B8CC2F862B0452E3BB5EFA0250748C874724AC8498E301F2A68D06C09A09A3E992CB8D24AD6AC7111BBB8D007CCC764723645422C40E54194EADD51C269316290B9C423D0D83791EFA013869F3252F6414157D59D4BE5BA5BA3628972088801A81AB8DBB2D4190890469DB41ED3E83C67E27A4E0716EDF980E78089727E2275B8A0D574E203BC5F003A272E341673A40C80F98E0C61F0971E0D3AAF6D03BD3EE8E0CB9316073726191A8A2F1B5BFC45F70D34077A8F576751C93D2FA31272650239B2C14646C1A8047E641413E53C4622C71B9E62606B8F0686A00B4186DFFF00C3F7593E6976F14F9BA0D806DBB281AEBE9AD0285DDADF80A08F3E32EC7634E8646D8FE3417998F14B0089CD5628200B69401E4686C9335480D710175A03D94D7CB80E8D83739F1041C550141419E747B7734D9E0F1056DD940664639BD35AD7104863413DAA2EB4039ACDCD47042BA9D480681D33D823DAE0A5C1138A50784FD60F4F164BF3F130A32CE70A005F4FE0963C5CA32121936D746DE3E1504FB5680A66CEE895AFD2FB5469D941561CC7B51A1003C4EA940531B3B6FC4744A0211E4DF54ECE540F398C0A1FE1234340F6FAA73B001FE5FCD45AB4290EA070FAB4FC6043FA5E4BAC8402DB8F7D0549BEAF75994BA3C1E8B2A3AE92BB681DA505005CBF537AB7A8484CE63C38CD8B62F1393BCD0576E4BA16962AADDEF25493DF40FC7CC491CF5B32EA68333D7BAA9CC06427F971B808C0E039FB6834DF4D70707AA654EC788E431B5AF8DB20054ADC069D683DBB1B06676288228C4B904964718218C41DBC2809F4FF004D7546BA5F3DAD67E6690F0412966D85BBE81F91D072F6B7E61D132E4963497145D05829A015858D14C258993FCAC6E738BA0162584EA791B5E80974CC2CB804716249E5E2EE0D21A55E4AA9D1777BE80ECB8C5CC7C700030E32E32CAF75CCB6B6E3C02D061BCBFF00E11F1FFC6D52DFF50AB41B39B1246025BE26F66A282AD8DB437BD02B4A71E4B40CCD2040CFFF0023682FC4E2D8C387DB7A04970F126709261C2E59655E1A505D2D02EE52C4DA00D00E140373FA7BB2272F8886B481BD75B72F6503F38B5B86468DF08278D92D40258E649182D712D26C4D93DF40C3B94079EE53418CF5F604791D1F2F7BC111B4BDCBC85ED41E61D324106431A3C10B9BB4B470B5968094F132781C0A9E4EA0CECCE97127D92DC1D1DC2D41660CADE837DD14723406708C8E010E9AA505D762492BAF707416A073301EA18FB70DDC8D019C4C3E9B8CC0E963F31E78EB7A01FD726C531BFC88B692351AD0008226CAC2D6A9429745A0872F0C3232E79441A25065BAAF55735A71A375DDF111AA500F38F23FA6CB27E5047DF405FA16FC48A3923798E550E6C82C5BDC683DEFE96F5897A9C58FE74A1F9104A5B2AEA439A5081DBC683D5A302E5556802F5DC319F85958EF7EC1B577A5C6D2A13DD4195F4C4192EF98C286489EF8FF0098F01A4170174DDCCF1A0D2450E67F45CC7E3E3393CE0C25C5C4F2705DB4173A84F0B3A7186748A28CB7646C280F252405EEA0C4ABBFF1FEBFCC4DDC3FF7B7506E71F2DAF46E9DF4093C103DA5E51845CBB41EDA01C0A5043D45C3E5D9A217B6C74A0238803E2692369D535A082674B1F506431B888C2103876934051C5DE5EA9CC505499D1B1BA969E601D6822306265CA209DBE735A37A151E20516828E567FA4BA6B9ECC8CAC5C773ACF6BE405C9C91491418AF50FD4EF49F4C6490F43C76E7E53C23A63B844D4EFF0013BD941E65D4FD77D773A0971267451E3CE55EC8A302CBA2DCD00C73DDB43DA7C6D43C741C2F40770656C8C0E214102825EA1D163CD84F846E02CEE3418ACA872BA74C3CC04C2D36900B8EFA033D1BABC6083BB5E4556835F879B03C34B08DDA2D8DA81D979918780D04EF50E776F6D0559339A236DC6A7554A01F9D9DBA3DACF8A4242AAA0A08F1E56E3441CF70053B168331EA2F52EF26288A916FEDA0CF74FC49F3F31AC6AB8B8F89D41ADEA7831E2F487C005C314A6AA2F4157144419183F0B82A8A0F4DFA3DD463C2EA1D48BA46B1DF2A1F1EF1F984813EC2683DAFA375CC5CDC3323A463656BB6B9A0F1E1AF31411F502D185992259AD7151C8368305E8EEAB2B65C9C28A395D3BE792679601F0310300246BE2E341BC6759C41D3D8F2D763B58435E677B03C9E2034124D0249E54B09CCCA8437C09009078C3AFE23C05062FC977FE3DF806DF97DDBEE8BB9556836AC7C3202F66D22C49E2A2801FAABA8E4797074BC724646490E91C350C074A0B58CC745032224B8B0005C6FF6D00FEB1D73A463C4D8F233216B81BB4BC12139814159FF0052FD2384C206519C816F258E77DA505007CBFAD3D2D80FCAE04AE785F14AE6B553B83A82077D75C0DA3674D787BB8196D7EE6D00BCBFAED9A416C3D3616720E73DE9FF00A6832FD73EAB7AAFA98730E40C589E363998E3CBF0F22EF8BEDA0C8BB2657B94B893CC953DF40AEDC1A000AF76ABDF40D9619191973ACFD4269416E23E646A6F6F13BF72D012E8F36C788DC5034FECB41A7C6735E1004E2795047D4BA463E531CC7B478BE2046B4182EAFE97CEC299D374F25CC054C3C53B2807E1FAA32B164DAF06378B107850171EB881D1A4ABBCDB737B78D04337AB71C03B4975B55E3A50533EAC6314B584BB9500DCEF5166E4D9763510D00F8209B2260C8C17C8E3DE683D23D3FE9C6F4CC2124C3FE6240A7DBC281BD62232E3C8D165047D94023121F2B1DAD75CC62E48E541B2FA4F990657A832F19B206E5B981F0C6A01731AA5C1AB6F6507AC27CA63C8F18CF1E273E40D00B9CF40A75BA0A09F1FAB79FD024C4646F74D3B5D1B7C2E251ED3F15054FA798F3C3859B91344E832722649637020A44D0D0345D54D0681B1F4E6651CBF9527249BCA6324A8E22DAD02755EA108C0927712039A6CFB3BBCB68017CB4BFEDCF9CD9FF69FD3D766EB2F95FF00B6BFC57A0D187458B8CF91C4EC602E79255C9AFF0065079F65FACBA4F4ECD9F3F39DE766C84F918CD20968D2FCA8311EA2FA8DD6FAA38C70BFE571D53C961427FCC45CD064E5CA91DB8BA42F26FDE4D042669740FF000EA02E940C92690A5F9EBAD0465CE3A145E7EFA063DCE1A9B9E3A9A066E21C420B14D79D02C77758211416B19A5F292BE1683EC340ECE0035C0108020E2B40DE9D297C41AA6DAF154E7417209BC999B25F6AF881FDB5A0D760B83981E0A820104501585CD7D9F7B785C3514157370D46E2039A7470E14003A8FA6FA6F516913C23CDBED7B103BDA683319BF4E72184BB172039BFC2F171ED140266F4775C8BFE1078FE26951415A3F4DF5B91E5ADC47A8ECB5017E9FF004E7D4192F6F9AC18F11D5CF341B5E87E8EE9DD201907F3A7010BDDF8504FD57A86262B52672C86EC8C6A7D94195CBCE9B264DCE0191AA35A2FFB1A011D433C35BE4C7627522824E87E760B8F508E67C396DBC5230A3989C41A0DD746FAC3EA3C50C8BA806F5085543DFE192FC770B14ED141E8FE97FA83E91EA2D8D9148D832434AC53B431C5C79389DAEF7D06CF0A5679729633633C2486B8924BB885274A0BCC972268B6C01B196045706924F3A083A889D9D32712B5B2CA62785DA06DF09B20A0C67CCE7FFE3EDBB5CBF2DB76EDE3E5F3EFA017F533D7B161C3FA574F903B224B4D2B4A860EC2283C76498BE42E738B9C4971792AAA6822924721BAEBE2A087796FEFA0E7238DAF6D1B6B5026E6D9ABF6292BAD034D892D3A8E3CA818B6BF3B72340C51B8DB8EB41230B5095FDF41730C011171FCC482BA72A06668561E251003AD051C195D1CEE8F813A6940508F1376DCF3075A029D2BAC0C7FE5C8BE4AA13FC27F7506B71266C8D05843D8E167036A0B2F610DF0DC716E9415A485AE0A421E47F0A085D8AD20824272DC681A31A3164DDD8E361ECA0B70421A2E8DE42D413E565E362C264C991B0C634DC6E50294A0C7F54F563E50E8F01A628CFF00C670F111D8DE14006425CF2F937389BB9EE55F6D00EEA39ED0101BAEB403B1A27CAFDF741406240C6E13DC2C6CD68EF3410376A6E360380A0702EDB6B3485141A8F4C7D45F53F400D8E09FE631426EC69FC6CFF49F89BEC341EBBE95FAD1E9DEA4E8B1B39BFA5E4BBE22F3BA224FFF007387B68359D6BAA327E9797F29FCD8FC890F9AD2AD236142D228323F2BD73FD81F2FF2E13E5FFADBC2FF004F5F7F6507887509E49242F994B89B926F4155AB729C6D7E141C7E1D2DDBC681AE40EE43E203803A502124120853A76502075C06AB48A0E7A5EC8789A08884420227DAB409B4B9C8A97B2502B80632DC753AD0138231E43344D57BE8239C3F47041F6D051108F343B4BDB9D05A932F0E16EDC9998C7A290A147B05054775EE94D711E639E386D69217ECA0B7D2FD47D4039ADE9D14B239C53610AD71E00340268375D37D463CDF92EA90C9819CC037C790C2C6DC28454228089D9202E8DED78E6C7070A081F340C244923185BA82E0D2BEFA0AB99D77A66226E943DC746448F70F75008CAF59E5386CC185B083632C88E7A730DD05067E79B2B26532644AE9A43ABDE49D7EEA063A56B19E2360083A1141472FA912AD67109ECEEA0A1062BF2250483CAF405F1B1191789C74B11C52819D49F1B658E06587F51FDC2C282346BD4127B387BE8116D75ECA0E04D869CBF0A050E208BAFF00113406BA57ABFAE74B865C6C5CA7B31266EC9B1D5585AE087C2742472A0F4DFF00CDFD3BFDA7F27FA6C9FA8F97E4ECF307CBECDBB77A6BFE9FB683C9B2E51B9500E4354A081A017121CA4D9281E8A4006F7DB40AE2012B7B5DBFB76D047CB991EDA0568690553770A0E540A48F0F0A085C795D0A1340E2C69683A937245074A518740BA000D0359D60C0C2C9316503F8DA8ED3B281B375A748D0D87166948D0B86D4ECE340326775ACA25A4794CFE116FB75A09B17A243B099564916F7297A0B8CE9F8CC0B1C4D51A14A0DA7D353911752C87E131B26782D10B491B8307C5B541E28B6D280AFD50EA99994C864CD8587A9472B9909501C6200EE360DF0AA25A8300D9240C2F6B9D139DC9C86DCD282ABA2C8648F9A190CBB8F8A393F373EE3CA826C19F1B20BA26931CE2C6170475A82FB5A05DE14F0096B5042E249739B62797DD7A0AB247249771B1BEC056F41D0F4F0E2778E26FCA82D3606C48036E2F7D5281F3C8C82174B3046005C5398FDF400E0324AE7E449FD494AA1BED6FE514169845835148A069DD60027DD41C6DAEA2E08FBEF40E0092174D3D941CA09048DA8389D7BE83ACBAF85282FCA0120390DAE4733A5057739ABB48283EF140E29AE8352BC2816FF0010E1AD0222B8026E4E9FBE81C114828174A06C8F376A0F0D043DD73A0034A0700425B85974A0E9C46034806C1013CC503233717B0D682D395ADB14DC74ECA0AC37EE24A2F1A09184ED41C74A0702E682D78570175E740B87933E3647CC4123A29E321D1CB19DAE69E608434163272F2F26774F34AFC899FACB238B9C4F6B8AD0405AD6F84A03C49A06BC80D4017883CC50569B0A3990BC16CAD28C7B4A3C7B68258FA8E562B8479A5D3638B0C968F101FE368FBE808364C696106270735C7517078D023D8C6B46D52874E740F89AD05477A76D035F39703C0000B9E4E800A00B9592ECF9804230E32B184BC857E27765028080B750AAB413781576804D9072A0421C88848B29B5A81923B71BAA733D941CA0B5A57704A07070DC55A1C35A0E577208BA50107EC51C43B4F650432B4978B58F3A06B136AAF67B2814EAA35160BF7D07375E64FDE283B91542B40D7BEE9AF0BF1A06B141B8B8D05038007C27506C9CA816544038103DF410B1551C80F05D2D4165A016150BDD40C6105545C502B1A6CDF7DAC2839ED01C4137210916A0742220D22E53DBA502B65768084555140A183783F15AC11541A0E7441CD7394168B1160BC7ECA0818A3C5753A5038DC769175A08BE5BCB90C98F2181E6EEDA85A7FCCD3634120CFCF67F56012464A2C453FF00A4FEFA06BBAE0634B443334B78962D0537E6CD9AEF22263990AACAE236823F87DB41308D83E1B04BD071DA89C2CBFBE814786EEBF0140E01C849F0AE9FDD40D40D20BAFDD41CF6B4DDAA84E8B40DDC6E855002B408922FC17A0232BD0A59790E00D024C9B5A4212E017904A0AE1381BF04A075DC9753F85038AB6DA76F1A070D5A3BD68219492E2EBA11C28102A802C3F7D04A1A82DAA212785074C370D42E8B415C2A80EFBEF4166100071ECD2839E2E081AD0231CE051A2EB6BFD940B29051025F5340D646480E69470BAF7D0399B9A2ED54450A940E209215CD6D8A0D681929FE5B9C5DE2080029C7541410315C50D89B8234A07B5CE2F07769E2ECD281C80F1D16DCE8232F7072952D4B73ECA045B0FE24A0E5408D3DE79D076D2401A0E3DD41C0201DBF750712340147134086E4A0D35BEAA28180950E171C57B2814808AA45941141DC5C16C3DE6813C3B75B73EDA0BF216EFB270BF6F2A06BDEDF29A111095234A08B6B154BADCA8242D3B500553614085A8836E9EEA0687BB7024697A0E782DBA045E0AA868102291AA9B0E24AD039B65E00FBA815DBB62DBF03415DCD731E6D7201BFF6504EC3621B63413B8B5CDDAEB01A71A08589BB6928797F7D073F50D5B73E412824F0ADAE0A6D6F7F1A052C25C846D3A02071EEA0EDA6E5CD04850D55053B28209802CE4E1C35EEA0818A6DB54EBB681E05F69E5A6B40B234D8B480BAD023953894E3F65030868F1722A00D528389280826F62281E4EE0A9F09F7502280EE674EEA052D68E3C92818547849B270D50941408768B285E141C4383769BE89DD4082C87720E09D940E46A6E43CF82F2A0B2FF137CCE1C3B4D02B58483B9549B1D6F40D162545B88363409B9CAA0D89E1CBB681CE2E521EA2C9408C01BA95FC281A6EBC02F850502464192C084B1341333C455A375B4FB1681E18405703DA08B0341566087C36FC528160E1B87145141623738466CAE37EE5E22819E59DFB9DA734B1A0E24077670D2C09A0DE7D2BF47E2FA97ABCC7A86EFD3F0582592388A3A42E3B5AC0782F1A0D9FAFFE97FA75BE9DCAEB1D0A07E33F0407491B9EE7C72465140DF7046E141E2F280D56150E5B9E434A0AD3069039ADCF3A08DAAA01BDD546B41C6E02EBCE8150A8BDAD41C84B9023485B9D1681B2376A120D914F3A06B9AD2AB64D1DA50773254AF1FEFA0E0770503B89FDBB681012001C782D0735A46B60B73AD035DB5CE210A0BAD0712405D4201DB41CD4370354A04DE34DBE1544A07F8E37787C4DE3A84A09A195CF690546DE3726F40A40048BEFFDB9D070DBB8EFD16C97F7D073C0002ADF53DD40E8D4855B6A1682273D4A6A751C281F13000E712A0E8470A0923739AE2D1C2FBA8251210C0CEC55279DE823C80A781D0AF6EA96A0A6C2E0F2B60741DB416C2ED0E373C508A0E7B5ED6287283AF3F7D03632CDE5A5AA85149B2506BFE9FF00AD327D27D58E640C1918D337CBCAC6794DED55D7811C2836DF507EB347D73D3F2749E9985F2B04C1A32242E0E7103468000B5A83C8E691CE7798F24EEB1ED4EEA081E09692D72916D28208DCEDC9A00B73C0503DE0A29D45FD940846E5DC38272EEA046F1E46C9C168111A84388042AA73E42818C2576A107445A05DA80ADDA6CBF6D034AEE453B795035FF127DBCE839C84A03FBA8112E5C0EA9DF41C01FF0028EDE340E0E6B5E835E3DF41DB4EEECD538A504D282A0941745A07B48010945D5DDA05021009BFC3ADAF408AAE72680228A050A11492D364E541231E0B50052753FD941038200555CB6445FEEA073256A9288A2FECB76504B7441FD3B5F89A07169009768470D6FA5020DFB4B76FC286FAA5053943A32D4D554A505B63894423811C281EE17F0A02972B6A085A180124ED5BA6868258C381DCA965FECA07BA476E0D24807E208A6810BDC5C1ADBEA7BB85031E5CD6A0088A579D040DDA0F8C28E07EDA073417168E1C0DBDD41CBA294B22D021E009B5C93AA5035E012BB940B1B71A06B77972D80BA1A04DCD51BCF87821BD0238B88569D3B38D0235091A8ECA0E3B771BAB681A1AA492554D071243B69F172E5F65073802410840553CA83BC3AAFE64F669EEA0B0F04ADAD75F650240E47290A7F2F10941212D2ED3D8281B70EF0E8BF85E8150EDD3C4975A07342B411F08D785046E4BB87C40EBCE8231AA107984E3DF41603BC2174DC96A0504A10C2769445140D2E735CD7B816A9B9EFA066402012BA13B41097A0762481C2E2E156DA1EEA09082E0587E176B6D282274603B69728E2281CD79D76DAE8BAD03C027C475D368D79D035DFCB2117B46BED51412CA4168360BF08E76E5415890840201D54D8D0744A75BF68E140E2856CA52DAFD941CD4721363A169B50303404B9516268108D5AB6074EFA068E0B6455280D026DE22CD1A0FBE81AFDC0022EA50FE141C7C6E5441F65026D210F151C9281B75436701A8A052E603617D3BE8112EB74A0B4E04DD502DC5030B804B929A916A09F6206A2171FB968185C078F5E006B7341DE3DC422037D681C01FCBA1E7AD029680A45C71A08A420351108B844E14091C8E1C11A744D7D941335ED6AB5094F7503490E552A0F0A0739BBE269DCAF68BF3B5040CD6D606E9A0F6D05988843E2BA03AA29A085E76971BA93C6811A0EFB1B6AA74A0943818C1096256F40B62F0896D78044A073802C04DD57437A0AEED85BB9C7C7C7BC504AC1B90EA4A14141A9F4BFD3CF51FA89D19C0C70D824716B32663B63714B8078FB2835527FF00E7EF52004C79D8AEF08712AE0D37DA9B8F6DA830FEA5F46F5BF4F4EE8BA8E3EC0D7166F69DCDB68145067DC51D7D08FD9681BB43085D4EBCB95035CE3B6F63CAD6A04696EA05BB68151A54827440385044002884AF0B5038176E5727EEA04710D09F17EFF6D036E9A5B9AF0A0959229D87871D6DCA8154293C38D04F178A269360796B6A050D610484D75FDF40A01691B827DC9ECA0739CE2F2484601A0E3408F2434E84F1ED5A08CB0BC97258590503046EE163C08A07025CAB723C2568151EC3F1272206940E8C9F31C0DCBC20EFA089EA1C38A6BDF40E738B62DCD29BB95031AE5F8AE83E2A07004B6D61AD03C2ED693A0BA715A091AAE2439D7049701C49A0446050F692E16B5046F6B485D1AB6B506C7E987A423F527A9A1C39CF9789134CD39E2E02CD60FF0031141F4CE260418D8F163C313207323168BFA2DF2CA077638696D682CBB072246CD24199B65980D5A08681A0683A500BEB5D123EAF8395D3F2E266440F88C660D9E3F388FEA3A43A5EE1283E55F55F429FA175BCBE99293E663BCB438A5DA6E3ECA00E5800E6350681AAA896DD627850215234B6848A042538701B56811FB800D28001AF7D035BB828B2733CA81AAAE0814B78D0729DA9B8272ECE5413C91B4BAD606E940C95EE682E5E1C681D82E2633B9C800B1A09C23828D5084A056EE05A0B50F1275A09435CF79DA15B746E9A0D68181ED046FB15E140D1724B6F643BB4A08DCE5202F153C281AE01AFDC2E398D282469796A908DE5CF8D023D0315BF94A8E6281F26D91AD7B4843F12715BD0401BB9E54E9CA8347E80F4962FA9FD4F8FD33232BE5619373DEE6A1739AC05C4356CA68367D73E9C74C7BF2A1E8988F0CC60FDB941E64692C5DA5EA4FC5B0D07976D00D97C3AAF2A07C23C4E710458009A92795029716CE5A81DB86A0AD0216128BC2E47E341E9BF43A2664E6F52C78DCC6E496B1EC528A1A5D65A0F7DE970323271CCEF793B7CB7BC203E512AD6AEA38D04F3C1991BC3D8413FC416EE26CB415E4CE89D97242CC98DB3785877B4B9AF3C7429D941F35FD68C8825F5FE706BFCCF29AC648E1657A2916E4A283085500D1743CD681B6B104A77507280E4B9E038507292C164BA85E0940A77120FC4E2795031CA751B178D034B0A12AA9AE8B411A0DDDBAECBD0592551BD880FE1ECA0A9947C0575D139504902B48012E05CE8282D391405B8ECFBA8257AA8D09A07B086785A2E45F40A3DB4119166816BA0B8B7B68148DA0B4A97151A823DB4113C3411B812BA5021B0D10016E2A681632D2D0B62BB87EC2815AE639CEF6EBDB40B17858582E1575FCA682091B2179746435E0785458F6505CE95D4B33A6E7C59B8AFF272E021F191E2450857B1283567EA275DF2A76E386E3BF35862C990171569084004DAC7B683213B9CE7027E201140007D94091168894594AEB6E540D914B9AE036A597B78D048E0D202E9C483C385015F4A7A8723A075983A863377065A684E8F6710A7DE283E91F4DFAA7A7F5EC06CB8592649F2003338A6F61FC8DDBF96835C71F21B0798E9247318402D73BC2E68D6F41E73F503D61D0FD34C796CCDC8CF91BBA1C4611BB79E7B6CD68E741F3AE767E466E54D9792FDF3E448E9657F02E76A9C5282BB802D5545A089A41054A05A0E77C7BD6C742283ACD080EDDD75D53BA811D2ECB8771255744E541566CA4F0B4DF89EFA04827205F5D56827DD7DC97554FC282D787F3689C39D00DCF5DCCDCBE5ADD3FB2826BADBD8B41619E620B055F095A09879BE51FB79D0399C5372F0E4940E66DBA7C2A53750365FB6DA25021DAA36ED5409FDA94113916FAA1D79D031DB12CBECD681C1363745B27776D04813CE6A7C49C79503BC3F32ED17F272E09ADA82ABB7F9C7726F5BD05CBEE6AF2F0FBB85036DB7C28ABA9FB35A068FE98444DB6A0E937205E76EFA07B7E02BF028EE5A0E3BF7F8755E3F6D05FE91FAC7CEB7F4AF98F9D4FF00F977EFEC5D9C3BE83693FF00E6BFD34F9DFA97CB25F45D3FC3E2A0F3ECBF9BF364F9AF33E6377F33CC5F3377F8B75E82B84409F076F34BD038FE65D16E9F85044DFDE9EEECA073D542FC29FB6940D93B17409C9282A6479881136F1A0A435F17C5C282767C56F6A5059A0FFFD9)
INSERT [dbo].[Profiles] ([Id], [Phone], [Email], [IsAdmin], [IsBlocked], [Name], [Surname], [ImageData]) VALUES (2, N'9564545656', N'artemmazur294@gmail.com', 0, 0, N'Artem2', N'Mazur2', NULL)
INSERT [dbo].[Profiles] ([Id], [Phone], [Email], [IsAdmin], [IsBlocked], [Name], [Surname], [ImageData]) VALUES (3, NULL, N'artemmazur943@gmail.com', 0, 0, N'Artem3', N'Mazur3', NULL)
INSERT [dbo].[Profiles] ([Id], [Phone], [Email], [IsAdmin], [IsBlocked], [Name], [Surname], [ImageData]) VALUES (58, NULL, N'artemm2323azur94@gmail.com', 0, 0, N'Artem4', N'Mazur4', NULL)
INSERT [dbo].[Profiles] ([Id], [Phone], [Email], [IsAdmin], [IsBlocked], [Name], [Surname], [ImageData]) VALUES (61, NULL, N'artem2mazur94@gmail.com', 0, 0, N'Artem5', N'Mazur5', NULL)
INSERT [dbo].[Profiles] ([Id], [Phone], [Email], [IsAdmin], [IsBlocked], [Name], [Surname], [ImageData]) VALUES (63, NULL, N'artem2mazur94333@gmail.com', 0, 0, N'Artem6', N'Mazur6', NULL)
INSERT [dbo].[Profiles] ([Id], [Phone], [Email], [IsAdmin], [IsBlocked], [Name], [Surname], [ImageData]) VALUES (85, NULL, N'artemmazur94@gmail.com', 0, 0, N'Artem', N'Mazur', 0xFFD8FFE000104A46494600010201000000000000FFE2021C4943435F50524F46494C450001010000020C6C636D73021000006D6E74725247422058595A2007DC00010019000300290039616373704150504C0000000000000000000000000000000000000000000000000000F6D6000100000000D32D6C636D7300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A64657363000000FC0000005E637072740000015C0000000B777470740000016800000014626B70740000017C000000147258595A00000190000000146758595A000001A4000000146258595A000001B80000001472545243000001CC0000004067545243000001CC0000004062545243000001CC0000004064657363000000000000000363320000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000074657874000000004642000058595A20000000000000F6D6000100000000D32D58595A20000000000000031600000333000002A458595A200000000000006FA2000038F50000039058595A2000000000000062990000B785000018DA58595A2000000000000024A000000F840000B6CF63757276000000000000001A000000CB01C903630592086B0BF6103F15511B3421F1299032183B92460551775DED6B707A0589B19A7CAC69BF7DD3C3E930FFFFFFDB00430006040506050406060506070706080A100A0A09090A140E0F0C1017141818171416161A1D251F1A1B231C1616202C20232627292A29191F2D302D283025282928FFDB0043010707070A080A130A0A13281A161A2828282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828FFC200110800C800C803002200011101021101FFC4001B00000203010101000000000000000000000305000204060107FFC4001801000301010000000000000000000000000001020304FFDA000C03000001100210000001EB6F2F8E861E3C8C6D816E40DC347899D11B9D352E9B6F225A5DF6AE6D9898C9E0A4911EC919248124812480ACB7425095DB06362F07918C30E605C96A3BDCEFD4AB70DC3A53947F4ABA27A457D19737279EDA924092409240C693A0E5534CAAA1CB5A07AFAC5F1D77E3A4A75B62202F02CA5EA5CE0DAE5CCF63CBF43A49EF5F52F60AC8BC92D49204920513B6543F9F37C3D3F3EDB00C039B5795B678BC36D3EAAF358F4E904D598BB67E1ADE546FF3CA39AD64E6AD3297EB89246492067E3FACF9E53D5D1AC69CDAEEA90325036AE774905345B65150C7572C7D63AE18356996AC9AA8A44411B3A1E8CE7B9F649B292400FCCFB7E295755EB2C78DF9CFB6E6B3D69A5092CE8F466E839F4E692F42AF431B8ABBB83B9C1B1E7B6C025E40B8B664F1EC01A8BC93A2249038C54D16CDFD015B55D145C9BE99B4207D68D03ABC2D42BC4E57AB1EBA5D0781DBA41EFED1E772809733C24A2492949207CEB5A4373E9F4DC785B598C7606567179E4567C0E964DADD40D8514B9CA4E8749986D89CEAF6A834F7CEA8F648124812481F2BC875BCDAFD09C70ED73DBA8C384D59DA0F1656C17E3F5EA2A52CECEC566D5931DA837F460C34A2E8267456D5E9CED240803C97E7B235F1CC580ECEA762B0C69DE735D1F26CE8EA9DAF1EC5169B452AB7B89DECF54A5D337DD37CD3AFECE73B5CDC80BB5DEAED9EAC7DF3DC28E5499F7AE9FDE5E35CBAF741DF8D5BA4F15767CEB30675CF767F3FEB79B53A97ABF2D10D0A1DA7DC3A33699ED798756B2EF92191CAE1BAD54916E687411AF2CA66BEA9A38462EB8C6DCB6A9C9CE035ED3BB2EDB368CB16C9D95124CEB4AFF33D1EDB234B9E81131456B4CC746B68570E5EBA658933326D0CD06F6D462C4C57E69BF942B406EA9C3AC2A9860699169EDE63C5B324D0DA2DD6AA83B664E52DE20559E87B6F4CD0EA78982E3187FFC40029100002020201020602030101000000000001020003041112132105101420223130322324413442FFDA0008010000010502DF60E0B7DD976E1B2B55B2C2C4B1D9C9227AA3065082D0D12C95BFE5278290CC38B52CEECC498E574C4886FB015CB9D5ADE7C965791C5A8B844BBB427F15C352EB10D79171B8DA4C3636C388F65603356D194407452E2096E4B8DBBC160A53F59FEFE014A749C0AEA6612CB6B58723B1B8B467F2E53EE719556C60A996358C2CF0FB89487EFF00038282FA794712CD6D818434D19C7B8AB7169329A6535811106B331032E0F62A76BF47F03AED72D9A584F1C7ACD968C6EED8C23634E8EA257C405D9AD624533EC5B570B71CFC353FCDC07DCD32AA0B4650E3678553DB8C658CB0A4E302C58B04532F1F1C5FAF278BEE24CC96D8CD4FE5F0E5D5108856159C6718AB00822C236B47D985F4492D35A83DA8C5878BD83AEA3A8985D93C8C226BCF714C58BF550F9C7FB5610F780FB6E769983F97042B6062FD98619B9CA169CA3D8AB0E6F74CA7331ADE717B59187675D403B1EC7D8855A5DCB9F86AF2C3C7F8DF937F4E599B643E216065F112C52EDBD91ED205A4CA18F34660D8A746C959E4861339766D861F5E76B85C26EED895F47117FE8CC530D3658F750CB654840C3AF6EF54BEBD374B72AC75051256BA9737114FEAE67FEC7D1D693F5F3F18D25387BB6FD734AEBE0CCBB8D547C73171B669A820225A9B9D211522C1323B8A06AB277E6CBB806BD9E2EC1ECF0F714E4292CB93B0F0C3DE01A83C9A37620F9298472807C784E3D977EECD24D9E13671C8FF001961ED37E4C63DDD2AFD6975B722D8ACCE0180C5FB5D00A76FF81ED1BC36B3D5536174D683B02F373ECB2822DA8054480F92C1F6FD955BBABF2307D7B7287F263B746DC1C8DAF3422B3598FD98CE5A9D55D5B9B588F9A00F56A6576729599BEF6B965A7EEAD6E0FAF3E476266AF2B57B1AEB3010AD496D971CC996FC87A5520D14A8D5220D1F2AE5EE4578E382AD965172AA9F21EEB732B33AF572AFC495E7A9461FA62E7D8D5E7728440BDACA79CF4C04E0161585C2AB5CA5A9B3A95789374ECC6BC3D7EB2D595DEC6BAB2DAC833920CBACC1908675520A6C32BC77E6085414F5DECB3E3E247A8712DE57EF895710D823E4777C8063E576C9BD982920615FAAB22B4CCC4C4BACC6C8CBB88A6AC9364DC6DB46C64871ABDFA710F53897B2B3659C956BE9603ECCCCDCC7B78DFCA58A658F6885D8F9D9DCE3AEECC7FD16F4C71959C6DB5AEB4CE6D1722E595F896524C7F1C262F89E334A6FA6C1CCECD9B475ED8D7716CA7E175DF297AF16C5B7A954B9371D08318C1F7889FD74F8AD9BB982765A11A0AE8581288BDA64D15B44B7A5317D2918F96CA4104197832AFE5C1505ABCB130ADE216E531EC12C6863CA87C69AF5E1AEF37A9D4DC3646BB50DD3AB2AC8653C56E811D09131ECD43FB37C8605EA9582359C342860229584ECB111FCAA5F864E4FF5F7370BC6627DB5BE8F20F0AFC3EA072F546948D8CA3CAA411104400CB028F3E5C5498C75364C337E5A9C6719C6033FFFC40023110002020201040301010000000000000000010211102112132031410330512252FFDA0008010211013F01B28AFAD6F2DE286ABBE22FC3823A6280CB24B15D91DB1684C4CB18C6576AD177858686862D0EBC8F3479231D591B6C6D21AE42D791EE43F23D12F1D9F1FF00911CD8C8B19E19EEC65E52D94E02C271F63690C96C947B5EA5A1FC7CDD9C78B16C8C2238A2448BCAC7217CD22DDDB22CB66FD9291778E507E8E317E8E8C1F83A0BF70B1078764888DE2D9CDA3AAF362951D567558E565FD2C6FF00AA2F7F47FFC40026110002020104020104030000000000000000010211120310213113202204324151304261FFDA0008010111013F01E52E3932711CAC48A12FD7F049B5D0DB6F64B6C9222EC62F59BFD955C9E53CA3D42EC42762B429A6EBD1F56C97235BC442EC724BB1BF96484EF7758BB251A631EC85FE88D58E71E0865F648D2E38DEFE2552A637C928C4AB20F11B4C5C21CAA3669B736D9A6BE5BB4BA357F6346245125B2E55136FA8A22DFE4C55DEF6D46C528EA7036363B4768464E116D1A3AC9F0FBF582B850FEA70F8A16A3D48F286E8B3817642368F0E2D38F5BB57B2824A85F4BA71E68AE09AA7B2230B2AB8DA719FF53CF25F723232321EDAABF2211118A2623827D98A315E928DF67811E2A211A122CBF55B76457C6C7D087EDFFFC40032100001030106060102060203000000000001000211210310123141512022303261718191A1134062B1C1D104E1237282FFDA0008010000063F026915425A6B700C21BB9D940BAB9280C3F2AB7F855EAE0024F84D70103CA26D4E22725345DCA3115C8E5DCB996CA5950BF49584ADFA98E83057FEC819A15E2ECC2CE579F1750DDDC89CF755303740E3A8EEA211D3008884D6B492AA56A5518AA165C344D03B42AAC27A630F66A9C49846BF45A716CAB7C8CD6139F4CD511B2249D50DB8654F0E21D4F94E1A2C47F215E2C9463B87E5AAD2100C76954D3BA8FC867C585A3D9D93DDE6162198723D0A950D592AA3D2C4D4EF24941BA222EA35542ED54BE5C501412A1C2E940DD8738540A86785D582468A8981D9C5551516CD440698955085F5D54C1595CC54CAEF7C766C753F94C61820F855D509CEEA2CFA2C4153355D38E89848240D94E5E1023A81AA2E32ABC4EACD53A94222ECE7849854047B43009427827A44387382B0D988A6650A12772AA001AA81C155453C20E8A8B2E85A7B4C7D70854DA93B29799F057233EC8DF24A86D54342CB821956A772D065D0AA71CA345FC2C531B85CA30AC2D945B3517405CE5C7E54C05CA381D87340382C0E77E2597DD626646E3C4203E6654C3FEAA19FE3BC9D4CAE696C7D935C35E641CDDB8E6EC6D77840AB07E8EE52A18FAE8B998F46D0D3D85CADFB2D3EABFDAD566A966E43F12CDD0A18307E958D8EC20771D901A649AE1B27B0EAD6B82AF0D2E6342870FA2759CF91E11B3B49D936D9A39B22AA047ABB9802BB164552D1C3E565215317A5FDA6B4775A38624E68EE6D3FA58983B9A558BBFF00377298552B3E0F426E73AD1D4858ACD81BE755CD68E3F2BBDDF554B578F954B627DD545B59B6775FF235D66572DA0284919A82D9710112D3F09AC71866207D2FC41DA68E55D7F7FF006A9ED0E3B679F4BD052F30DD9505156AB262A59C1F014663C8538709DDA8B2D1A2D19FB7A532E6F99A283F7C963A813900846DFC29D531CEA8882B09EE1CBFD2919159ACC7092BDD540BF7F0140207A5A9BA8E3E8A25B9ECB159BAB761747C859F88011244CFD53ACCFEE9E79BB5B5847D9E008466B34D4CB266DCCA8B75BF150C155A1DEFCCD771286CA8B2A978D6B44D34E62E752EADD4BC7ABABF40BC742ABFFFC400271001000202010303040301000000000000010011213141516171102081A1B1C1D13091F0F1FFDA0008010000013F21A2521D05E25212D4678870D378A744E505DEE1DA50CC8FD7AC40E0BE212D6F0DCD78F584B40F388F4B6A6DAA63B5FD25E03BE8FB085FF052258CAF3DF129867269F885A48B431FAADF798B2EF9A8E86EBAFACB9AD7CB12B2BEA43876764D22F4EE6C3B9718D99D1DE60520836625106F52F3FC0D855C67473738599C4CD681A83E7EB31961F32C6FF09920BD8A9C73F314DC1B34C955C330FB84A4284C8FA43E6550E4F9885D595E9614959FE0224032DE657FCC179C415E3F99984F032EB00717999AA3B11AF15EF157690A7108B2930E1B8401D8D72CAD9B5A7C3082DF4ED0D66662A1072E3DE20B271735E232A01DE0F8A3FEC44F565EE61D6659A468BA5914E929304E12233C63B11070CAA60D83FC2E728F0CEFCC096F58C8825E50CB25CE9201A3999350AC19E22DA9921AF4B084A8F92590DDB9ACB319BBDC718DBCC30397A087B972E65E22664875E931443E87E95B6A98767A8A6FAC54F543DB6E8606DDC0CFABC15888D61C49EB593D07B8456209633C42A36D403533663BF6E10FC5EE252598F56C1DCD2AE0F0A244809631ACA971ACB3D02E285DBD394212C4AB80BA466F693B61E8BB7798766FA9F997A0B38E4884A6D1C55E84411898259908AB71C33A952B69B2972FC2153A30F4E9060DC35ECB46BEBF118C98A8DEE711D2F5D6151856A1659BC130CAA509AC52D86249826189573125C8ABF46C509728F49606D86F9A8D76808AB4E006E6AE9EC2C09470FF006279C63E139B2BA954BA3718A895647912398684C9528E977CC4E8202474C47296483F6125A46345715BCCB5391BA982894D7B2A61D1364DDCD1ECAAB70F8E82642F0F0A252BB610BAC185B931708DE01E277595A09690F6266C1296008F32C23BCC8A112D832C74A54600E91855FB3A1A00E3372E2D851B602621C9CA561D372ECB8A090D23B6382212A69BCC297324E75A858F88AD8E65DBD94951597B95F66C4A551BEED2E8062F512D008DCC15E9B95912C0B0B058D8258E6B39D4623A954B21C652ADD6E0A57A3A8643DC958656704703A762F101115B797BCA0B00754D769CC60855C591CD620586A5514E26F3010B44E198F93C3318523A9A3DCDB8DBEB2E5BF176ED0AC4294B30A76C56B030687C10970673AC35A29536C6C0420B0140D7370DC67896B49E7D230C06072A31D6700764B2D559C7BA15952D514829A0B80AAACE7AA1A8710B7A82DAA8DBBB7F2779A718BDEA2321BFD24D84C8766D25D1F3455827188545444AE3AF1DE3E004A7BCC784EB89F994298B6435373DFD95E96A21B1C6601B3BBD21585A804A5EC05DDA0DA1304BD2E6258C9FD403E823D92867D60EAB53204229E7959A0179C4646CBBB159961DE6DBDE5E41A34E997B179F28D7544E5B8EF4FBCE70F82C2FF49E3F9187DD0EB553E38F5B98E81CB529F623F0FDCC0C2E199DA596D3BFB32FAD9FD6299E238657DC3F329662A35B80232950BDC60945B98C89D76892CCCFCA3999905E9D633D421F52559764214BD992BACA6DE3C4E4B3FA84184D6B52AFBDA63294E8DCD441E5133A15A30CC07968AEF6627520CFBDDAFC4396C407357B3EF2D8E8AF11099D32B5BC63419BA8B7965D1146E9CD3F84580CA815DF2C46E8D56E15FAB207A08FA2E38B8867069003B60D0C72BA012FED14E09ADD5CDC52979D015F7A8476195D37FA89C0771D524BD2C52D0D3DB8666D0BAE38AFE19992D2C102CEEA714C7189A04AA98A0BF19DE2A11167920C78EA0F4CEA9B4FD931BF155B16E4EA510382B828862BFAD7C91AED75667B9417F4BB87F27CC0596F84FD130A69762AE25CD6803A72496959D1A8BFCE112FE96DDEE65FFBACA5D4175314C8BF9A2392125C56CC25BC09E693F54B9CBDFBC363998319FB43ACAD7B044C49728BBF233C1FEE69C3C84740F23F898BB3D1A6572F68B8BB2A23B8F009C64634C02CBD5FF213222BDC928A496BA46E20308189A4B8C658506F290B6E3B4051A41F30016437A6280C66647CEEFC4DEB263D5F0E253DD8AE8446E32FD0886A06920ECFA9175A36AE6F0ECB80FDC8632151E71747E63C5DAD69F3292D535E64ECE91BA803473BAE264DCC45E3ACB3C75658655D18E7329B6E78521DBDE735CC0BDF25541C5D0E2604637083D15F110763BCFFDA000C03000001110211000010810B80834FB0BFCF3CF0014D534F50A72D3CF3CEEDC6E7C58F5014F3CF02332B2E4248D2D5DF3CAC6330BAE9DEF7457CF3725EB36484F83D40F3C433C690E2197B2171CF3F231AB65DB03DD38F3C8F97D7FA575E1F1F3A781CB2A39EDAE7B1717AAE7AE7F0CF2C28D027F48662C5EF5CF54ABBB3109DBB0E05B1CA59176E5BFFC400201101010100020203000300000000000000010011213110412051617191F0FFDA0008010211013F1042F361C633CB2E7768CFEC9F30706003250EBC19BD437896264FC473C4B504A7B882730C30B4361C9392BE1A00BB9F218CB30BA427ABA319F3A5A464C4205B0EE57A82693D737A17DFCF061D29D415C424AE403883CD432C873098032E5E42F6C977D192756049DD64EAD30E6DA2940EC6D66790712CC61F707BBD473700163361A094E4EBE294637A2B3C5D874B473CC73A861C5811928EDEBC20EFC297560BC30D6F6469C5CA005ECB71DB283867F33F9BDC4FAFFCFEADE666C736C630BEAFB27865D36DFAB560BDC4BF0936DDB13BD203D5A76788E0CF873E09EE3A96753820B8C3CDDBE1F07537FFC4002311010101000202010403010000000000000100112131104120516171F0B1C1E1F1FFDA0008010111013F10063C0F50E40CBD225619D96B0E65CEEDFBFC48D201FBFBF9B44C0E72465B87376185F10C66AA2750FC0309C0A630F56365EA34E60669E17237AB38F8107D04F007BF0BA30BB769F8353A65A21E221A790904A5B7090DA6F137A2E3CC438CB850940E24E9FAF29E9EDFE3FEDA25E76E5900D84B8817375F3D763547FB155C2616FBE7C9107A8003EC8975B93007101CC61D436984D07BB201EFF799FB879334F39688DE22DE24E881771B1A1CB216E442FDBE242BE9FD4881DB718E5A36E7EED1DCA238F4CA1863CB631C830CB103892F748716A1610D6457010FA5945DCF30C73F587F4BF1839897334BAEACD220EC919C475D9CEF2DF9C264C38CBEF5D4307A8CE4D7DC11C368B935924B7C0F3CD83174B71B3502A0ED093B9E727C7FFFC400281001000202020201040203010100000000010011213141516171812091A1B110C1D1E1F030F1FFDA0008010000013F10D259830727AF1E2592A34D846CAEEE52E2D91294ECE613A584B01BC2F6E6651D0AD55F93959501BE497468F78014296034FDC83DF49447DE66ABC5E7F24AC6CEB3706894E30E54C109C2FE9FA15DF53237AE3FF0B48434D455427DBB9CC0AD4CF0E1F7D40CA855BD6389D4BA5BA7F52B483AB75EAE5904BCFF009EE64A039B57C398D04387FC92894EC023351C006FE215501C84A7AFF128C49887082AAB72385C11011AD3CA06FE4800AB1C8C0ADDE7A81E88069CFF00E14F8CB4B3F3C06BCC53594416A6C98E55A15533550320DA1876A0D3CC75BCC0487CC5C28E163482DE768D29BBCCC121C2FF00729545BBD32EC70C2EBA13B859B90D4DF47BB89E10870728785F701820A4FE31032EE532E7FF000485CA1A84CABCDC26414B3658CFAA96013A0DBF19994625D2DBF7D4B9F1F89FBCCA01C2FF00F09697279306363CC4D82188C25599C0CBC82B552A840D5F64AEA13E74BFD11539962D21CFB8A8AFB3F84B03679A84DA77505066E2A0D2B9EFEBAE4B1B0AD92DC17C40E0BB741E9F3EA3A8A295401FBB2F6DBD0059F9A89D191A3A89CF4D5472DFDDB9E61E398D362FFDA9480C35FE62B365F3CC2004F64ACB10469907B97A2DBB7EA567C99BEE70216C6590F1F5866AEF335EE087A6D6324170D72F262565B4E9D7998F17054764A2C639729BBB7750985B586560577E21E55099030329696254A2ED5E9C4A3A6CC2309795540B0D1DCBAAB04D3767D5632E1503878895184BB2CDB10B4B0A399B3CBE13A50763D4E03DC1557920DE0D6085B18865513523952C855AC8FDE36836D45A3B8AF04AD1FE90140F4AE6686FE7E915002E1CB80EE124B4ADC79C5C65C0C5D19650655E65F2DD92FBC4511D137993528A801E6022A658097641DCDB1BD33D20821918808701DF98AE07CC71E0E7E9BB242A815DAD38CC1C0127695BCFC5411B980766E52BF099183CC66A0C062A6E049C28AA2C9052637C97F85952E1C4A42B0D409C68D114017BFA6E142D8F7B5872B41F315014A95480D55E51BA86A8AA02C7FED41163908294E862B6D89BCF31AA5EA54162B032C26E965BCB3925305D99C59484E3931F3028238799660B46F750365EA7BB800D85A6F704C2E198ECD64ADFD0411551E8722BF119B25A9A16B6BC6A0B7776AD114E6F997EA6CA7C456C9D04B7E5EB2139D85A6EE05A576CA74E23E21560D998A0BF64CDC0C07329D5A28BA78B8AB346ACC8FCC480A1DC6B76E8E22D0A8B6A29298E7CC1D7CBB31671F89461CE17347F705EB1CBE637B1693E8255AC185E5CFCB31DCD9C5AC3032ACDBE405F8B8D087689685F899F5B8190E8FF003340BECA7B770E75774E257C38DB8D4A4571D4B1303C45EFAAE5CF158AB87B86160F0903115029428B4A1917074BE2586CB78825B75B3D993F1728761483202F4F10D64FF5F4504D0DDDD4E4AEA95F71829903BA68338A6189230895F896FB32A96D43EE594A7A4BCB8030C792C0823F8A59C9F100C01FE081CC12185AADB5AD40E58BCCA16304E601B111601C20C05591AA26BA538EBE824E7617638F922119E410970CDB8074E2DFE88AD10584A8704B80172F6A883E01DCD571299634559D31361D8F31551158967CE7900B8F70070A2AA70D7EB1BD4E237A60B894E7EAA4AD1C172F4B2875446F5F1294542AFF00A81423B1DF64C6C3071326995A960C54ED8032C5480AA0AF5C33544E4680F5CCAFD3D2502F73B1B9C8730D24203FD26C41FAFE367A8ED765FD4E7396CBB3DC7FDE71170568C2D55171C1AB6086A8180F5302130E8E1B969EE2AB216460868B30450442919827AC812E00984012A332A2B1392E65BD1011C4C847A84FCC10658BDCD945E3515A6AC31F5085D707665BF501B38887223241A2B904B20BBB1500DC3DEE53AA3FE3398B281B3313040B33A651BD42C0020C97DAB1217557041D4BDC319E40454B02E292FAB60A7E655010658F7D400A40B6115D3EE649714A7F0B970A7E7E8A4211D544F05332F5E04B68CB7CB700E4DAB3114017E181ABC0D67FD4466011C0D15C99ED7BA8AC1B1A63ECFEBED31EC86CDA8F304388918295895897A53EC8F29AB62D8C3296F52D15E3C4A1C1512CF882AABA2B65C3F0B8301A95E8E1B94E463853B49D2BABF52935B62EFCC0805B7BEE2F30BFDCBFA002A05ADAFF001DFF0085D6AE9B23D6F45B3EEFAF51D644C42572B81FFE44620CC4A1C2E1FDEE5899B41686BED177AEE3A4B4B786EFE26157F372E5E3C902067CB730E1C62997AF72AD60E206068D4CEB032AE265C0569434EEEF52A36BD511528041C69607DD2D42249B72F452AD35BE25BF6B256FD883088D5561CB4E3C3116902D5BF8EFE222EAA2C2907A13FEF4BE65E04E6B97EA0DB5E8BFA83DD658A84F6C2328E50BE166A00DACB53F57FBCCA9AEA28E32736C0732AE7D0176C3D648046AE0598B02BC59F660A125D74EA7DA2E86E75C1F33845EA5A9431DC229802A17776458ADFA99DE6866A0C44D2ACBDE26890B2907F5F68873155A6AB0E70D31D322A7269AAF09FF006664513045BCA734F3E61E3A825C4F65E25524A543F64C058AB060EB312E777811FB941A7C165C6A746345350D649964508DA038F332E8160B3E128735ADDAA87804FCC40E4684D00FBB3F94B35950B2A00F220F997D92EC75959FB60A288F3A65F2BDD409E01ACC71BBCCB76FDE39AC5237D44732F3E98FDFE653685986EAF8FB429574565C141E6510384D4D37C31BDF3DD4CD9E5F08FEE5763B27FB537D28127BB8881C5FEC6EBF53937A88F847F048A9765B27C194FDE690EC33745F79433DB4C8541D5AE99684D916D3C53AA6CDC45CB32B082D3A1372A41CE817C07C31285B4380E54F5461C92C1ACD070F24D97A22DEC1E78880BB175A23F24CCCC6BE94C9A9871154B1EFE332D41D5674E25C1231B94F3D4A20B15851F7952A65C61F78865A9B0FEE60847681F8B8978B77013F356308672055BF479C4B91AA577B409EB50DA6A236EF285BE9F2C582AA9B898C0129F3E634C2D6D6DE0B6D6D9EFF00545858E699624AAD1D1CD78A81642A29781B3DE37F1296D8228D8FF5EA06815CA2A8E4F871F100480BA77305642EA06419AD092CDA4AB2D96DC5EB33EC4BC0C9EEB5FEDBF897D6160CDD57FAFDA159D039E1411B1E744B302838568FCC0B6B36A61F66638EE102F1D8CBA3A576E7BD772C380EA9D9025AE4169D531D4D7915D79EC7E48095907FDEFA8A05AD770500050B516E34DC6542922D5686C1CE732E440230C9C266903C9E232E04BC81C1A7FB941575C43BCDB8DA7F5154F65B863C665FD841A9BF1E17125BC778671A94B522AFC37D4B745656B2E667C8E2D7F30066DB0BCBDFDD825B0D071597FF00A8D51F63C101B55C15D05170DF50A984DA573182716A015BDC4046D2E2A63732BE24A9B099339EDF1E660CB82D1AFF00AF1EFD4001846C970D50803B44C1A801420E5A20586F8F2CC6B8E11729D07C7DFB8CC42435FDFBD8D7997B17019B5A7263241A9CB045A4E79E0129C84B4E305E6FD4C0851406BCCB2CB279D40361AE6573682574AD9332E4A32BCB37C6C8308E5B667D4C50F170595626E01ADCCA8ACCBA577A98A0B57DCBBBB9C4CEC8608FFFD9)
SET IDENTITY_INSERT [dbo].[Profiles] OFF
SET IDENTITY_INSERT [dbo].[Seances] ON 

INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1, CAST(N'2016-04-20 18:00:00.000' AS DateTime), 1, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (2, CAST(N'2016-04-15 14:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (4, CAST(N'2016-03-23 20:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (5, CAST(N'2016-04-15 09:00:00.000' AS DateTime), 1, 24)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (6, CAST(N'2016-04-30 17:00:00.000' AS DateTime), 2, 24)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (7, CAST(N'2016-03-17 11:00:00.000' AS DateTime), 1, 25)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (8, CAST(N'2016-04-30 18:00:00.000' AS DateTime), 1, 25)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (9, CAST(N'2016-03-28 10:00:00.000' AS DateTime), 2, 25)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (10, CAST(N'2016-04-10 15:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1011, CAST(N'2016-03-30 22:00:00.000' AS DateTime), 1, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1013, CAST(N'2016-04-03 21:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1014, CAST(N'2016-04-29 21:00:00.000' AS DateTime), 1, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1015, CAST(N'2016-04-30 18:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1016, CAST(N'2016-04-27 22:00:00.000' AS DateTime), 1, 6)
SET IDENTITY_INSERT [dbo].[Seances] OFF
SET IDENTITY_INSERT [dbo].[SeatTypes] ON 

INSERT [dbo].[SeatTypes] ([Id], [Type]) VALUES (1, N'Single')
INSERT [dbo].[SeatTypes] ([Id], [Type]) VALUES (2, N'Double')
INSERT [dbo].[SeatTypes] ([Id], [Type]) VALUES (3, N'Single4D')
SET IDENTITY_INSERT [dbo].[SeatTypes] OFF
SET IDENTITY_INSERT [dbo].[Sectors] ON 

INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (1, 1, 4, 1, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (2, 5, 7, 1, 3, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (3, 5, 7, 8, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (4, 8, 9, 1, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (5, 10, 10, 1, 10, 2, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (6, 5, 7, 4, 7, 3, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (8, 1, 12, 1, 12, 1, 2)
SET IDENTITY_INSERT [dbo].[Sectors] OFF
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1, CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 2, CAST(80 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 4, CAST(95 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 5, CAST(40 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 6, CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 7, CAST(65 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 8, CAST(120 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 9, CAST(66 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 10, CAST(89 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1011, CAST(70 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1013, CAST(120 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1014, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1015, CAST(50 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1016, CAST(50 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 1, CAST(120 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 5, CAST(50 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 7, CAST(75 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 8, CAST(130 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 1011, CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 1014, CAST(3 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 1016, CAST(60 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 1, CAST(150 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 5, CAST(60 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 7, CAST(90 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 8, CAST(150 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 1011, CAST(150 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 1014, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 1016, CAST(70 AS Decimal(18, 0)))
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'9c3ec10d-1a48-42aa-876e-1cd1c57bcb17', 10, CAST(N'2016-03-05 13:34:36.227' AS DateTime), 0)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'ae2ee03c-2a84-4503-be83-38a6b2980ec6', 10, CAST(N'2016-03-07 12:09:43.163' AS DateTime), 0)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'2eeee0a4-262b-46b9-ae0e-5e8185973d5e', 10, CAST(N'2016-02-24 13:05:22.590' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'b2ff1992-e9aa-47a2-8bd8-682f148dda81', 10, CAST(N'2016-04-05 12:08:59.967' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'88e6250e-64de-4322-a70d-6effc492243f', 10, CAST(N'2016-02-26 10:50:09.370' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'78df95f3-fc80-4ecb-8247-7a4f732a9f24', 10, CAST(N'2016-04-06 11:48:43.833' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'bd7e586c-c711-4219-b133-91f841b55f72', 10, CAST(N'2016-02-25 15:31:03.327' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'1ea02f0d-f7a7-4bbe-b8f8-aa49208decb9', 10, CAST(N'2016-04-09 13:42:41.580' AS DateTime), 0)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'c4047104-903f-4894-8d3a-af51883004d3', 10, CAST(N'2016-02-24 13:09:00.717' AS DateTime), 0)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'67aea807-20f7-4aa1-8a88-ef97def6832e', 10, CAST(N'2016-03-05 13:50:13.670' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'ccfe3f34-30d4-4b63-8242-ff075bcf24eb', 10, CAST(N'2016-02-29 13:30:56.257' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'd957ffa3-715e-4662-8aa2-ffbbe22356cb', 10, CAST(N'2016-03-02 12:38:40.077' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Tickets] ON 

INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1112, 2, 6, 2, CAST(N'2016-04-13 12:57:43.580' AS DateTime), NULL, N'0451b55f-61d2-4e56-91de-a8bae4067d5b')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1115, 1, 1, 1, CAST(N'2016-04-13 14:22:24.803' AS DateTime), NULL, N'5555c5f6-7462-4bba-9f24-84a7c80c06b0')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1116, 1, 2, 1, CAST(N'2016-04-14 08:41:22.113' AS DateTime), NULL, N'f7279109-aefc-4edc-96b2-152309e3cabd')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1117, 1, 3, 1, CAST(N'2016-04-14 08:57:29.670' AS DateTime), NULL, N'6e7a7e82-0c12-412c-92eb-e8f46cbe956c')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1118, 2, 1, 1, CAST(N'2016-04-14 08:58:27.210' AS DateTime), NULL, N'81b1e152-022e-4a5b-9a5c-5aa8e8d2f073')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1119, 1, 4, 1, CAST(N'2016-04-14 09:24:16.133' AS DateTime), NULL, N'a3d6c7bf-0a09-42a8-abc0-8bafe53e2e2a')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1120, 10, 4, 1, CAST(N'2016-04-15 12:56:33.113' AS DateTime), 1, N'836f4ce1-1752-42ad-831c-fc8ce54a35f3')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1121, 10, 5, 1, CAST(N'2016-04-15 12:56:33.113' AS DateTime), 1, N'284b6747-c59f-448d-bc95-5e37a0231852')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1122, 8, 5, 1, CAST(N'2016-04-15 12:56:33.113' AS DateTime), 1, N'ac0075a8-d930-4550-913f-363e75372ed5')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1123, 7, 5, 1, CAST(N'2016-04-15 12:56:33.113' AS DateTime), 1, N'e8921c16-968c-4b83-9ba2-e9eaae0a3fd1')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1124, 8, 10, 1, CAST(N'2016-04-15 12:56:33.113' AS DateTime), 1, N'b799235a-5c86-401e-b832-0a3d0e32be71')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1125, 9, 9, 1, CAST(N'2016-04-15 12:56:33.113' AS DateTime), 1, N'a3941cfd-5566-4896-9458-1e0954509842')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1126, 1, 9, 2, CAST(N'2016-04-15 12:56:54.143' AS DateTime), 1, N'4a16a3a6-0067-4a8d-b3b1-bc1066d17c66')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1127, 3, 9, 2, CAST(N'2016-04-15 12:56:54.143' AS DateTime), 1, N'2f98c7e0-aa09-4f64-8a29-fa1fce335f19')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1128, 6, 8, 2, CAST(N'2016-04-15 12:56:54.143' AS DateTime), 1, N'0a8f939e-0251-4170-ae9c-e2b0cabc569c')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1129, 6, 9, 2, CAST(N'2016-04-15 12:56:54.143' AS DateTime), 1, N'36efd7f8-bc03-4d42-9406-ef3b65101f95')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1130, 7, 8, 2, CAST(N'2016-04-15 12:56:54.143' AS DateTime), 1, N'c115706e-b087-4dad-b062-bd9344da68ca')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1131, 7, 11, 2, CAST(N'2016-04-15 12:56:54.143' AS DateTime), 1, N'a79a100e-993b-4501-9d19-fb0a186c15d0')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1132, 10, 4, 2, CAST(N'2016-04-15 12:56:54.143' AS DateTime), 1, N'f2890f7c-8b60-4ca6-9469-392b99690e2b')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1133, 10, 6, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'34c67c2d-84e3-4993-84a3-9b1a29ef5481')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1134, 10, 7, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'5f20079f-9275-46d2-9435-e8352204ea95')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1135, 10, 8, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'c7d9fd25-8e89-4a0f-90a0-ff54aaf78564')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1136, 10, 9, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'39fa071e-a033-4eac-86e5-b40b9da798c9')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1137, 10, 10, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'aafb1e2d-d004-4afa-8eab-e969b88dfeb6')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1138, 9, 10, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'e7e7bb0d-99ee-437b-9f6e-ac034ce01ecb')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1139, 9, 9, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'bbe78a6e-40d9-43d7-b4e5-7c67cfb0d003')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1140, 9, 8, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'6b4a2932-c7c4-40f7-8a26-36339a4cbb96')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1141, 8, 8, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'07648af2-5b0e-4663-b431-30249deff72d')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1142, 8, 9, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'9520b7da-4ef1-45c5-b86c-ff91d0233944')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1143, 2, 10, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'37f59723-2042-408b-b422-d3b62e7ca21d')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1144, 2, 8, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'6ac9be46-b043-48a3-81ab-bfb950865dab')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1145, 2, 9, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'4fcd9c77-5de1-4351-8f0b-56c80742fe75')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1146, 3, 9, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'2449787f-8b7e-4ecd-875a-a4d973b37e4c')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1147, 3, 8, 6, CAST(N'2016-04-15 12:57:16.607' AS DateTime), 1, N'28940dbe-be98-45d5-9ff9-1959305c2b62')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1148, 12, 10, 1015, CAST(N'2016-04-15 12:57:39.727' AS DateTime), 1, N'c1403f82-f809-4af2-99df-16bf9a83cbcc')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1149, 12, 11, 1015, CAST(N'2016-04-15 12:57:39.727' AS DateTime), 1, N'7b29b7d8-4042-44fd-894c-d38c79f7e931')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1150, 12, 12, 1015, CAST(N'2016-04-15 12:57:39.727' AS DateTime), 1, N'aa24e42c-d648-4d8d-8c19-0646891e5288')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1151, 11, 11, 1015, CAST(N'2016-04-15 12:57:39.727' AS DateTime), 1, N'33b5d542-1cc6-4e54-87e9-494c592887cb')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1152, 11, 10, 1015, CAST(N'2016-04-15 12:57:39.727' AS DateTime), 1, N'af699581-99be-4d95-b9c2-8af3135f26b8')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1153, 10, 10, 1015, CAST(N'2016-04-15 12:57:39.727' AS DateTime), 1, N'6e92d528-b0ac-4821-b99b-873d497e36d1')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1154, 3, 6, 8, CAST(N'2016-04-21 10:25:56.497' AS DateTime), NULL, N'8b10c056-b6ee-42d0-b256-3b22516b4446')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1155, 1, 1, 6, CAST(N'2016-04-27 09:41:00.863' AS DateTime), NULL, N'ba0690b7-4971-4aca-8be9-e5cdfcf7644b')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1156, 1, 10, 6, CAST(N'2016-04-27 09:41:59.277' AS DateTime), NULL, N'e4c1b4dd-aa00-4bd9-9734-f463fc497815')
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [ProfileId], [Guid]) VALUES (1157, 3, 3, 6, CAST(N'2016-04-29 11:39:20.630' AS DateTime), NULL, N'e69c4d0b-776a-41e0-bfa8-99e5f8bc8b03')
SET IDENTITY_INSERT [dbo].[Tickets] OFF
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[ExternalAccounts]  WITH CHECK ADD FOREIGN KEY([ExternalProviderId])
REFERENCES [dbo].[ExternalProviders] ([Id])
GO
ALTER TABLE [dbo].[ExternalAccounts]  WITH CHECK ADD FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[GenreLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[GenreLocalization]  WITH CHECK ADD  CONSTRAINT [FK__GenreLocaliz__Id__5629CD9C] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GenreLocalization] CHECK CONSTRAINT [FK__GenreLocaliz__Id__5629CD9C]
GO
ALTER TABLE [dbo].[MovieLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[MovieLocalization]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[MoviePersonsJunction]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[MoviePersonsJunction]  WITH CHECK ADD  CONSTRAINT [FK__MoviePers__Perso__34C8D9D1] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MoviePersonsJunction] CHECK CONSTRAINT [FK__MoviePers__Perso__34C8D9D1]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK__Movies__Director__35BCFE0A] FOREIGN KEY([DirectorId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK__Movies__Director__35BCFE0A]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK__Movies__GenreId__36B12243] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK__Movies__GenreId__36B12243]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD FOREIGN KEY([PhotoId])
REFERENCES [dbo].[Photos] ([Id])
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD FOREIGN KEY([RemoveExecutorId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[PersonLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[PersonLocalization]  WITH CHECK ADD  CONSTRAINT [FK__PersonLoc__Perso__398D8EEE] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonLocalization] CHECK CONSTRAINT [FK__PersonLoc__Perso__398D8EEE]
GO
ALTER TABLE [dbo].[Persons]  WITH CHECK ADD  CONSTRAINT [FK__Persons__PhotoId__3B75D760] FOREIGN KEY([PhotoId])
REFERENCES [dbo].[Photos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Persons] CHECK CONSTRAINT [FK__Persons__PhotoId__3B75D760]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[Seances]  WITH CHECK ADD FOREIGN KEY([HallId])
REFERENCES [dbo].[Halls] ([Id])
GO
ALTER TABLE [dbo].[Seances]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD FOREIGN KEY([HallId])
REFERENCES [dbo].[Halls] ([Id])
GO
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD FOREIGN KEY([SectorTypeId])
REFERENCES [dbo].[SeatTypes] ([Id])
GO
ALTER TABLE [dbo].[SectorTypePrices]  WITH CHECK ADD FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
GO
ALTER TABLE [dbo].[SectorTypePrices]  WITH CHECK ADD FOREIGN KEY([SectorTypeId])
REFERENCES [dbo].[SeatTypes] ([Id])
GO
ALTER TABLE [dbo].[SecurityToken]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[TicketPreOrders]  WITH CHECK ADD FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[TicketPreOrders]  WITH CHECK ADD  CONSTRAINT [FK__TicketPre__Seanc__03F0984C] FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TicketPreOrders] CHECK CONSTRAINT [FK__TicketPre__Seanc__03F0984C]
GO
ALTER TABLE [dbo].[TicketPreOrdersDeleted]  WITH CHECK ADD FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[TicketPreOrdersDeleted]  WITH CHECK ADD  CONSTRAINT [FK__TicketPre__Seanc__17F790F9] FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TicketPreOrdersDeleted] CHECK CONSTRAINT [FK__TicketPre__Seanc__17F790F9]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([ProfileId])
REFERENCES [dbo].[Profiles] ([Id])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[AverageNumberOfTicketsOnSeance]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AverageNumberOfTicketsOnSeance]
as
set nocount on;
select avg(counts) as Average from( select cast(COUNT(T.SeanceId) as decimal) as counts from Seances S left join Tickets T on T.SeanceId = S.Id group by(S.Id)) as counts;

GO
/****** Object:  StoredProcedure [dbo].[BookedTicketsOnSeance]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[BookedTicketsOnSeance]
	@SeanceId int
	as
	set nocount on;
	select T.Row, T.Place from Tickets T where T.SeanceId = @SeanceId;

GO
/****** Object:  StoredProcedure [dbo].[BookTicketOnSeance]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[BookTicketOnSeance]
	@SeanceId int,
	@Row int,
	@Place int,
	@ProfileId int = NULL
	as
	insert into Tickets(SeanceId, Row, Place, ProfileId, SaleDate) values
		(@SeanceId, @Row, @Place, @ProfileId, GETUTCDATE());

GO
/****** Object:  StoredProcedure [dbo].[IsSeanceAvailable]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[IsSeanceAvailable]
	@SeanceId int
	as
	set nocount on;
	select case when exists (
			select * from Seances where Id = @SeanceId and
				DateTime > GETutcDATE()
		) then cast (1 as bit)
		else cast (0 as bit)
		end as Available

GO
/****** Object:  StoredProcedure [dbo].[IsTicketBooked]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[IsTicketBooked]
	@SeanceId int,
	@Row int,
	@Place int
	as
	select case when exists (
		select * from Tickets where SeanceId = @SeanceId and
			Row = @Row and
			Place = @Place
	) then cast (1 as bit)
	else cast (0 as bit)
	end as Booked

GO
/****** Object:  StoredProcedure [dbo].[IsValidPlace]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[IsValidPlace]
@SeanceId int,
@Row int,
@Place int
as 
set nocount on;
select case when exists(
select * from Seances S join Sectors Sec on S.HallId = Sec.HallId where S.Id = @SeanceId and Sec.FromRow <= @Row and Sec.ToRow >= @Row and
	Sec.FromPlace <= @Place and Sec.ToPlace >= @Place) then CAST (1 as bit)
	else cast (0 as bit)
	end as Valid

GO
/****** Object:  StoredProcedure [dbo].[MoviesThisWeek]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[MoviesThisWeek]
as
set nocount on;
select ML.Name from Seances S join MovieLocalization ML on S.MovieId = ML.MovieId
	where Convert(date ,S.DateTime) >= Convert(date, GETDATE()) AND 
		Convert(date, S.DateTime) <= Convert(date, Dateadd(d, 6, Getdate())) AND
		ML.LanguageId = 1
		group by (ML.Name);

GO
/****** Object:  StoredProcedure [dbo].[NumberOfSeancesThisWeek]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[NumberOfSeancesThisWeek]
as
set nocount on;
select count(S.MovieId) as SeancesNumber from Seances S 
	where Convert(date ,S.DateTime) >= Convert(date, GETDATE()) AND 
		Convert(date, S.DateTime) <= Convert(date, Dateadd(d, 6, Getdate()));

GO
/****** Object:  StoredProcedure [dbo].[SeancesThisWeek]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SeancesThisWeek]
as
set nocount on;
select S.Id as SeanceId, ML.Name, S.[DateTime] from Seances S join MovieLocalization ML on S.MovieId = ML.MovieId
		where Convert(date ,S.DateTime) >= Convert(date, GETDATE()) AND 
			Convert(date, S.DateTime) <= Convert(date, Dateadd(d, 6, Getdate())) AND
			ML.LanguageId = 1;

GO
/****** Object:  StoredProcedure [dbo].[TopFiveSeances]    Script Date: 5/4/2016 11:23:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[TopFiveSeances]
as
	set nocount on;
	select top(5) S.Id as SeanceId, ML.Name, S.DateTime, Grouped.TicketsSold 
	from (select S.Id, count(*) as TicketsSold from Seances S 
	join Tickets T on S.Id = T.SeanceId 
	group by S.Id) Grouped 
	join Seances S on Grouped.Id = S.Id 
	join MovieLocalization ML on S.MovieId = ML.MovieId 
	order by Grouped.TicketsSold desc

GO
USE [master]
GO
ALTER DATABASE [CinemaDatabase] SET  READ_WRITE 
GO
