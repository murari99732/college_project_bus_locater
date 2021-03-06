USE [master]
GO
/****** Object:  Database [PMPLServices1]    Script Date: 12/13/2018 10:43:32 ******/
CREATE DATABASE [PMPLServices1] ON  PRIMARY 
( NAME = N'PMPLServices1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\PMPLServices1.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PMPLServices1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\PMPLServices1_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PMPLServices1] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PMPLServices1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PMPLServices1] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [PMPLServices1] SET ANSI_NULLS OFF
GO
ALTER DATABASE [PMPLServices1] SET ANSI_PADDING OFF
GO
ALTER DATABASE [PMPLServices1] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [PMPLServices1] SET ARITHABORT OFF
GO
ALTER DATABASE [PMPLServices1] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [PMPLServices1] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [PMPLServices1] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [PMPLServices1] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [PMPLServices1] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [PMPLServices1] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [PMPLServices1] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [PMPLServices1] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [PMPLServices1] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [PMPLServices1] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [PMPLServices1] SET  DISABLE_BROKER
GO
ALTER DATABASE [PMPLServices1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [PMPLServices1] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [PMPLServices1] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [PMPLServices1] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [PMPLServices1] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [PMPLServices1] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [PMPLServices1] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [PMPLServices1] SET  READ_WRITE
GO
ALTER DATABASE [PMPLServices1] SET RECOVERY FULL
GO
ALTER DATABASE [PMPLServices1] SET  MULTI_USER
GO
ALTER DATABASE [PMPLServices1] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [PMPLServices1] SET DB_CHAINING OFF
GO
USE [PMPLServices1]
GO
/****** Object:  Table [dbo].[AreaOfInterests]    Script Date: 12/13/2018 10:43:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreaOfInterests](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AreaName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[Lat] [float] NULL,
	[Lng] [float] NULL,
 CONSTRAINT [PK_AreaOfInterests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Advertisment]    Script Date: 12/13/2018 10:43:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](50) NULL,
	[Image] [nvarchar](50) NULL,
	[Lat] [float] NULL,
	[Lng] [float] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
 CONSTRAINT [PK_Advertisment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getDistance]    Script Date: 12/13/2018 10:43:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		virus
-- =============================================
/* 



declare @km as float
select @km=[dbo].getkmFun ( 21, 75, 20, 74	);

select @km

*/
create function [dbo].[getDistance](@Lat1  float,
							@Long1  float,
							@Lat2  float,
							@Long2  float)	
	returns float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets froms
	-- interfering with SELECT statements.
		if @Lat1 is null or @Lat2 is null
		return 0;
		declare @dDistance as float
		declare @dLat1InRad as  float
		declare @dLong1InRad as float
		declare @dLat2InRad as float
		declare @dLongitude as float
		declare @dLatitude as float
		declare @dLong2InRad as float
		declare @a as float
		declare @c float
		declare @kEarthRadiusKms as float	
  
   
        select @dLat1InRad = @Lat1 * (select PI() / 180.0);
        select @dLong1InRad = @Long1 * (select PI() / 180.0);
        select @dLat2InRad = @Lat2 * (select PI() / 180.0);
        select @dLong2InRad = @Long2 * (select PI() / 180.0);

        select @dLongitude = @dLong2InRad - @dLong1InRad;
        select @dLatitude = @dLat2InRad - @dLat1InRad;

       -- Intermediate result a.
        select @a = Power(Sin(@dLatitude / 2.0), 2.0) +
                   Cos(@dLat1InRad) * Cos(@dLat2InRad) *
                   Power(Sin(@dLongitude / 2.0), 2.0);

       -- Intermediate result c (great circle distance in Radians).
        select @c = 2.0 * Asin(Sqrt(@a));

        --// Distance.
        --// const Double kEarthRadiusMiles = 3956.0;
         select @kEarthRadiusKms = 6376.5;
        select @dDistance = @kEarthRadiusKms * @c;

        return @dDistance;		
  
END
GO
/****** Object:  Table [dbo].[Routes]    Script Date: 12/13/2018 10:43:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Routes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Route] [nvarchar](50) NULL,
	[Source] [nvarchar](50) NULL,
	[Destination] [nvarchar](50) NULL,
	[Number] [nvarchar](50) NULL,
	[Direction] [nvarchar](50) NULL,
 CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Routes] ON
INSERT [dbo].[Routes] ([Id], [Route], [Source], [Destination], [Number], [Direction]) VALUES (17, N'Hadapsar-Katraj-Hadapsar', N'Hadapsar', N'Katraj', N'301', N'Up')
INSERT [dbo].[Routes] ([Id], [Route], [Source], [Destination], [Number], [Direction]) VALUES (18, N'khakwasla-venuati college', N'khadkwasla', N'Vebutai College', N'1', N'Up')
INSERT [dbo].[Routes] ([Id], [Route], [Source], [Destination], [Number], [Direction]) VALUES (20, N'skn-katraj-skn', N'Skn', N'Katraj', N'101', N'Up')
INSERT [dbo].[Routes] ([Id], [Route], [Source], [Destination], [Number], [Direction]) VALUES (21, N'Test', N'ICIC', N'Highway', N'111', N'Up')
INSERT [dbo].[Routes] ([Id], [Route], [Source], [Destination], [Number], [Direction]) VALUES (22, N'ramtekdi-swargate-ramtekdi', N'ramtekdi', N'swargate', N'55', N'Up')
INSERT [dbo].[Routes] ([Id], [Route], [Source], [Destination], [Number], [Direction]) VALUES (23, N'Test', N'asdasd', N'adasda', N'Atul', N'Up')
SET IDENTITY_INSERT [dbo].[Routes] OFF
/****** Object:  Table [dbo].[Stops]    Script Date: 12/13/2018 10:43:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stops](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Stop] [nvarchar](50) NULL,
	[Lat] [float] NULL,
	[Lng] [float] NULL,
	[Radius] [float] NULL,
 CONSTRAINT [PK_Stops] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Stops] ON
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (54, N'Gadital-Hadpsar', 18.501305315284117, 73.939104000000043, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (55, N'Hadapsar Goan', 18.502363448038661, 73.931336322692914, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (56, N'Magarpatta', 18.5035843623223, 73.926980415252743, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (57, N'Ramtekadi', 18.505649722496987, 73.918129125503583, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (58, N'Kalubai Chowk', 18.507460707467015, 73.907035509017987, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (59, N'Fatima Nagar', 18.507338619194897, 73.90098444548039, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (60, N'Swargate', 18.501559674716351, 73.858498254684491, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (61, N'Panchami', 18.492829842994169, 73.8578330668488, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (62, N'CityPride', 18.487783024055961, 73.857639947799726, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (63, N'DMart', 18.480253219517735, 73.857210794357343, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (64, N'Padmawati', 18.475450252515841, 73.856352487472577, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (65, N'KK-Market', 18.469263181527666, 73.857811609176679, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (66, N'Bharti VidyaPeeth', 18.458557393503551, 73.858197847274809, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (67, N'Katraj', 18.449153660058482, 73.858498254684491, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (68, N'Khadkwasla', 18.438853, 73.773117, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (69, N'Kolhewadi', 18.444701, 73.784765, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (70, N'Kirkatwadi', 18.44709, 73.789098, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (71, N'Jadhav Nagar', 18.453023, 73.794064, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (72, N'Mukainagar', 18.444143, 73.783244, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (73, N'Yashwant Vidyalay', 18.442942, 73.779955, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (74, N'Laman Vasti', 18.441894, 73.777724, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (75, N'Andha Shala', 18.451354, 73.791778, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (76, N'Nanded Phata', 18.451354, 73.791778, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (77, N'Nanded city', 18.457013, 73.801354, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (78, N'Green Acres school', 18.45741, 73.80454, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (79, N'Loakamat office', 18.457776, 73.806396, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (80, N'Lagad mala', 18.458585, 73.80902, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (81, N'Dhayri Phata', 18.460386, 73.812346, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (82, N'Abhiruchi Mall', 18.463485, 73.81521, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (83, N'Vadgao bridge', 18.463658, 73.815688, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (84, N'Manik Bag', 18.471723, 73.820977, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (85, N'Vadgao Phata', 18.467388, 73.818732, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (86, N'Vadgao Bk', 18.467388, 73.818732, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (87, N'Jadhav Nagar(Vadgao)', 18.466431, 73.824247, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (88, N'Vebutai College', 18.469189, 73.833624, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (90, N'SKN College', 18.468616986078349, 73.834771433738752, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (91, N'skn new college', 18.486826553712479, 73.9343243035355, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (92, N'BoM ambegaon bk', 18.460671, 73.836016, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (93, N'Indu lawn', 18.457231, 73.83534, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (94, N'Highway', 18.454819, 73.83652, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (95, N'Datta Nagar', 18.450596, 73.850747, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (96, N'Katraj Chowk', 18.44831, 73.85829, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (97, N'Katraj Chowk', 18.44831, 73.85829, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (98, N'ICICI atm', 18.46697, 73.835848, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (99, N'gadgil', 18.501305315311807, 73.941539445785565, 0.1000000030807747)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (100, N'pune', 18.502093828294115, 73.935466924575863, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (101, N'om super', 18.501035693873455, 73.943701306251569, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (102, N'sangvi', 18.501793685060271, 73.937650242713971, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (103, N'nande hospital', 18.502109089800442, 73.938470998672528, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (104, N'nande hospital', 18.502109089800442, 73.938470998672528, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (105, N'pune station', 18.501305315284117, 73.939104000000043, 0.1)
INSERT [dbo].[Stops] ([Id], [Stop], [Lat], [Lng], [Radius]) VALUES (106, N'Mundhwa', 18.533524558855596, 73.932784715560956, 0.1)
SET IDENTITY_INSERT [dbo].[Stops] OFF
/****** Object:  UserDefinedTableType [dbo].[RouteStopsTab]    Script Date: 12/13/2018 10:43:36 ******/
CREATE TYPE [dbo].[RouteStopsTab] AS TABLE(
	[Id] [int] NULL,
	[Sequence] [int] NULL,
	[Lat] [float] NULL,
	[Lng] [float] NULL,
	[TimeToNextStop] [int] NULL,
	[DistanceToNextStop] [int] NULL
)
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/13/2018 10:43:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmailId] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Imei] [nvarchar](50) NULL,
	[GCMId] [nvarchar](1050) NULL,
	[Phone] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Role] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (1, N'atul.chikane@gmail.com', N'123', N'Atul Chikane', N'123456789', N'asdasdasdsa', N'9579190699', N'Hadapsar', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (2, N'admin', N'admin', N'admin', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (3, N'savdhut868@gmail.com', N'123', N'Avdhut', NULL, NULL, N'7709190909', N'Indapur', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (4, N'Meghanasurvase@gmail.com', N'123', N'Meghana', NULL, NULL, N'7709190909', N'Indapur', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (5, N'Maninik@gmail.com', N'123', N'Manini', NULL, NULL, N'7709190909', N'Indapur', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (6, N'shraddha@gmail.com', N'123456', N'Shraddha', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (7, N'shraddhadeokar5@gmail.com', N'1234', N'shraddha', NULL, NULL, N'7387445802', N'nigdi', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (8, N'shraddhadeokar5@gmail.com', N'sid123', N'shraddha', NULL, NULL, N'7387445802', N'nigdi', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (9, N'shraddhadeokar5@gmail.com', N'12345', N'shraddha1', NULL, NULL, N'7387445802', N'nigdi', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (10, N'shraddhadeokar5@gmail.com', N'12345', N'sgoi', NULL, NULL, N'7387445802', N'nigdi', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (11, N'deokar.mohini@gmail.com', N'12345', N'mohini', NULL, NULL, N'9867453212', N'alephata', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (12, N'asd', N'1234', N'supriya1', NULL, NULL, N'rgvsgf', N'bori', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (13, N'pawarkiran1990@gmail.coma', N'123', N'Kiran Pawar', NULL, NULL, N'9890806076', N'flat no. E-78 Bhosale Garden Hadapsar', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (14, N'pawarkiran1990@gmail.coma', N'123', N'Kiran Pawar', NULL, NULL, N'9890806076', N'flat no. E-78 Bhosale Garden Hadapsar', 2)
INSERT [dbo].[Users] ([Id], [EmailId], [Password], [Name], [Imei], [GCMId], [Phone], [Address], [Role]) VALUES (15, N'pawarkiran1990@gmail.coma', N'123', N'Kiran Pawar', NULL, NULL, N'9890806076', N'flat no. E-78 Bhosale Garden Hadapsar', 2)
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Table [dbo].[UserSearches]    Script Date: 12/13/2018 10:43:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSearches](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserFId] [int] NULL,
	[SearchedBusStop] [nvarchar](50) NULL,
	[TimeSearced] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserSearches] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[updateGCMId]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[updateGCMId]
	@Id	int,
	@GCMId nvarchar(1055)
AS
BEGIN
	update Users set GCMId=@GCMId where Id=@Id;
END
GO
/****** Object:  Table [dbo].[RouteStops]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RouteStops](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RouteFId] [int] NULL,
	[StopFId] [int] NULL,
	[Sequence] [int] NULL,
	[TimeToNextStop] [int] NULL,
	[DistanceToNextStop] [int] NULL,
 CONSTRAINT [PK_RouteStops] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[registerUser]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[registerUser]
	@emailid nvarchar(50),
	@password nvarchar(50),
	@name nvarchar(50),
	@phone nvarchar(50),
	@address nvarchar(50)
	
               
AS
BEGIN
	insert into Users(EmailId, Password,  Name, Phone, Address) 
	values(@emailid,@password,@name,@phone,@address);
	select SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[Register]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Register]
	@EmailId nvarchar(50),
	@Password nvarchar(50),
	@Address nvarchar(50),
	@Phone nvarchar(50),
	@Name nvarchar(50)
AS
BEGIN
	insert into Users ( EmailId, Password, Name, Phone, Address, Role)
	values(@EmailId,@Password,@Name,@Phone,@Address,2);
END
GO
/****** Object:  StoredProcedure [dbo].[login]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[login]
	@emailId	nvarchar(50),
	@password	nvarchar(50)
AS
BEGIN
	
	select * from Users where EmailId =@emailId and Password=@password;
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[getAllStops]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>		GetBusBySourceNdDest 16,15
-- =============================================
CREATE PROCEDURE [dbo].[getAllStops]
	@UserId int
AS
BEGIN
	select * from Stops;
END
GO
/****** Object:  StoredProcedure [dbo].[getAllRoutes]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getAllRoutes]
	@UserId int
AS
BEGIN
	select Number+'-'+Route as Name,* from dbo.Routes
END
GO
/****** Object:  StoredProcedure [dbo].[addStop]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[addStop] 
	@Lat float,
	@Lng float,
	@Radius Float,
	@StopName nvarchar(50)
AS
BEGIN
	insert into Stops(Stop, Lat, Lng, Radius)
	values(@StopName,@Lat,@Lng,@Radius);
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteStops]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteStops]
	@Id int
	
AS
BEGIN
	delete from Stops where Id=@Id;
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteRoute]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRoute]
	@Id int
	
AS
BEGIN
	delete from Routes where Id=@Id;
END
GO
/****** Object:  StoredProcedure [dbo].[checkEmailId]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[checkEmailId]
	@EmailId nvarchar(50)
AS
BEGIN
		select * from Users where EmailId=@EmailId
END
GO
/****** Object:  Table [dbo].[Buses]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Imei] [nvarchar](50) NULL,
	[CurrentBusStop] [nvarchar](50) NULL,
	[PreviousBusStop] [nvarchar](50) NULL,
	[NextBusStop] [nvarchar](50) NULL,
	[DistanceToNextStop] [nvarchar](50) NULL,
	[TimeToNextStop] [nvarchar](50) NULL,
	[RouteFId] [int] NULL,
	[BusNumber] [nvarchar](50) NULL,
	[CurrentBusStopId] [int] NULL,
	[CounterId] [int] NULL,
	[CurrentTripId] [nvarchar](1050) NULL,
	[DistanceToDestination] [nvarchar](50) NULL,
	[TimeToDestination] [nvarchar](50) NULL,
 CONSTRAINT [PK_Buses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Buses] ON
INSERT [dbo].[Buses] ([Id], [Name], [Imei], [CurrentBusStop], [PreviousBusStop], [NextBusStop], [DistanceToNextStop], [TimeToNextStop], [RouteFId], [BusNumber], [CurrentBusStopId], [CounterId], [CurrentTripId], [DistanceToDestination], [TimeToDestination]) VALUES (14, N'hadapsar-Katraj', N'123456', NULL, NULL, NULL, N'0', N'0', 17, N'301', NULL, NULL, NULL, N'0', N'0')
SET IDENTITY_INSERT [dbo].[Buses] OFF
/****** Object:  Table [dbo].[BreakDown]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BreakDown](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BusFid] [int] NULL,
	[Time] [datetime] NULL,
 CONSTRAINT [PK_BreakDown] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteBus]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteBus]
	
	@Id int
	
AS
BEGIN
	delete from Buses where Id=@Id;
END
GO
/****** Object:  Table [dbo].[Conductor]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conductor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[MobileNumber] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Address] [nchar](10) NULL,
	[BusFId] [int] NULL,
 CONSTRAINT [PK_Conductor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[addRoute]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[addRoute]
	@Number nvarchar(50),
	@Name nvarchar(50),
	@Source nvarchar(50),
	@RouteStops dbo.RouteStopsTab  readonly,
	@Destination nvarchar(50) ,
	@UserId int
	
AS
BEGIN
	select 1;
	declare @RouteId int;
	
	insert into dbo.Routes( Route, Source, Destination, Number, Direction)
		values(@Name,@Source,@Destination,@Number,'Up');
	select @RouteId=scope_Identity();
	
	insert into dbo.RouteStops(RouteFId, StopFId, Sequence, TimeToNextStop, DistanceToNextStop)
		select @RouteId,ID,[Sequence],[TimeToNextStop],[DistanceToNextStop] from @RouteStops;
		
END
GO
/****** Object:  StoredProcedure [dbo].[addBus]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[addBus]
	@Name nvarchar(50),
	@Imei nvarchar(50),
	@RouteId int,
	@BusNumber	nvarchar(50)
AS
BEGIN
	insert into Buses(Name, Imei, RouteFId, BusNumber)	
	values(@Name,@Imei,@RouteId,@BusNumber);
END
GO
/****** Object:  StoredProcedure [dbo].[getAllBuses]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getAllBuses]
		@UserId int
AS
BEGIN
	select B.*,R.Route from Buses B 
	inner join Routes R on R.Id=B.RouteFId
END
GO
/****** Object:  Table [dbo].[Drivers]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drivers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[MobileNumber] [nvarchar](50) NULL,
	[Imei] [nvarchar](50) NULL,
	[BusFId] [int] NULL,
 CONSTRAINT [PK_Drivers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Lat] [float] NULL,
	[Lng] [float] NULL,
	[BusFId] [int] NULL,
	[Time] [datetime] NULL,
	[TripId] [nvarchar](1050) NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Locations] ON
INSERT [dbo].[Locations] ([Id], [Lat], [Lng], [BusFId], [Time], [TripId]) VALUES (3950, 18.501304626464844, 73.939102172851562, 14, CAST(0x0000A9B401432E3C AS DateTime), N'1')
INSERT [dbo].[Locations] ([Id], [Lat], [Lng], [BusFId], [Time], [TripId]) VALUES (3951, 18.501304626464844, 73.939102172851562, 14, CAST(0x0000A9B500ADB1C6 AS DateTime), N'1')
INSERT [dbo].[Locations] ([Id], [Lat], [Lng], [BusFId], [Time], [TripId]) VALUES (3952, 18.501304626464844, 73.939102172851562, 14, CAST(0x0000A9B500AE1773 AS DateTime), N'1')
INSERT [dbo].[Locations] ([Id], [Lat], [Lng], [BusFId], [Time], [TripId]) VALUES (3953, 18.502363204956055, 73.93133544921875, 14, CAST(0x0000A9B500AF0AF9 AS DateTime), N'1')
SET IDENTITY_INSERT [dbo].[Locations] OFF
/****** Object:  StoredProcedure [dbo].[updateBusParams]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateBusParams] 
	@NextBusStop nvarchar(50)=null,
    @PreviousBusStop nvarchar(50)=null,
    @CurrentBusStop  nvarchar(50)=null,
    @DistanceToNextStop  nvarchar(50)=null,
    @TimeToNextStop  nvarchar(50)=null,
    @DistanceToDestination  nvarchar(50)=null,
    @TimeToDestination  nvarchar(50)=null,
    @CurrentBusStopId int=null,
    @busId int,
    @CounterId int=null
AS
BEGIN
	update Buses set 
	 CurrentBusStop=@CurrentBusStop,
	 PreviousBusStop=@PreviousBusStop, 
	 NextBusStop=@NextBusStop, 
	 DistanceToNextStop=@DistanceToNextStop, 
	 TimeToNextStop=@TimeToNextStop, 
	 CurrentBusStopId=@CurrentBusStopId,
	 DistanceToDestination=@DistanceToDestination,
	 TimeToDestination=@TimeToDestination,CounterId=@CounterId 
	 
	 where Id=@busId;
	 
	 
END
GO
/****** Object:  StoredProcedure [dbo].[getBuses]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getBuses]
	
AS
BEGIN
	
	select * from Buses;
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetBusBySourceNdDest]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>		GetBusBySourceNdDest 25,35
-- =============================================
CREATE PROCEDURE [dbo].[GetBusBySourceNdDest]
	@sourceId int,
	@destId int
	
AS
BEGIN

	--SELECT * INTO #TEMP FROM
	--select RouteFId from RouteStops where 
	Select B.*,(select SUM(TimeToNextStop) from RouteStops where RouteFId=B.RouteFId and Sequence<(select Sequence from RouteStops where StopFId=@sourceId)) as TimeToYourStop,(select top 1 Lat from Locations where BusFId=B.Id order by Time desc) as Lat, (select top 1 Lng from Locations where BusFId=B.Id order by Time desc) as Lng 
	from Buses B
	
	where RouteFId in
	(SELECT RouteFId FROM RouteStops WHERE StopFId=@sourceId intersect SELECT RouteFId FROM RouteStops WHERE StopFId=@destId)
	
	SELECT * FROM RouteStops WHERE RouteFId in
	(SELECT RouteFId FROM RouteStops WHERE StopFId=@sourceId intersect SELECT RouteFId FROM RouteStops WHERE StopFId=@destId)
	--declare @RouteId int;

	--select @RouteId=RouteFid from RouteStops 
	--where StopFId=@sourceId 
	--	and RouteFId in 
	--		(select RouteFid from RouteStops where StopFId=@destId )
	--select @RouteId;
	
	--Select * from Buses where RouteFId=@RouteId;
END
GO
/****** Object:  StoredProcedure [dbo].[updateBusLocation]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>	[dbo].[updateBusLocation] 5,1,1,1
-- =============================================
CREATE PROCEDURE [dbo].[updateBusLocation]
	@busId int,
	@lat float,
	@lng float,
	@tripId nvarchar(1050)
AS
BEGIN
	insert into Locations(Lat, Lng, BusFId, Time,TripId) 
	values (@lat,@lng,@busId,GETDATE(),@tripId);
	--select * from Locations where BusFId=@busId and TripId=@tripId
	if((select CurrentTripId from Buses where Id=@busId)!=@tripId)
	begin
		update Buses set 
			CurrentTripId=@tripId,
			CurrentBusStop=null, 
			PreviousBusStop=null, 
			NextBusStop=null, 
			DistanceToNextStop=null, 
			TimeToNextStop=null, 
			CurrentBusStopId=null, 
			CounterId=null where Id=@busId;
	end
	
	
	
	select * from Locations where BusFId=@busId and TripId=@tripId  order by Time asc;;
	
	select RS.*,S.Lat,S.Lng,S.Radius,S.Stop from  RouteStops RS
		inner join  Stops S on S.Id=RS.StopFId
			where RS.RouteFId=(select RouteFId from Buses where Id=@busId)
				order by RS.Sequence asc
	--select * from #temp;
	select * from Buses where Id=@busId;
	
	
	
	
	
	
		
	
	
	
	
	select 1;
END
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SourceBusStopFId] [int] NULL,
	[DestinationBusFId] [int] NULL,
	[AmountCharged] [float] NULL,
	[BusFId] [int] NULL,
	[ConductorFId] [int] NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[NotifyBusBreakDown]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NotifyBusBreakDown]
	@BusId int
AS
BEGIN
	insert into dbo.BreakDown(BusFid, Time) values(@BusId,GETDATE());
	select 1;
END
GO
/****** Object:  StoredProcedure [dbo].[getStopsNdLocation]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>	[dbo].[getStopsNdLocation] 5
-- =============================================
CREATE PROCEDURE [dbo].[getStopsNdLocation]
	@Id int
AS
BEGIN
	select TOP 1 Lat,Lng,B.* from Locations L
	inner join Buses B on B.Id=L.BusFId
	where BusFId=@Id ORDER BY L.Time desc;
	
	select * from RouteStops R
	inner join Stops S on S.Id=R.StopFId
	where R.RouteFId=(select RouteFId from Buses where Id=@Id) order by R.Sequence;
	
	
	select * from Buses where Id=@Id;
	
	select * from Routes R
		inner join Buses B on  B.RouteFId=R.Id
	where B.Id=@Id;
END
GO
/****** Object:  StoredProcedure [dbo].[getBusLocation]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>		[dbo].[getBusLocation]  1
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getBusLocation] 
	@BusId	int
AS
BEGIN
	select Top 1 L.Lat,L.Lng,B.* from Locations L
	inner join Buses B on B.Id=@BusID	
	where BusFId=@BusId order by Time Desc
		
	select S.*,RS.Sequence,RS.TimeToNextStop,RS.DistanceToNextStop from Stops S
	inner join RouteStops RS on RS.StopFId=S.ID
	where RS.RouteFId =(select RouteFId from Buses B where B.Id=@BusId)
	order by Sequence asc;
	
	select * from Routes where Id=(select RouteFId from Buses where Id=@BusId);
END
GO
/****** Object:  StoredProcedure [dbo].[getBusesByCurrentLocDestination]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>		getBusesByCurrentLocDestination 18.505649722497,73.9181291255036,64
-- =============================================
CREATE PROCEDURE [dbo].[getBusesByCurrentLocDestination]
	@Lat float,
	@Lng float,
	@destId int
	
AS
BEGIN

	--SELECT * INTO #TEMP FROM
	--select RouteFId from RouteStops where 
	
	declare @sourceId int;
	
	select  top 1 @sourceId=Id from Stops order by dbo.getDistance(Lat,Lng,@Lat,@Lng) asc;
	--select @sourceId;
	
	Select B.*,(select top 1 Lat from Locations where BusFId=B.Id order by Time desc) as Lat, (select top 1 Lng from Locations where BusFId=B.Id order by Time desc) as Lng from Buses B
	
	where RouteFId in
	(SELECT RouteFId FROM RouteStops WHERE StopFId=@sourceId intersect SELECT RouteFId FROM RouteStops WHERE StopFId=@destId)
	

	--declare @RouteId int;

	--select @RouteId=RouteFid from RouteStops 
	--where StopFId=@sourceId 
	--	and RouteFId in 
	--		(select RouteFid from RouteStops where StopFId=@destId )
	--select @RouteId;
	
	--Select * from Buses where RouteFId=@RouteId;
END
GO
/****** Object:  StoredProcedure [dbo].[getAllNotifications]    Script Date: 12/13/2018 10:43:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getAllNotifications]
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select * from dbo.BreakDown Bd
	inner join dbo.Buses B on B.Id=BD.BusFId
   
END
GO
/****** Object:  Default [DF_Buses_DistanceToNextStop]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Buses] ADD  CONSTRAINT [DF_Buses_DistanceToNextStop]  DEFAULT ((0)) FOR [DistanceToNextStop]
GO
/****** Object:  Default [DF_Buses_TimeToNextStop]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Buses] ADD  CONSTRAINT [DF_Buses_TimeToNextStop]  DEFAULT ((0)) FOR [TimeToNextStop]
GO
/****** Object:  Default [DF_Buses_DistanceToDestination]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Buses] ADD  CONSTRAINT [DF_Buses_DistanceToDestination]  DEFAULT ((0)) FOR [DistanceToDestination]
GO
/****** Object:  Default [DF_Buses_TimeToDestination]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Buses] ADD  CONSTRAINT [DF_Buses_TimeToDestination]  DEFAULT ((0)) FOR [TimeToDestination]
GO
/****** Object:  ForeignKey [FK_UserSearches_Users]    Script Date: 12/13/2018 10:43:36 ******/
ALTER TABLE [dbo].[UserSearches]  WITH CHECK ADD  CONSTRAINT [FK_UserSearches_Users] FOREIGN KEY([UserFId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserSearches] CHECK CONSTRAINT [FK_UserSearches_Users]
GO
/****** Object:  ForeignKey [FK_RouteStops_Routes]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[RouteStops]  WITH CHECK ADD  CONSTRAINT [FK_RouteStops_Routes] FOREIGN KEY([RouteFId])
REFERENCES [dbo].[Routes] ([Id])
GO
ALTER TABLE [dbo].[RouteStops] CHECK CONSTRAINT [FK_RouteStops_Routes]
GO
/****** Object:  ForeignKey [FK_RouteStops_Stops]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[RouteStops]  WITH CHECK ADD  CONSTRAINT [FK_RouteStops_Stops] FOREIGN KEY([StopFId])
REFERENCES [dbo].[Stops] ([Id])
GO
ALTER TABLE [dbo].[RouteStops] CHECK CONSTRAINT [FK_RouteStops_Stops]
GO
/****** Object:  ForeignKey [FK_Buses_Routes]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Buses]  WITH CHECK ADD  CONSTRAINT [FK_Buses_Routes] FOREIGN KEY([RouteFId])
REFERENCES [dbo].[Routes] ([Id])
GO
ALTER TABLE [dbo].[Buses] CHECK CONSTRAINT [FK_Buses_Routes]
GO
/****** Object:  ForeignKey [FK_Buses_Stops]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Buses]  WITH CHECK ADD  CONSTRAINT [FK_Buses_Stops] FOREIGN KEY([CurrentBusStopId])
REFERENCES [dbo].[Stops] ([Id])
GO
ALTER TABLE [dbo].[Buses] CHECK CONSTRAINT [FK_Buses_Stops]
GO
/****** Object:  ForeignKey [FK_BreakDown_Buses]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[BreakDown]  WITH CHECK ADD  CONSTRAINT [FK_BreakDown_Buses] FOREIGN KEY([BusFid])
REFERENCES [dbo].[Buses] ([Id])
GO
ALTER TABLE [dbo].[BreakDown] CHECK CONSTRAINT [FK_BreakDown_Buses]
GO
/****** Object:  ForeignKey [FK_Conductor_Buses]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Conductor]  WITH CHECK ADD  CONSTRAINT [FK_Conductor_Buses] FOREIGN KEY([BusFId])
REFERENCES [dbo].[Buses] ([Id])
GO
ALTER TABLE [dbo].[Conductor] CHECK CONSTRAINT [FK_Conductor_Buses]
GO
/****** Object:  ForeignKey [FK_Drivers_Buses]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Drivers]  WITH CHECK ADD  CONSTRAINT [FK_Drivers_Buses] FOREIGN KEY([BusFId])
REFERENCES [dbo].[Buses] ([Id])
GO
ALTER TABLE [dbo].[Drivers] CHECK CONSTRAINT [FK_Drivers_Buses]
GO
/****** Object:  ForeignKey [FK_Locations_Buses]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Locations_Buses] FOREIGN KEY([BusFId])
REFERENCES [dbo].[Buses] ([Id])
GO
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Locations_Buses]
GO
/****** Object:  ForeignKey [FK_Tickets_Buses]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Buses] FOREIGN KEY([BusFId])
REFERENCES [dbo].[Buses] ([Id])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Buses]
GO
/****** Object:  ForeignKey [FK_Tickets_Conductor]    Script Date: 12/13/2018 10:43:46 ******/
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Conductor] FOREIGN KEY([ConductorFId])
REFERENCES [dbo].[Conductor] ([Id])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Conductor]
GO
