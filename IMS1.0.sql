USE [master]
GO
/****** Object:  Database [IMS1.0]    Script Date: 3/14/2019 3:41:48 PM ******/
CREATE DATABASE [IMS1.0]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IMS_TEST', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\IMS1.0.mdf' , SIZE = 25600KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'IMS_TEST_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\IMS_1.0_log.ldf' , SIZE = 22144KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [IMS1.0] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IMS1.0].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IMS1.0] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IMS1.0] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IMS1.0] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IMS1.0] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IMS1.0] SET ARITHABORT OFF 
GO
ALTER DATABASE [IMS1.0] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IMS1.0] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IMS1.0] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IMS1.0] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IMS1.0] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IMS1.0] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IMS1.0] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IMS1.0] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IMS1.0] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IMS1.0] SET  DISABLE_BROKER 
GO
ALTER DATABASE [IMS1.0] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IMS1.0] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IMS1.0] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IMS1.0] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IMS1.0] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IMS1.0] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IMS1.0] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IMS1.0] SET RECOVERY FULL 
GO
ALTER DATABASE [IMS1.0] SET  MULTI_USER 
GO
ALTER DATABASE [IMS1.0] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IMS1.0] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IMS1.0] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IMS1.0] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [IMS1.0] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'IMS1.0', N'ON'
GO
USE [IMS1.0]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split]
(
	@List nvarchar(2000),
	@SplitOn nvarchar(5)
)  
RETURNS @RtnValue table 
(
		
	Id int identity(1,1),
	Value nvarchar(100)
) 
AS  
BEGIN
While (Charindex(@SplitOn,@List)>0)
Begin

Insert Into @RtnValue (value)
Select 
    Value = ltrim(rtrim(Substring(@List,1,Charindex(@SplitOn,@List)-1)))
	 Set @List = Substring(@List,Charindex(@SplitOn,@List)+len(@SplitOn),len(@List))
End
Insert Into @RtnValue (Value)
    Select Value = ltrim(rtrim(@List))

    Return
END
GO
/****** Object:  Table [dbo].[ELMAH_Error]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ELMAH_Error](
	[ErrorId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ELMAH_Error_ErrorId]  DEFAULT (newid()),
	[Application] [nvarchar](60) NOT NULL,
	[Host] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](100) NOT NULL,
	[Source] [nvarchar](60) NOT NULL,
	[Message] [nvarchar](500) NOT NULL,
	[User] [nvarchar](50) NOT NULL,
	[StatusCode] [int] NOT NULL,
	[TimeUtc] [datetime] NOT NULL,
	[Sequence] [int] IDENTITY(1,1) NOT NULL,
	[AllXml] [ntext] NOT NULL,
 CONSTRAINT [PK_ELMAH_Error] PRIMARY KEY NONCLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ActualPurchaseTaxAndPrice]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ActualPurchaseTaxAndPrice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[purchase_id] [int] NULL,
	[product_id] [int] NULL,
	[purchase_rate] [decimal](18, 2) NULL,
	[discount_amnt] [decimal](18, 2) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[batch_id] [int] NULL,
	[sale_price] [decimal](18, 0) NULL,
	[discount_percent] [decimal](18, 2) NULL,
	[purchaseTaxId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ActualSalesTaxAndPrice]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ActualSalesTaxAndPrice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[sale_id] [int] NULL,
	[product_id] [int] NULL,
	[sale_rate] [decimal](18, 2) NULL,
	[discount_amnt] [decimal](18, 2) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[discount_percent] [decimal](18, 2) NULL,
	[saleTaxGroupID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_batch]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_batch](
	[batch_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[batch_name] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[batch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_branch]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_branch](
	[branch_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_address] [nvarchar](1000) NULL,
	[country_id] [int] NULL,
	[state_id] [int] NULL,
	[city] [nvarchar](200) NULL,
	[pincode] [nvarchar](200) NULL,
	[telephone_no] [nvarchar](50) NULL,
	[mobile_no] [nvarchar](50) NULL,
	[fax_no] [nvarchar](50) NULL,
	[email_id] [nvarchar](50) NULL,
	[manager_name] [nvarchar](200) NULL,
	[manager_address] [nvarchar](1000) NULL,
	[manager_mobileno] [nvarchar](200) NULL,
	[manager_emailid] [nvarchar](200) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[IsMainBranch] [bit] NULL,
	[branch_name] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_category]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[category_name] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_company]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_company](
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [nvarchar](500) NULL,
	[company_address] [nvarchar](1000) NULL,
	[country_id] [int] NULL,
	[state_id] [int] NULL,
	[city] [nvarchar](200) NULL,
	[pincode] [nvarchar](200) NULL,
	[logo] [nvarchar](500) NULL,
	[GSTIN] [nvarchar](50) NULL,
	[telephone_no] [nvarchar](50) NULL,
	[mobile_no] [nvarchar](50) NULL,
	[fax_no] [nvarchar](50) NULL,
	[email_id] [nvarchar](50) NULL,
	[website] [nvarchar](200) NULL,
	[owner_name] [nvarchar](200) NULL,
	[owner_address] [nvarchar](1000) NULL,
	[owner_mobileno] [nvarchar](200) NULL,
	[owner_emailid] [nvarchar](200) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[logo_name] [nvarchar](100) NULL,
	[first_name] [nvarchar](100) NULL,
	[last_name] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_country]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [nvarchar](500) NULL,
	[currency_name] [nvarchar](1000) NULL,
	[currency_symbol] [nvarchar](1000) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_currency]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_currency](
	[currency_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [nvarchar](max) NULL,
	[currency_code] [nvarchar](max) NULL,
	[currency_symbol] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_currency] PRIMARY KEY CLUSTERED 
(
	[currency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_EmailVerify]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_EmailVerify](
	[emailverify_ID] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [nvarchar](500) NULL,
	[uniqueidentifier] [nvarchar](max) NULL,
	[status] [bit] NULL,
	[created_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[emailverify_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_error_log]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_error_log](
	[error_log_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[error_type] [nvarchar](100) NULL,
	[error_msg] [nvarchar](max) NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[error_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_expense]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_expense](
	[expense_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[expense_name] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[expense_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_expenseentry]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_expenseentry](
	[expenseentry_id] [int] IDENTITY(1,1) NOT NULL,
	[expense_id] [int] NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[spent_on] [nvarchar](500) NULL,
	[description] [nvarchar](500) NULL,
	[amount] [decimal](18, 0) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[expenseentry_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_financialyear]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_financialyear](
	[financialyear_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[start_date] [nvarchar](50) NULL,
	[end_date] [nvarchar](500) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[Is_new] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[financialyear_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_godown]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_godown](
	[godown_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[godown_name] [nvarchar](50) NULL,
	[godown_address] [nvarchar](50) NULL,
	[contact_no] [varchar](50) NULL,
	[contact_person] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[godown_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_mony]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_mony](
	[mony_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[party_id] [int] NULL,
	[payableamt] [decimal](18, 0) NULL,
	[reciveableamt] [decimal](18, 0) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[mony_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_monytransaction]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_monytransaction](
	[monytransaction_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[transaction_typ_id] [int] NULL,
	[transaction_typ] [varchar](20) NULL,
	[paymentmode_id] [int] NULL,
	[total_bil_amt] [decimal](18, 0) NULL,
	[given_amt] [decimal](18, 0) NULL,
	[balance_amt] [decimal](18, 0) NULL,
	[in_out] [varchar](20) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[party_id] [int] NULL,
	[transactio_type_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[monytransaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_paidpayment]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_paidpayment](
	[paidpayment_id] [int] IDENTITY(1,1) NOT NULL,
	[subscription_id] [int] NULL,
	[user_id] [int] NULL,
	[transaction_id] [int] NULL,
	[company_id] [int] NULL,
	[transaction_date] [smalldatetime] NULL,
	[paidamount] [decimal](18, 2) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[paidpayment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_party]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_party](
	[party_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[party_name] [nvarchar](50) NULL,
	[party_address] [nvarchar](500) NULL,
	[contact_no] [varchar](50) NULL,
	[gstin_no] [nvarchar](20) NULL,
	[party_type] [nvarchar](20) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[state_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[party_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_paymentmode]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_paymentmode](
	[paymentode_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[paymentmode_name] [nvarchar](1000) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentode_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_plan]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_plan](
	[plan_id] [int] IDENTITY(1,1) NOT NULL,
	[plan_name] [nvarchar](500) NULL,
	[price] [decimal](18, 2) NULL,
	[duration] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[plan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_product]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[category_id] [int] NULL,
	[unit_id] [int] NULL,
	[godown_id] [int] NULL,
	[rack_id] [int] NULL,
	[purchas_price] [decimal](18, 0) NULL,
	[sales_price] [decimal](18, 0) NULL,
	[reorder_level] [int] NULL,
	[product_name] [nvarchar](50) NULL,
	[product_code] [nvarchar](500) NULL,
	[hsn_code] [varchar](50) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_productTaxGroup]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_productTaxGroup](
	[productTax_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[group_id] [int] NULL,
	[isSelected] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[productTax_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchase]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchase](
	[purchase_id] [int] IDENTITY(1,1) NOT NULL,
	[party_id] [int] NULL,
	[financialyear_id] [int] NULL,
	[po_no] [nvarchar](100) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[Po_Date] [smalldatetime] NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[PaymentMode_id] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[other_expenses] [decimal](18, 0) NULL,
 CONSTRAINT [PK__tbl_purc__87071CB9F01D8522] PRIMARY KEY CLUSTERED 
(
	[purchase_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchasedetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchasedetails](
	[purchasedetails_id] [int] IDENTITY(1,1) NOT NULL,
	[purchase_id] [int] NULL,
	[product_id] [int] NULL,
	[batch_id] [int] NULL,
	[tax_id] [int] NULL,
	[unit_id] [int] NULL,
	[tax_amt] [decimal](18, 0) NULL,
	[dicount_amt] [decimal](18, 0) NULL,
	[quantity] [decimal](18, 0) NULL,
	[amount] [decimal](18, 0) NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[status] [bit] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[purchasedetails_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchasedetailsHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchasedetailsHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[purchasedetails_id] [int] NOT NULL,
	[purchase_id] [int] NULL,
	[product_id] [int] NULL,
	[batch_id] [int] NULL,
	[tax_id] [int] NULL,
	[unit_id] [int] NULL,
	[tax_amt] [decimal](18, 0) NULL,
	[dicount_amt] [decimal](18, 0) NULL,
	[quantity] [decimal](18, 0) NULL,
	[amount] [decimal](18, 0) NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[status] [bit] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
 CONSTRAINT [PK_tbl_purchasedetailsHistoryHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchaseHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchaseHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[purchase_id] [int] NOT NULL,
	[party_id] [int] NULL,
	[financialyear_id] [int] NULL,
	[po_no] [nvarchar](100) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[Po_Date] [smalldatetime] NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[PaymentMode_id] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[other_expenses] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_purchaseHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_PurchasePaymentDetials]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PurchasePaymentDetials](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseId] [int] NULL,
	[SubTotal] [decimal](18, 0) NULL,
	[TaxAmount] [decimal](18, 0) NULL,
	[DiscountAmount] [decimal](18, 0) NULL,
	[GrandTotal] [decimal](18, 0) NULL,
	[PaidAmnt] [decimal](18, 0) NULL,
	[GivenAmnt] [decimal](18, 0) NULL,
	[BalanceAmnt] [decimal](18, 0) NULL,
	[FromTable] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_PurchasePaymentDetials] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_PurchasePaymentDetialsHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PurchasePaymentDetialsHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchasePaymentId] [int] NULL,
	[PurchaseId] [int] NULL,
	[SubTotal] [decimal](18, 0) NULL,
	[TaxAmount] [decimal](18, 0) NULL,
	[DiscountAmount] [decimal](18, 0) NULL,
	[GrandTotal] [decimal](18, 0) NULL,
	[PaidAmnt] [decimal](18, 0) NULL,
	[GivenAmnt] [decimal](18, 0) NULL,
	[BalanceAmnt] [decimal](18, 0) NULL,
	[FromTable] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_PurchasePaymentDetialsHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchasereturn]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchasereturn](
	[purchasereturn_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[purchase_id] [int] NULL,
	[financialyear_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[party_id] [int] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[paymentmode_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[purchasereturn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchasereturndetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchasereturndetails](
	[purchasereturndetails_id] [int] IDENTITY(1,1) NOT NULL,
	[batch_id] [int] NULL,
	[product_id] [int] NULL,
	[unit_id] [int] NULL,
	[tax_amt] [nvarchar](100) NULL,
	[quantity] [decimal](18, 0) NULL,
	[amount] [decimal](18, 0) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[purchasereturn_id] [int] NULL,
	[discount_amnt] [decimal](18, 0) NULL,
	[Purchase_taxGroupId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[purchasereturndetails_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchasereturndetailsHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchasereturndetailsHistory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[purchasereturndetails_id] [int] NULL,
	[batch_id] [int] NULL,
	[product_id] [int] NULL,
	[unit_id] [int] NULL,
	[tax_amt] [nvarchar](100) NULL,
	[quantity] [decimal](18, 0) NULL,
	[amount] [decimal](18, 0) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[purchasereturn_id] [int] NULL,
	[discount_amnt] [decimal](18, 0) NULL,
	[Purchase_taxGroupId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchasereturnHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchasereturnHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[purchasereturn_id] [int] NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[purchase_id] [int] NULL,
	[financialyear_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[party_id] [int] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[paymentmode_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchasetaxdetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchasetaxdetails](
	[purchasetaxdetails_id] [int] IDENTITY(1,1) NOT NULL,
	[purchasetaxgroup_id] [int] NULL,
	[type_id] [int] NULL,
	[tax_percentage] [decimal](18, 0) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[purchaseId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[purchasetaxdetails_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_purchasetaxgroup]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_purchasetaxgroup](
	[purchasetaxgroup_id] [int] IDENTITY(1,1) NOT NULL,
	[group_name] [nvarchar](500) NULL,
	[product_id] [int] NULL,
	[group_id] [int] NULL,
	[purchaseId] [int] NULL,
	[totalTaxPercentage] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[purchasetaxgroup_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_rack]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rack](
	[rack_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[rack_name] [nvarchar](50) NULL,
	[godown_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[rack_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_role]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_role](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_sale]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sale](
	[sale_id] [int] IDENTITY(1,1) NOT NULL,
	[party_id] [int] NULL,
	[financialyear_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[paymentmode_id] [int] NULL,
	[sale_date] [smalldatetime] NULL,
	[Note] [nvarchar](max) NULL,
	[other_expenses] [decimal](18, 0) NULL,
 CONSTRAINT [PK__tbl_sale__E1EB00B2BB8871EA] PRIMARY KEY CLUSTERED 
(
	[sale_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_saledetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_saledetails](
	[saledetails_id] [int] IDENTITY(1,1) NOT NULL,
	[sale_id] [int] NULL,
	[product_id] [int] NULL,
	[batch_id] [int] NULL,
	[tax_id] [int] NULL,
	[unit_id] [int] NULL,
	[tax_amt] [decimal](18, 0) NULL,
	[dicount_amt] [decimal](18, 0) NULL,
	[quantity] [decimal](18, 0) NULL,
	[amount] [decimal](18, 0) NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[status] [bit] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[saledetails_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_saledetailsHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_saledetailsHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[saledetails_id] [int] NULL,
	[sale_id] [int] NULL,
	[product_id] [int] NULL,
	[batch_id] [int] NULL,
	[tax_id] [int] NULL,
	[unit_id] [int] NULL,
	[tax_amt] [decimal](18, 0) NULL,
	[dicount_amt] [decimal](18, 0) NULL,
	[quantity] [decimal](18, 0) NULL,
	[amount] [decimal](18, 0) NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[status] [bit] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_saleHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_saleHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[sale_id] [int] NULL,
	[party_id] [int] NULL,
	[financialyear_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[paymentmode_id] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[other_expenses] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SalePaymentDetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SalePaymentDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SaleId] [int] NULL,
	[SubTotal] [decimal](18, 0) NULL,
	[TaxAmount] [decimal](18, 0) NULL,
	[DiscountAmount] [decimal](18, 0) NULL,
	[GrandTotal] [decimal](18, 0) NULL,
	[PaidAmnt] [decimal](18, 0) NULL,
	[GivenAmnt] [decimal](18, 0) NULL,
	[BalanceAmnt] [decimal](18, 0) NULL,
	[FromTable] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_SalePaymentDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SalePaymentDetailsHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SalePaymentDetailsHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalePaymentDetailsId] [int] NOT NULL,
	[SaleId] [int] NULL,
	[SubTotal] [decimal](18, 0) NULL,
	[TaxAmount] [decimal](18, 0) NULL,
	[DiscountAmount] [decimal](18, 0) NULL,
	[GrandTotal] [decimal](18, 0) NULL,
	[PaidAmnt] [decimal](18, 0) NULL,
	[GivenAmnt] [decimal](18, 0) NULL,
	[BalanceAmnt] [decimal](18, 0) NULL,
	[FromTable] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_SalePaymentDetailsHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_salereturn]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_salereturn](
	[salereturn_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[sale_id] [int] NULL,
	[financialyear_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[paymentmode_id] [int] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[party_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[salereturn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_salereturndetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_salereturndetails](
	[salesreturndetails_id] [int] IDENTITY(1,1) NOT NULL,
	[batch_id] [int] NULL,
	[product_id] [int] NULL,
	[unit_id] [int] NULL,
	[tax_amt] [decimal](18, 0) NULL,
	[quantity] [decimal](18, 0) NULL,
	[amount] [decimal](18, 0) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[dicount_amt] [decimal](18, 0) NULL,
	[salereturn_id] [int] NULL,
	[Sales_taxGroupId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[salesreturndetails_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_salereturndetailsHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_salereturndetailsHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[salesreturndetails_id] [int] NULL,
	[batch_id] [int] NULL,
	[product_id] [int] NULL,
	[unit_id] [int] NULL,
	[tax_amt] [decimal](18, 0) NULL,
	[quantity] [decimal](18, 0) NULL,
	[amount] [decimal](18, 0) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[dicount_amt] [decimal](18, 0) NULL,
	[salereturn_id] [int] NULL,
	[Sales_taxGroupId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_salereturnHistory]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_salereturnHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[salereturn_id] [int] NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[sale_id] [int] NULL,
	[financialyear_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[paymentmode_id] [int] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[party_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_saleTaxGroup]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_saleTaxGroup](
	[SaleTaxGroupId] [int] IDENTITY(1,1) NOT NULL,
	[group_name] [nvarchar](50) NULL,
	[product_id] [int] NULL,
	[group_id] [int] NULL,
	[sale_id] [int] NULL,
	[totalTaxPercentage] [decimal](18, 2) NULL,
 CONSTRAINT [PK_tbl_saleTaxGroup] PRIMARY KEY CLUSTERED 
(
	[SaleTaxGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_saleTaxGroupDetailes]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_saleTaxGroupDetailes](
	[saleTaxGroupDetail_Id] [int] IDENTITY(1,1) NOT NULL,
	[SaleTaxGroupId] [int] NULL,
	[type_id] [int] NULL,
	[tax_percentage] [decimal](18, 2) NULL,
	[sale_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](50) NULL,
	[modified_date] [smalldatetime] NULL,
 CONSTRAINT [PK_tbl_saleTaxGroupDetailes] PRIMARY KEY CLUSTERED 
(
	[saleTaxGroupDetail_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_setting]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_setting](
	[setting_id] [int] IDENTITY(1,1) NOT NULL,
	[Decimal_Places] [int] NULL,
	[currency_id] [int] NULL,
	[Enable_Invoice_Tax] [bit] NULL,
	[Print_Tin_on_Invoice] [bit] NULL,
	[Print_address] [bit] NULL,
	[status] [bit] NULL,
	[user_id] [int] NULL,
	[branch_id] [int] NULL,
	[company_id] [int] NULL,
	[created_by] [nvarchar](max) NULL,
	[created_date] [datetime] NULL,
	[modify_by] [nvarchar](max) NULL,
	[modifydate] [datetime] NULL,
 CONSTRAINT [PK_tbl_setting] PRIMARY KEY CLUSTERED 
(
	[setting_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_state]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_state](
	[state_id] [int] IDENTITY(1,1) NOT NULL,
	[country_id] [int] NULL,
	[state_name] [nvarchar](500) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_stock]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_stock](
	[stock_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[product_id] [int] NULL,
	[batch_id] [int] NULL,
	[qty] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[stock_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_stocktransaction]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_stocktransaction](
	[stockt_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[stocktransaction_typ_id] [int] NULL,
	[stocktransaction_typ] [varchar](20) NULL,
	[product_id] [int] NULL,
	[batch_id] [int] NULL,
	[qty] [int] NULL,
	[in_out] [varchar](20) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[transactio_type_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[stockt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_subscription]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_subscription](
	[subscription_id] [int] IDENTITY(1,1) NOT NULL,
	[plan_id] [int] NULL,
	[user_id] [int] NULL,
	[start_date] [smalldatetime] NULL,
	[end_date] [smalldatetime] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[company_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[subscription_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_tax]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tax](
	[tax_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[tax_name] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[tax_percentage] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[tax_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_taxdetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_taxdetails](
	[taxdetails_id] [int] IDENTITY(1,1) NOT NULL,
	[group_id] [int] NULL,
	[type_id] [int] NULL,
	[tax_percentage] [decimal](18, 0) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[taxdetails_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_taxgroup]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_taxgroup](
	[group_id] [int] IDENTITY(1,1) NOT NULL,
	[group_name] [nvarchar](500) NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_taxtype]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_taxtype](
	[type_id] [int] IDENTITY(1,1) NOT NULL,
	[type_name] [nvarchar](500) NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_unit]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_unit](
	[unit_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[branch_id] [int] NULL,
	[unit_name] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[unit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_User]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_User](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[user_name] [nvarchar](50) NULL,
	[user_Emai] [nvarchar](50) NULL,
	[user_mobieno] [nvarchar](500) NULL,
	[password] [nvarchar](500) NULL,
	[retry_attempts] [int] NULL,
	[last_login] [smalldatetime] NULL,
	[islocked] [bit] NULL,
	[locked_date] [smalldatetime] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[first_name] [nvarchar](100) NULL,
	[last_name] [nvarchar](100) NULL,
	[Ref_Mobile] [nvarchar](max) NULL,
	[OTP] [nvarchar](max) NULL,
	[IsVerified] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_userbranch]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userbranch](
	[userbranch_id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NULL,
	[user_id] [int] NULL,
	[branch_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
	[company_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[userbranch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_userrole]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userrole](
	[userrole_id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NULL,
	[user_id] [int] NULL,
	[status] [bit] NULL,
	[created_by] [nvarchar](500) NULL,
	[created_date] [smalldatetime] NULL,
	[modified_by] [nvarchar](500) NULL,
	[modified_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[userrole_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_VerifyResetPass]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_VerifyResetPass](
	[Passverify_ID] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [nvarchar](500) NULL,
	[uniqueidentifier] [nvarchar](max) NULL,
	[status] [bit] NULL,
	[created_date] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Passverify_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_PurchaseDetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_PurchaseDetails]
AS
SELECT dbo.tbl_company.company_name, dbo.tbl_company.company_id, dbo.tbl_company.company_address, dbo.tbl_unit.unit_name, dbo.tbl_tax.tax_name, dbo.tbl_ActualPurchaseTaxAndPrice.purchase_rate, 
                  dbo.tbl_ActualPurchaseTaxAndPrice.discount_amnt, dbo.tbl_ActualPurchaseTaxAndPrice.tax_percent, dbo.tbl_ActualPurchaseTaxAndPrice.sale_price, dbo.tbl_ActualPurchaseTaxAndPrice.discount_percent, dbo.tbl_purchase.status, 
                  dbo.tbl_purchase.Po_Date, dbo.tbl_purchase.InvoiceNumber, dbo.tbl_purchasedetails.quantity, dbo.tbl_purchasedetails.dicount_amt, dbo.tbl_purchasedetails.tax_amt, dbo.tbl_product.product_name, dbo.tbl_product.reorder_level, 
                  dbo.tbl_product.product_code, dbo.tbl_purchase.purchase_id, dbo.tbl_PurchasePaymentDetials.SubTotal, dbo.tbl_PurchasePaymentDetials.TaxAmount, dbo.tbl_PurchasePaymentDetials.DiscountAmount, 
                  dbo.tbl_PurchasePaymentDetials.GrandTotal, dbo.tbl_PurchasePaymentDetials.GivenAmnt, dbo.tbl_PurchasePaymentDetials.BalanceAmnt, dbo.tbl_PurchasePaymentDetials.FromTable
FROM     dbo.tbl_ActualPurchaseTaxAndPrice INNER JOIN
                  dbo.tbl_purchase ON dbo.tbl_ActualPurchaseTaxAndPrice.purchase_id = dbo.tbl_purchase.purchase_id INNER JOIN
                  dbo.tbl_purchasedetails ON dbo.tbl_purchase.purchase_id = dbo.tbl_purchasedetails.purchase_id INNER JOIN
                  dbo.tbl_company ON dbo.tbl_purchase.company_id = dbo.tbl_company.company_id INNER JOIN
                  dbo.tbl_unit ON dbo.tbl_purchasedetails.unit_id = dbo.tbl_unit.unit_id INNER JOIN
                  dbo.tbl_tax ON dbo.tbl_purchasedetails.tax_id = dbo.tbl_tax.tax_id INNER JOIN
                  dbo.tbl_product ON dbo.tbl_ActualPurchaseTaxAndPrice.product_id = dbo.tbl_product.product_id INNER JOIN
                  dbo.tbl_PurchasePaymentDetials ON dbo.tbl_purchase.purchase_id = dbo.tbl_PurchasePaymentDetials.PurchaseId

GO
/****** Object:  View [dbo].[View_SaleDetails]    Script Date: 3/14/2019 3:41:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SaleDetails]
AS
SELECT dbo.tbl_tax.tax_name, dbo.tbl_unit.unit_name, dbo.tbl_sale.status, dbo.tbl_sale.InvoiceNumber, dbo.tbl_sale.sale_date, dbo.tbl_product.product_code, dbo.tbl_ActualSalesTaxAndPrice.tax_percent, 
                  dbo.tbl_ActualSalesTaxAndPrice.sale_rate, dbo.tbl_ActualSalesTaxAndPrice.discount_amnt, dbo.tbl_saledetails.quantity, dbo.tbl_company.company_name, dbo.tbl_company.company_address, dbo.tbl_company.company_id, 
                  dbo.tbl_sale.financialyear_id, dbo.tbl_financialyear.start_date, dbo.tbl_financialyear.end_date, dbo.tbl_sale.sale_id, dbo.tbl_SalePaymentDetails.SubTotal, dbo.tbl_SalePaymentDetails.TaxAmount, dbo.tbl_SalePaymentDetails.GrandTotal, 
                  dbo.tbl_SalePaymentDetails.DiscountAmount, dbo.tbl_SalePaymentDetails.GivenAmnt, dbo.tbl_SalePaymentDetails.BalanceAmnt, dbo.tbl_SalePaymentDetails.FromTable
FROM     dbo.tbl_ActualSalesTaxAndPrice INNER JOIN
                  dbo.tbl_sale ON dbo.tbl_ActualSalesTaxAndPrice.sale_id = dbo.tbl_sale.sale_id INNER JOIN
                  dbo.tbl_saledetails ON dbo.tbl_sale.sale_id = dbo.tbl_saledetails.sale_id INNER JOIN
                  dbo.tbl_unit ON dbo.tbl_saledetails.unit_id = dbo.tbl_unit.unit_id INNER JOIN
                  dbo.tbl_tax ON dbo.tbl_saledetails.tax_id = dbo.tbl_tax.tax_id INNER JOIN
                  dbo.tbl_company ON dbo.tbl_sale.company_id = dbo.tbl_company.company_id INNER JOIN
                  dbo.tbl_product ON dbo.tbl_ActualSalesTaxAndPrice.product_id = dbo.tbl_product.product_id INNER JOIN
                  dbo.tbl_financialyear ON dbo.tbl_sale.financialyear_id = dbo.tbl_financialyear.financialyear_id INNER JOIN
                  dbo.tbl_SalePaymentDetails ON dbo.tbl_sale.sale_id = dbo.tbl_SalePaymentDetails.SaleId

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ELMAH_Error_App_Time_Seq]    Script Date: 3/14/2019 3:41:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_ELMAH_Error_App_Time_Seq] ON [dbo].[ELMAH_Error]
(
	[Application] ASC,
	[TimeUtc] DESC,
	[Sequence] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_ActualPurchaseTaxAndPrice]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_ActualPurchaseTaxAndPrice]  WITH CHECK ADD FOREIGN KEY([purchaseTaxId])
REFERENCES [dbo].[tbl_purchasetaxgroup] ([purchasetaxgroup_id])
GO
ALTER TABLE [dbo].[tbl_ActualPurchaseTaxAndPrice]  WITH CHECK ADD  CONSTRAINT [FK__tbl_Actua__purch__4EDDB18F] FOREIGN KEY([purchase_id])
REFERENCES [dbo].[tbl_purchase] ([purchase_id])
GO
ALTER TABLE [dbo].[tbl_ActualPurchaseTaxAndPrice] CHECK CONSTRAINT [FK__tbl_Actua__purch__4EDDB18F]
GO
ALTER TABLE [dbo].[tbl_ActualPurchaseTaxAndPrice]  WITH CHECK ADD  CONSTRAINT [FK_tbl_ActualPurchaseTaxAndPrice_tbl_batch] FOREIGN KEY([batch_id])
REFERENCES [dbo].[tbl_batch] ([batch_id])
GO
ALTER TABLE [dbo].[tbl_ActualPurchaseTaxAndPrice] CHECK CONSTRAINT [FK_tbl_ActualPurchaseTaxAndPrice_tbl_batch]
GO
ALTER TABLE [dbo].[tbl_ActualSalesTaxAndPrice]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_ActualSalesTaxAndPrice]  WITH CHECK ADD  CONSTRAINT [FK__tbl_Actua__sale___5D2BD0E6] FOREIGN KEY([sale_id])
REFERENCES [dbo].[tbl_sale] ([sale_id])
GO
ALTER TABLE [dbo].[tbl_ActualSalesTaxAndPrice] CHECK CONSTRAINT [FK__tbl_Actua__sale___5D2BD0E6]
GO
ALTER TABLE [dbo].[tbl_ActualSalesTaxAndPrice]  WITH CHECK ADD  CONSTRAINT [FK_tbl_ActualSalesTaxAndPrice_tbl_saleTaxGroup] FOREIGN KEY([saleTaxGroupID])
REFERENCES [dbo].[tbl_saleTaxGroup] ([SaleTaxGroupId])
GO
ALTER TABLE [dbo].[tbl_ActualSalesTaxAndPrice] CHECK CONSTRAINT [FK_tbl_ActualSalesTaxAndPrice_tbl_saleTaxGroup]
GO
ALTER TABLE [dbo].[tbl_batch]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_batch]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_branch]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_branch]  WITH CHECK ADD FOREIGN KEY([country_id])
REFERENCES [dbo].[tbl_country] ([country_id])
GO
ALTER TABLE [dbo].[tbl_branch]  WITH CHECK ADD FOREIGN KEY([state_id])
REFERENCES [dbo].[tbl_state] ([state_id])
GO
ALTER TABLE [dbo].[tbl_category]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_category]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_company]  WITH CHECK ADD FOREIGN KEY([country_id])
REFERENCES [dbo].[tbl_country] ([country_id])
GO
ALTER TABLE [dbo].[tbl_company]  WITH CHECK ADD FOREIGN KEY([state_id])
REFERENCES [dbo].[tbl_state] ([state_id])
GO
ALTER TABLE [dbo].[tbl_expense]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_expense]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_expenseentry]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_expenseentry]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_expenseentry]  WITH CHECK ADD FOREIGN KEY([expense_id])
REFERENCES [dbo].[tbl_expense] ([expense_id])
GO
ALTER TABLE [dbo].[tbl_financialyear]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_financialyear]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_godown]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_godown]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_mony]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_mony]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_mony]  WITH CHECK ADD FOREIGN KEY([party_id])
REFERENCES [dbo].[tbl_party] ([party_id])
GO
ALTER TABLE [dbo].[tbl_monytransaction]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_monytransaction]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_monytransaction]  WITH CHECK ADD FOREIGN KEY([party_id])
REFERENCES [dbo].[tbl_party] ([party_id])
GO
ALTER TABLE [dbo].[tbl_monytransaction]  WITH CHECK ADD FOREIGN KEY([paymentmode_id])
REFERENCES [dbo].[tbl_paymentmode] ([paymentode_id])
GO
ALTER TABLE [dbo].[tbl_paidpayment]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_paidpayment]  WITH CHECK ADD FOREIGN KEY([subscription_id])
REFERENCES [dbo].[tbl_subscription] ([subscription_id])
GO
ALTER TABLE [dbo].[tbl_paidpayment]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[tbl_User] ([user_id])
GO
ALTER TABLE [dbo].[tbl_party]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_party]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_party]  WITH CHECK ADD FOREIGN KEY([state_id])
REFERENCES [dbo].[tbl_state] ([state_id])
GO
ALTER TABLE [dbo].[tbl_paymentmode]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_paymentmode]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[tbl_category] ([category_id])
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD FOREIGN KEY([godown_id])
REFERENCES [dbo].[tbl_godown] ([godown_id])
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD FOREIGN KEY([rack_id])
REFERENCES [dbo].[tbl_rack] ([rack_id])
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD FOREIGN KEY([unit_id])
REFERENCES [dbo].[tbl_unit] ([unit_id])
GO
ALTER TABLE [dbo].[tbl_productTaxGroup]  WITH CHECK ADD FOREIGN KEY([group_id])
REFERENCES [dbo].[tbl_taxgroup] ([group_id])
GO
ALTER TABLE [dbo].[tbl_productTaxGroup]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__branc__2B0A656D] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK__tbl_purch__branc__2B0A656D]
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__branc__60FC61CA] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK__tbl_purch__branc__60FC61CA]
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__compa__2A164134] FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK__tbl_purch__compa__2A164134]
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__compa__61F08603] FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK__tbl_purch__compa__61F08603]
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__finan__62E4AA3C] FOREIGN KEY([financialyear_id])
REFERENCES [dbo].[tbl_financialyear] ([financialyear_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK__tbl_purch__finan__62E4AA3C]
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__finan__74AE54BC] FOREIGN KEY([financialyear_id])
REFERENCES [dbo].[tbl_financialyear] ([financialyear_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK__tbl_purch__finan__74AE54BC]
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__party__63D8CE75] FOREIGN KEY([party_id])
REFERENCES [dbo].[tbl_party] ([party_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK__tbl_purch__party__63D8CE75]
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__party__73BA3083] FOREIGN KEY([party_id])
REFERENCES [dbo].[tbl_party] ([party_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK__tbl_purch__party__73BA3083]
GO
ALTER TABLE [dbo].[tbl_purchase]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchase_tbl_paymentmode] FOREIGN KEY([PaymentMode_id])
REFERENCES [dbo].[tbl_paymentmode] ([paymentode_id])
GO
ALTER TABLE [dbo].[tbl_purchase] CHECK CONSTRAINT [FK_tbl_purchase_tbl_paymentmode]
GO
ALTER TABLE [dbo].[tbl_purchasedetails]  WITH CHECK ADD FOREIGN KEY([batch_id])
REFERENCES [dbo].[tbl_batch] ([batch_id])
GO
ALTER TABLE [dbo].[tbl_purchasedetails]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_purchasedetails]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__purch__778AC167] FOREIGN KEY([purchase_id])
REFERENCES [dbo].[tbl_purchase] ([purchase_id])
GO
ALTER TABLE [dbo].[tbl_purchasedetails] CHECK CONSTRAINT [FK__tbl_purch__purch__778AC167]
GO
ALTER TABLE [dbo].[tbl_purchasedetails]  WITH CHECK ADD FOREIGN KEY([tax_id])
REFERENCES [dbo].[tbl_tax] ([tax_id])
GO
ALTER TABLE [dbo].[tbl_purchasedetails]  WITH CHECK ADD FOREIGN KEY([unit_id])
REFERENCES [dbo].[tbl_unit] ([unit_id])
GO
ALTER TABLE [dbo].[tbl_PurchasePaymentDetials]  WITH CHECK ADD  CONSTRAINT [FK_tbl_PurchasePaymentDetials_tbl_PurchasePaymentDetials] FOREIGN KEY([PurchaseId])
REFERENCES [dbo].[tbl_purchase] ([purchase_id])
GO
ALTER TABLE [dbo].[tbl_PurchasePaymentDetials] CHECK CONSTRAINT [FK_tbl_PurchasePaymentDetials_tbl_PurchasePaymentDetials]
GO
ALTER TABLE [dbo].[tbl_purchasereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturn_tbl_branch] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturn] CHECK CONSTRAINT [FK_tbl_purchasereturn_tbl_branch]
GO
ALTER TABLE [dbo].[tbl_purchasereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturn_tbl_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturn] CHECK CONSTRAINT [FK_tbl_purchasereturn_tbl_company]
GO
ALTER TABLE [dbo].[tbl_purchasereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturn_tbl_financialyear] FOREIGN KEY([financialyear_id])
REFERENCES [dbo].[tbl_financialyear] ([financialyear_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturn] CHECK CONSTRAINT [FK_tbl_purchasereturn_tbl_financialyear]
GO
ALTER TABLE [dbo].[tbl_purchasereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturn_tbl_party] FOREIGN KEY([party_id])
REFERENCES [dbo].[tbl_party] ([party_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturn] CHECK CONSTRAINT [FK_tbl_purchasereturn_tbl_party]
GO
ALTER TABLE [dbo].[tbl_purchasereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturn_tbl_paymentmode] FOREIGN KEY([paymentmode_id])
REFERENCES [dbo].[tbl_paymentmode] ([paymentode_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturn] CHECK CONSTRAINT [FK_tbl_purchasereturn_tbl_paymentmode]
GO
ALTER TABLE [dbo].[tbl_purchasereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturn_tbl_purchasereturn] FOREIGN KEY([purchase_id])
REFERENCES [dbo].[tbl_purchase] ([purchase_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturn] CHECK CONSTRAINT [FK_tbl_purchasereturn_tbl_purchasereturn]
GO
ALTER TABLE [dbo].[tbl_purchasereturndetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturndetails_tbl_batch] FOREIGN KEY([batch_id])
REFERENCES [dbo].[tbl_batch] ([batch_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturndetails] CHECK CONSTRAINT [FK_tbl_purchasereturndetails_tbl_batch]
GO
ALTER TABLE [dbo].[tbl_purchasereturndetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturndetails_tbl_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturndetails] CHECK CONSTRAINT [FK_tbl_purchasereturndetails_tbl_product]
GO
ALTER TABLE [dbo].[tbl_purchasereturndetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturndetails_tbl_purchasereturn] FOREIGN KEY([purchasereturn_id])
REFERENCES [dbo].[tbl_purchasereturn] ([purchasereturn_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturndetails] CHECK CONSTRAINT [FK_tbl_purchasereturndetails_tbl_purchasereturn]
GO
ALTER TABLE [dbo].[tbl_purchasereturndetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_purchasereturndetails_tbl_unit] FOREIGN KEY([unit_id])
REFERENCES [dbo].[tbl_unit] ([unit_id])
GO
ALTER TABLE [dbo].[tbl_purchasereturndetails] CHECK CONSTRAINT [FK_tbl_purchasereturndetails_tbl_unit]
GO
ALTER TABLE [dbo].[tbl_purchasetaxdetails]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__purch__42CCE065] FOREIGN KEY([purchaseId])
REFERENCES [dbo].[tbl_purchase] ([purchase_id])
GO
ALTER TABLE [dbo].[tbl_purchasetaxdetails] CHECK CONSTRAINT [FK__tbl_purch__purch__42CCE065]
GO
ALTER TABLE [dbo].[tbl_purchasetaxdetails]  WITH CHECK ADD FOREIGN KEY([purchasetaxgroup_id])
REFERENCES [dbo].[tbl_purchasetaxgroup] ([purchasetaxgroup_id])
GO
ALTER TABLE [dbo].[tbl_purchasetaxdetails]  WITH CHECK ADD FOREIGN KEY([type_id])
REFERENCES [dbo].[tbl_taxtype] ([type_id])
GO
ALTER TABLE [dbo].[tbl_purchasetaxgroup]  WITH CHECK ADD FOREIGN KEY([group_id])
REFERENCES [dbo].[tbl_taxgroup] ([group_id])
GO
ALTER TABLE [dbo].[tbl_purchasetaxgroup]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_purchasetaxgroup]  WITH CHECK ADD  CONSTRAINT [FK__tbl_purch__purch__09946309] FOREIGN KEY([purchaseId])
REFERENCES [dbo].[tbl_purchase] ([purchase_id])
GO
ALTER TABLE [dbo].[tbl_purchasetaxgroup] CHECK CONSTRAINT [FK__tbl_purch__purch__09946309]
GO
ALTER TABLE [dbo].[tbl_rack]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_rack]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_rack]  WITH CHECK ADD FOREIGN KEY([godown_id])
REFERENCES [dbo].[tbl_godown] ([godown_id])
GO
ALTER TABLE [dbo].[tbl_sale]  WITH CHECK ADD  CONSTRAINT [FK_tbl_sale_tbl_branch] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_sale] CHECK CONSTRAINT [FK_tbl_sale_tbl_branch]
GO
ALTER TABLE [dbo].[tbl_sale]  WITH CHECK ADD  CONSTRAINT [FK_tbl_sale_tbl_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_sale] CHECK CONSTRAINT [FK_tbl_sale_tbl_company]
GO
ALTER TABLE [dbo].[tbl_sale]  WITH CHECK ADD  CONSTRAINT [FK_tbl_sale_tbl_financialyear] FOREIGN KEY([financialyear_id])
REFERENCES [dbo].[tbl_financialyear] ([financialyear_id])
GO
ALTER TABLE [dbo].[tbl_sale] CHECK CONSTRAINT [FK_tbl_sale_tbl_financialyear]
GO
ALTER TABLE [dbo].[tbl_sale]  WITH CHECK ADD  CONSTRAINT [FK_tbl_sale_tbl_party] FOREIGN KEY([party_id])
REFERENCES [dbo].[tbl_party] ([party_id])
GO
ALTER TABLE [dbo].[tbl_sale] CHECK CONSTRAINT [FK_tbl_sale_tbl_party]
GO
ALTER TABLE [dbo].[tbl_sale]  WITH CHECK ADD  CONSTRAINT [FK_tbl_sale_tbl_paymentmode] FOREIGN KEY([paymentmode_id])
REFERENCES [dbo].[tbl_paymentmode] ([paymentode_id])
GO
ALTER TABLE [dbo].[tbl_sale] CHECK CONSTRAINT [FK_tbl_sale_tbl_paymentmode]
GO
ALTER TABLE [dbo].[tbl_saledetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saledetails_tbl_batch] FOREIGN KEY([batch_id])
REFERENCES [dbo].[tbl_batch] ([batch_id])
GO
ALTER TABLE [dbo].[tbl_saledetails] CHECK CONSTRAINT [FK_tbl_saledetails_tbl_batch]
GO
ALTER TABLE [dbo].[tbl_saledetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saledetails_tbl_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_saledetails] CHECK CONSTRAINT [FK_tbl_saledetails_tbl_product]
GO
ALTER TABLE [dbo].[tbl_saledetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saledetails_tbl_sale] FOREIGN KEY([sale_id])
REFERENCES [dbo].[tbl_sale] ([sale_id])
GO
ALTER TABLE [dbo].[tbl_saledetails] CHECK CONSTRAINT [FK_tbl_saledetails_tbl_sale]
GO
ALTER TABLE [dbo].[tbl_saledetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saledetails_tbl_tax] FOREIGN KEY([tax_id])
REFERENCES [dbo].[tbl_tax] ([tax_id])
GO
ALTER TABLE [dbo].[tbl_saledetails] CHECK CONSTRAINT [FK_tbl_saledetails_tbl_tax]
GO
ALTER TABLE [dbo].[tbl_saledetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saledetails_tbl_unit] FOREIGN KEY([unit_id])
REFERENCES [dbo].[tbl_unit] ([unit_id])
GO
ALTER TABLE [dbo].[tbl_saledetails] CHECK CONSTRAINT [FK_tbl_saledetails_tbl_unit]
GO
ALTER TABLE [dbo].[tbl_SalePaymentDetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_SalePaymentDetails_tbl_sale] FOREIGN KEY([SaleId])
REFERENCES [dbo].[tbl_sale] ([sale_id])
GO
ALTER TABLE [dbo].[tbl_SalePaymentDetails] CHECK CONSTRAINT [FK_tbl_SalePaymentDetails_tbl_sale]
GO
ALTER TABLE [dbo].[tbl_salereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturn_tbl_branch] FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_salereturn] CHECK CONSTRAINT [FK_tbl_salereturn_tbl_branch]
GO
ALTER TABLE [dbo].[tbl_salereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturn_tbl_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_salereturn] CHECK CONSTRAINT [FK_tbl_salereturn_tbl_company]
GO
ALTER TABLE [dbo].[tbl_salereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturn_tbl_financialyear] FOREIGN KEY([financialyear_id])
REFERENCES [dbo].[tbl_financialyear] ([financialyear_id])
GO
ALTER TABLE [dbo].[tbl_salereturn] CHECK CONSTRAINT [FK_tbl_salereturn_tbl_financialyear]
GO
ALTER TABLE [dbo].[tbl_salereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturn_tbl_party] FOREIGN KEY([party_id])
REFERENCES [dbo].[tbl_party] ([party_id])
GO
ALTER TABLE [dbo].[tbl_salereturn] CHECK CONSTRAINT [FK_tbl_salereturn_tbl_party]
GO
ALTER TABLE [dbo].[tbl_salereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturn_tbl_paymentmode] FOREIGN KEY([paymentmode_id])
REFERENCES [dbo].[tbl_paymentmode] ([paymentode_id])
GO
ALTER TABLE [dbo].[tbl_salereturn] CHECK CONSTRAINT [FK_tbl_salereturn_tbl_paymentmode]
GO
ALTER TABLE [dbo].[tbl_salereturn]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturn_tbl_sale] FOREIGN KEY([sale_id])
REFERENCES [dbo].[tbl_sale] ([sale_id])
GO
ALTER TABLE [dbo].[tbl_salereturn] CHECK CONSTRAINT [FK_tbl_salereturn_tbl_sale]
GO
ALTER TABLE [dbo].[tbl_salereturndetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturndetails_tbl_batch] FOREIGN KEY([batch_id])
REFERENCES [dbo].[tbl_batch] ([batch_id])
GO
ALTER TABLE [dbo].[tbl_salereturndetails] CHECK CONSTRAINT [FK_tbl_salereturndetails_tbl_batch]
GO
ALTER TABLE [dbo].[tbl_salereturndetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturndetails_tbl_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_salereturndetails] CHECK CONSTRAINT [FK_tbl_salereturndetails_tbl_product]
GO
ALTER TABLE [dbo].[tbl_salereturndetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturndetails_tbl_salereturn] FOREIGN KEY([salereturn_id])
REFERENCES [dbo].[tbl_salereturn] ([salereturn_id])
GO
ALTER TABLE [dbo].[tbl_salereturndetails] CHECK CONSTRAINT [FK_tbl_salereturndetails_tbl_salereturn]
GO
ALTER TABLE [dbo].[tbl_salereturndetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_salereturndetails_tbl_unit] FOREIGN KEY([unit_id])
REFERENCES [dbo].[tbl_unit] ([unit_id])
GO
ALTER TABLE [dbo].[tbl_salereturndetails] CHECK CONSTRAINT [FK_tbl_salereturndetails_tbl_unit]
GO
ALTER TABLE [dbo].[tbl_saleTaxGroup]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saleTaxGroup_tbl_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_saleTaxGroup] CHECK CONSTRAINT [FK_tbl_saleTaxGroup_tbl_product]
GO
ALTER TABLE [dbo].[tbl_saleTaxGroup]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saleTaxGroup_tbl_sale] FOREIGN KEY([sale_id])
REFERENCES [dbo].[tbl_sale] ([sale_id])
GO
ALTER TABLE [dbo].[tbl_saleTaxGroup] CHECK CONSTRAINT [FK_tbl_saleTaxGroup_tbl_sale]
GO
ALTER TABLE [dbo].[tbl_saleTaxGroup]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saleTaxGroup_tbl_taxgroup] FOREIGN KEY([group_id])
REFERENCES [dbo].[tbl_taxgroup] ([group_id])
GO
ALTER TABLE [dbo].[tbl_saleTaxGroup] CHECK CONSTRAINT [FK_tbl_saleTaxGroup_tbl_taxgroup]
GO
ALTER TABLE [dbo].[tbl_saleTaxGroupDetailes]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saleTaxGroupDetailes_tbl_sale] FOREIGN KEY([sale_id])
REFERENCES [dbo].[tbl_sale] ([sale_id])
GO
ALTER TABLE [dbo].[tbl_saleTaxGroupDetailes] CHECK CONSTRAINT [FK_tbl_saleTaxGroupDetailes_tbl_sale]
GO
ALTER TABLE [dbo].[tbl_saleTaxGroupDetailes]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saleTaxGroupDetailes_tbl_saleTaxGroup] FOREIGN KEY([SaleTaxGroupId])
REFERENCES [dbo].[tbl_saleTaxGroup] ([SaleTaxGroupId])
GO
ALTER TABLE [dbo].[tbl_saleTaxGroupDetailes] CHECK CONSTRAINT [FK_tbl_saleTaxGroupDetailes_tbl_saleTaxGroup]
GO
ALTER TABLE [dbo].[tbl_saleTaxGroupDetailes]  WITH CHECK ADD  CONSTRAINT [FK_tbl_saleTaxGroupDetailes_tbl_taxtype] FOREIGN KEY([type_id])
REFERENCES [dbo].[tbl_taxtype] ([type_id])
GO
ALTER TABLE [dbo].[tbl_saleTaxGroupDetailes] CHECK CONSTRAINT [FK_tbl_saleTaxGroupDetailes_tbl_taxtype]
GO
ALTER TABLE [dbo].[tbl_state]  WITH CHECK ADD FOREIGN KEY([country_id])
REFERENCES [dbo].[tbl_country] ([country_id])
GO
ALTER TABLE [dbo].[tbl_stock]  WITH CHECK ADD FOREIGN KEY([batch_id])
REFERENCES [dbo].[tbl_batch] ([batch_id])
GO
ALTER TABLE [dbo].[tbl_stock]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_stock]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_stock]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_stocktransaction]  WITH CHECK ADD FOREIGN KEY([batch_id])
REFERENCES [dbo].[tbl_batch] ([batch_id])
GO
ALTER TABLE [dbo].[tbl_stocktransaction]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_stocktransaction]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_stocktransaction]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[tbl_product] ([product_id])
GO
ALTER TABLE [dbo].[tbl_subscription]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_subscription]  WITH CHECK ADD FOREIGN KEY([plan_id])
REFERENCES [dbo].[tbl_plan] ([plan_id])
GO
ALTER TABLE [dbo].[tbl_subscription]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[tbl_User] ([user_id])
GO
ALTER TABLE [dbo].[tbl_tax]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_tax]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_taxdetails]  WITH CHECK ADD FOREIGN KEY([group_id])
REFERENCES [dbo].[tbl_taxgroup] ([group_id])
GO
ALTER TABLE [dbo].[tbl_taxdetails]  WITH CHECK ADD FOREIGN KEY([type_id])
REFERENCES [dbo].[tbl_taxtype] ([type_id])
GO
ALTER TABLE [dbo].[tbl_taxgroup]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_taxgroup]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_taxtype]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_taxtype]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_unit]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_unit]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_userbranch]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[tbl_branch] ([branch_id])
GO
ALTER TABLE [dbo].[tbl_userbranch]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[tbl_company] ([company_id])
GO
ALTER TABLE [dbo].[tbl_userbranch]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[tbl_role] ([role_id])
GO
ALTER TABLE [dbo].[tbl_userbranch]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[tbl_User] ([user_id])
GO
ALTER TABLE [dbo].[tbl_userrole]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[tbl_role] ([role_id])
GO
ALTER TABLE [dbo].[tbl_userrole]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[tbl_User] ([user_id])
GO
/****** Object:  StoredProcedure [dbo].[CommonReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CommonReport] --'BALANCEREPORT',4,'5,6,1006',null,null
 @ReportType NVARCHAR(100),
 @CompanyId Int,
 @FilterIds NVARCHAR(200),
 @start_date datetime ,
 @end_date datetime 
AS
 BEGIN
			 DECLARE @start_dateFLAG int                
			 DECLARE @end_dateFLAG int
			 DECLARE @bothdateflag int 
				    if (@start_date is null or @start_date = '')                
						BEGIN                
							set @start_dateFLAG =1                 
						END                
					else                
						BEGIN                
							set @start_dateFLAG =0                
						END                
                            
					if (@end_date is null or @end_date = '' )                
						BEGIN                
							set @end_dateFLAG =1                 
						END                
					else                
						BEGIN                
							set @end_dateFLAG =0                
						END 
                    
				    if (@start_dateFLAG = 0 and @end_dateFLAG = 0)
						begin
							set @bothdateflag = 0
						end
						else
						begin
							set @bothdateflag = 1
						end

						if(@bothdateflag=1)
						 begin
						   select @start_date=start_date,@end_date=GETDATE() from tbl_financialyear where company_id=@CompanyId 

						end
						
 IF(@ReportType='GODOWNSTOCKREPORT')
 BEGIN
 
 SELECT c.company_id,g.godown_name as Godown,c.company_name as Company,'' as PartyId,p.product_name as Product,c.company_address as CompanyAddress,batch_name as Batch,b.batch_id,p.product_code,s.qty as Quantity,s.created_date as Date,s.modified_date,@start_date as startDate,@end_date as EndDate,
 '' as Party,'' as InvoiceNumber, ''as PartyAddress FROM tbl_stock s 
 inner join tbl_product p on s.product_id=p.product_id and s.company_id=p.company_id inner join tbl_godown as g on g.godown_id=p.godown_id
inner join tbl_batch b on b.batch_id=s.batch_id inner join tbl_company c on c.company_id=s.company_id  Where s.company_id=@CompanyId and g.godown_id in (Select convert(int,Value) From dbo.Split(@FilterIds,','))

END

else if(@ReportType='PRODUCTSTOCKREPORT')
begin

SELECT c.company_id,c.company_name as Company,c.company_address as CompanyAddress,'' as PartyId,batch_name as Batch, p.product_name as Product,b.batch_id,p.hsn_code as HSNCode,s.qty as Quantity,s.created_date as Date,s.modified_date,@start_date as startDate,@end_date as
 EndDate,
 '' as Party,'' as InvoiceNumber, ''as PartyAddress FROM tbl_stock s 
 inner join tbl_product p on s.product_id=p.product_id and s.company_id=p.company_id
inner join tbl_batch b on b.batch_id=s.batch_id inner join tbl_company c on c.company_id=s.company_id  Where s.company_id=@CompanyId and p.product_id in (Select convert(int,Value) From dbo.Split(@FilterIds,','))

end

ELSE IF(@ReportType='PRODUCTINVENTORYREPORT')
BEGIN
WITH PurchaseAndPurchaseReturn(Id,Batch,CompanyId,Company,CompanyAddress,Party,PartyAddress,StartDate,EndDate,InvoiceNumber,ProductId,Product,Quantity,TaxAmnt,DiscountAmnt,ProductAmount,TotalTax,TotalDiscount,TotalAmount,GivenAmnt,BalanceAmnt,PaymentMode,


Date,Type)
AS
(
(SELECT p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,pd.product_id,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount as total_tax,
payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.Po_Date,'Purchase'
FROM tbl_purchase p Inner Join tbl_purchasedetails pd on p.purchase_id=pd.purchase_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=p.purchase_id) 
UNion ALL 
(SELECT p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,pd.product_id,product_name,quantity,pd.tax_amt,pd.discount_amnt,pd.amount,payd.TaxAmount as total_tax,



payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.created_date,'Purchase Return'
FROM tbl_purchasereturn p  inner join tbl_purchasereturndetails pd on p.purchasereturn_id=pd.purchasereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=p.purchase_id) 
UNION ALL 
(SELECT p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,pd.product_id,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount as total_tax,
payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.sale_date as created_date,'Sale'
FROM tbl_sale p Inner Join tbl_saledetails pd on p.sale_id=pd.sale_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_SalePaymentDetails payd on payd.SaleId=p.sale_id)
 UNion ALL 
(SELECT p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,pd.product_id,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount as total_tax,
payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.created_date,'Sale Return'
FROM tbl_salereturn p  inner join tbl_salereturndetails pd on p.salereturn_id=pd.salereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_SalePaymentDetails payd on payd.SaleId=p.sale_id)

)
SELECT CAST(p.Date as Date) as Date,Company,CompanyAddress,Party,PartyAddress,StartDate,EndDate,Type,InvoiceNumber,Product,Quantity,ProductAmount,Batch,PaymentMode,TaxAmnt,DiscountAmnt,TotalTax,TotalDiscount,TotalAmount,GivenAmnt,
BalanceAmnt from PurchaseAndPurchaseReturn p  
Where p.CompanyId=@CompanyId and CAST(p.Date as Date) between @start_date and @end_date and p.ProductId in (Select convert(int,Value) From dbo.Split(@FilterIds,','))
END

ELSE IF(@ReportType='VENDORINVENTORYREPORT')
BEGIN
WITH PurchaseAndPurchaseReturn(Id,Batch,CompanyId,Company,CompanyAddress,PartyId,Party,PartyAddress,StartDate,EndDate,InvoiceNumber,Product,Quantity,TaxAmnt,DiscountAmnt,ProductAmount,TotalTax,TotalDiscount,TotalAmount,
GivenAmnt,BalanceAmnt,PaymentMode,Date,Type)
AS
(
(SELECT p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount as total_tax,payd.


DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.Po_Date,'Purchase'
FROM tbl_purchase p Inner Join tbl_purchasedetails pd on p.purchase_id=pd.purchase_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id and pa.party_type='Vendor' inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=p.purchase_id) UNion ALL 
(SELECT p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.discount_amnt,pd.amount,
payd.TaxAmount as total_tax,payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.created_date,'Return'
FROM tbl_purchasereturn p  inner join tbl_purchasereturndetails pd on p.purchasereturn_id=pd.purchasereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id and pa.party_type='Vendor' inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=p.purchase_id) 
UNION ALL 
 (SELECT p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount as total_tax,
 payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.sale_date as created_date,'Purchase'
FROM tbl_sale p Inner Join tbl_saledetails pd on p.sale_id=pd.sale_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id and pa.party_type='Vendor' inner join tbl_SalePaymentDetails payd on payd.SaleId=p.sale_id)
 UNion ALL 
(SELECT p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,
payd.TaxAmount as total_tax,payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.created_date,'Return'
FROM tbl_salereturn p  inner join tbl_salereturndetails pd on p.salereturn_id=pd.salereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id and pa.party_type='Vendor' inner join tbl_SalePaymentDetails payd on payd.SaleId=p.sale_id)
)
SELECT * from PurchaseAndPurchaseReturn p  Where p.CompanyId=@CompanyId and CAST(p.Date as Date) between @start_date and @end_date and p.PartyId in (Select convert(int,Value) From dbo.Split(@FilterIds,','))
END
ELSE IF(@ReportType='CUSTOMERINVENTORYREPORT')
BEGIN
WITH PurchaseAndPurchaseReturn(Id,Batch,CompanyId,Company,CompanyAddress,PartyId,Party,PartyAddress,StartDate,EndDate,InvoiceNumber,Product,Quantity,TaxAmnt,DiscountAmnt,ProductAmount,TotalTax,TotalDiscount,TotalAmount,
GivenAmnt,BalanceAmnt,PaymentMode,Date,Type)
AS
(
(SELECT p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount as total_tax,payd.


DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.Po_Date,'Purchase'
FROM tbl_purchase p Inner Join tbl_purchasedetails pd on p.purchase_id=pd.purchase_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id and pa.party_type='Customer' inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=p.purchase_id) UNion ALL 
(SELECT p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.discount_amnt,pd.amount,payd.TaxAmount as total_tax,
payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.created_date,'Return'
FROM tbl_purchasereturn p  inner join tbl_purchasereturndetails pd on p.purchasereturn_id=pd.purchasereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id and pa.party_type='Customer' inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=p.purchase_id) 
UNION ALL 
 (SELECT p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount as total_tax,
 payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.sale_date as created_date,'Purchase'
FROM tbl_sale p Inner Join tbl_saledetails pd on p.sale_id=pd.sale_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id and pa.party_type='Customer' inner join tbl_SalePaymentDetails payd on payd.SaleId=p.sale_id)
 UNion ALL 
(SELECT p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount as total_tax,
payd.DiscountAmount as total_discount,payd.SubTotal as total_amnt,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,pm.paymentmode_name,p.created_date,'Return'
FROM tbl_salereturn p  inner join tbl_salereturndetails pd on p.salereturn_id=pd.salereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id and pa.party_type='Customer' inner join tbl_SalePaymentDetails payd on payd.SaleId=p.sale_id)
)
SELECT * from PurchaseAndPurchaseReturn p  Where p.CompanyId=@CompanyId and CAST(p.Date as Date) between @start_date and @end_date and p.PartyId in (Select convert(int,Value) From dbo.Split(@FilterIds,','))
END

else if(@ReportType='CUSTOMERBALANCEREPORT')
begin


select pt.party_name as Party,p.created_date as Date,GETDATE() as EndDate,pd.GrandTotal,pt.party_address as  PartyAddress,pd.CreatedDate as StartDate,pd.BalanceAmnt,pd.GivenAmnt,p.InvoiceNumber,c.company_name as Company,c.company_address as CompanyAddress
 from tbl_SalePaymentDetails as pd inner join tbl_sale as p on p.sale_id=pd.SaleId 
 inner join tbl_party as pt on pt.party_id=p.party_id inner join tbl_company as c on c.company_id=p.company_id
  Where p.company_id=@CompanyId and CAST(p.created_date as Date) between @start_date and @end_date and p.party_id in (Select convert(int,Value) From dbo.Split(@FilterIds,',')) and pd.BalanceAmnt>0 
end
else if(@ReportType='VENDORBALANCEREPORT')
begin


select pt.party_name as Party,p.Po_Date as Date,GETDATE() as EndDate,pd.GrandTotal,pt.party_address as  PartyAddress,pd.CreatedDate as StartDate,pd.BalanceAmnt,pd.GivenAmnt,p.InvoiceNumber,c.company_name as Company,c.company_address as CompanyAddress,'' as PartyAddress
 from tbl_PurchasePaymentDetials as pd inner join tbl_purchase as p on p.purchase_id=pd.PurchaseId 
 inner join tbl_party as pt on pt.party_id=p.party_id inner join tbl_company as c on c.company_id=p.company_id
  Where p.company_id=@CompanyId and CAST(p.created_date as Date) between @start_date and @end_date and p.party_id in (Select convert(int,Value) From dbo.Split(@FilterIds,',')) and pd.BalanceAmnt>0 
end
else if(@ReportType='LOWSTOCKREPORT')
begin


	Select s.stock_id, s.batch_id, p.product_id,p.product_name as Product,p.hsn_code as HSNCode,p.product_code,p.reorder_level as [Reorderlevel], s.qty as Quantity,b.batch_name as Batch,c.company_name as Company,c.company_address as CompanyAddress, 
	@start_date as StartDate ,@end_date as EndDate,GETDATE() as Date,'' as PartyAddress from tbl_product p
	join tbl_stock s on s.product_id = p.product_id inner join tbl_batch b on b.batch_id=s.batch_id  inner join tbl_company as c on c.company_id=p.company_id
  Where p.company_id=@CompanyId and CAST(p.created_date as Date) between @start_date and @end_date and p.product_id in (Select convert(int,Value) From dbo.Split(@FilterIds,',')) and s.qty < p.reorder_level
end


 END

GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorsXml]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ELMAH_GetErrorsXml]
(
    @Application NVARCHAR(60),
    @PageIndex INT = 0,
    @PageSize INT = 15,
    @TotalCount INT OUTPUT
)
AS 

    SET NOCOUNT ON

    DECLARE @FirstTimeUTC DATETIME
    DECLARE @FirstSequence INT
    DECLARE @StartRow INT
    DECLARE @StartRowIndex INT

    SELECT 
        @TotalCount = COUNT(1) 
    FROM 
        [ELMAH_Error]
    WHERE 
        [Application] = @Application

    -- Get the ID of the first error for the requested page

    SET @StartRowIndex = @PageIndex * @PageSize + 1

    IF @StartRowIndex <= @TotalCount
    BEGIN

        SET ROWCOUNT @StartRowIndex

        SELECT  
            @FirstTimeUTC = [TimeUtc],
            @FirstSequence = [Sequence]
        FROM 
            [ELMAH_Error]
        WHERE   
            [Application] = @Application
        ORDER BY 
            [TimeUtc] DESC, 
            [Sequence] DESC

    END
    ELSE
    BEGIN

        SET @PageSize = 0

    END

    -- Now set the row count to the requested page size and get
    -- all records below it for the pertaining application.

    SET ROWCOUNT @PageSize

    SELECT 
        errorId     = [ErrorId], 
        application = [Application],
        host        = [Host], 
        type        = [Type],
        source      = [Source],
        message     = [Message],
        [user]      = [User],
        statusCode  = [StatusCode], 
        time        = CONVERT(VARCHAR(50), [TimeUtc], 126) + 'Z'
    FROM 
        [ELMAH_Error] error
    WHERE
        [Application] = @Application
    AND
        [TimeUtc] <= @FirstTimeUTC
    AND 
        [Sequence] <= @FirstSequence
    ORDER BY
        [TimeUtc] DESC, 
        [Sequence] DESC
    FOR
        XML AUTO


GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorXml]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ELMAH_GetErrorXml]
(
    @Application NVARCHAR(60),
    @ErrorId UNIQUEIDENTIFIER
)
AS

    SET NOCOUNT ON

    SELECT 
        [AllXml]
    FROM 
        [ELMAH_Error]
    WHERE
        [ErrorId] = @ErrorId
    AND
        [Application] = @Application


GO
/****** Object:  StoredProcedure [dbo].[ELMAH_LogError]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ELMAH_LogError]
(
    @ErrorId UNIQUEIDENTIFIER,
    @Application NVARCHAR(60),
    @Host NVARCHAR(30),
    @Type NVARCHAR(100),
    @Source NVARCHAR(60),
    @Message NVARCHAR(500),
    @User NVARCHAR(50),
    @AllXml NTEXT,
    @StatusCode INT,
    @TimeUtc DATETIME
)
AS

    SET NOCOUNT ON

    INSERT
    INTO
        [ELMAH_Error]
        (
            [ErrorId],
            [Application],
            [Host],
            [Type],
            [Source],
            [Message],
            [User],
            [AllXml],
            [StatusCode],
            [TimeUtc]
        )
    VALUES
        (
            @ErrorId,
            @Application,
            @Host,
            @Type,
            @Source,
            @Message,
            @User,
            @AllXml,
            @StatusCode,
            @TimeUtc
        )


GO
/****** Object:  StoredProcedure [dbo].[GetBatchwiseQuantity]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure[dbo].[GetBatchwiseQuantity] 
@batch_id int,
@product_id int

as
 Begin 

 WITH StockCTE(PurchaseQty,PurchaseReturnQty,SaleQty,SaleReturnQty)
					AS
					(					
					SELECT isnull(sum(quantity),0) as PurchaseQty,0,0,0 FROM tbl_purchasedetails where product_id=@product_id and batch_id=@batch_id -- in
					union all 
					SELECT  0,isnull(sum(quantity),0) as PurchaseReturnQty,0,0  FROM tbl_purchasereturndetails  where product_id=@product_id and batch_id=@batch_id --out
					union all 
					SELECT  0,0,isnull(sum(quantity),0) as SaleQty,0 FROM tbl_saledetails  where product_id=@product_id and batch_id=@batch_id --out 
					union all 
					SELECT  0,0,0,isnull(sum(quantity),0) as SaleReturnQty  FROM tbl_salereturndetails  where product_id=@product_id and batch_id=@batch_id --in 
					)
					SELECT (SUM(PurchaseQty)+SUM(SaleReturnQty))-(SUM(PurchaseReturnQty)+SUM(SaleQty)) as StockAvl FROM StockCTE
					
   End



GO
/****** Object:  StoredProcedure [dbo].[GetReturnQuantity]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <15/10/2018>
-- Description:	<Gives Quantity of Product for PUrchase and Sale Against the Returns>
-- =============================================
CREATE PROCEDURE [dbo].[GetReturnQuantity]
@Id INT,
@For NVARCHAR(50),
@ProductId Int,
@CompanyId INT
 -- Purchase/Sale/Return
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
				   IF(@For='PURCHASE')
				  BEGIN
				 WITH PurchaseAndPurchaseReturn(Id,PurductId,PurchaseQuantity,ReturnQuantity)
AS
(
(SELECT p.purchase_id,pd.product_id,SUM(pd.quantity) as PurchaseQuantity,0
FROM tbl_purchase p Inner Join tbl_purchasedetails pd on p.purchase_id=pd.purchase_id  where p.company_id=@CompanyId group by p.purchase_id,pd.product_id)
 UNion ALL 
(SELECT p.purchase_id,pd.product_id,0,SUM(pd.quantity)
FROM tbl_purchasereturn p Inner Join tbl_purchasereturndetails pd on p.purchasereturn_id=pd.purchasereturn_id  where p.company_id=@CompanyId group by p.purchase_id,pd.product_id)  
)
SELECT (SUM(PurchaseQuantity)- SUM(ReturnQuantity)) as Quantity from PurchaseAndPurchaseReturn  where Id=@Id and  PurductId=@ProductId

END
				  ELSE IF(@For='SALE')
	BEGIN
   WITH SaleAndSaleReturn(Id,PurductId,PurchaseQuantity,ReturnQuantity)
AS
(
(SELECT p.sale_id,pd.product_id,SUM(pd.quantity) as PurchaseQuantity,0
FROM tbl_sale p Inner Join tbl_saledetails pd on p.sale_id=pd.sale_id where p.company_id=@CompanyId  group by p.sale_id,pd.product_id)
 UNion ALL 
(SELECT p.sale_id,pd.product_id,0,SUM(pd.quantity)
FROM tbl_salereturn p Inner Join tbl_salereturndetails pd on p.salereturn_id=pd.salereturn_id where p.company_id=@CompanyId group by p.sale_id,pd.product_id)  
)
SELECT CONVERT(decimal(18,0),(SUM(PurchaseQuantity)- SUM(ReturnQuantity))) as Quantity from SaleAndSaleReturn  where Id=@Id and  PurductId=@ProductId
				  END
				 
				    
				  				 
END

GO
/****** Object:  StoredProcedure [dbo].[InventoryReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/03/2018>
-- Description:	<Complete Detail inventory Report>
-- =============================================
CREATE PROCEDURE [dbo].[InventoryReport]
@CompanyId INT,
@PartyId INT,
@StartDate Date,
@EndDate Date  -- Purchase/Sale/Return
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
					 WITH Inventory(Type,Id,Batch,CompanyId,Company,CompanyAddress,PartyId,Party,PartyAddress,StartDate,EndDate,InvoiceNumber,Product,Quantity,TaxAmnt,DiscountAmnt,ProductAmount,TotalTax,TotalDiscount,TotalAmount,GivenAmnt,BalanceAmnt,PaymentMode,Date)
AS
(
(SELECT 'Purchase',p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,p.total_tax,p.total_discount,p.total_amnt,p.given_amnt,p.balance_amnt,pm.paymentmode_name,p.Po_Date
FROM tbl_purchase p Inner Join tbl_purchasedetails pd on p.purchase_id=pd.purchase_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id) UNion ALL 
(SELECT 'Purchase Return',p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.discount_amnt,pd.amount,p.total_tax,p.total_discount,p.total_amount,p.given_amnt,p.balance_amnt,pm.paymentmode_name,p.created_date
FROM tbl_purchasereturn p  inner join tbl_purchasereturndetails pd on p.purchasereturn_id=pd.purchasereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id) 
UNION ALL
(SELECT 'Sale',p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_name,pa.party_id,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,p.total_tax,p.total_discount,p.total_amount,p.given_amnt,p.balance_amnt,pm.paymentmode_name,p.sale_date as created_date
FROM tbl_sale p Inner Join tbl_saledetails pd on p.sale_id=pd.sale_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id)
 UNion ALL 
(SELECT 'Sale Return', p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,p.total_tax,p.total_discount,p.total_amount,p.given_amnt,p.balance_amnt,pm.paymentmode_name,p.created_date
FROM tbl_salereturn p  inner join tbl_salereturndetails pd on p.salereturn_id=pd.salereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id)  
)
SELECT *FROM Inventory where (CompanyId=@CompanyId) OR (Date between @StartDate and @EndDate) OR (PartyId=@PartyId)
END
GO
/****** Object:  StoredProcedure [dbo].[PaymentBalanceReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/03/2018>
-- Description:	<Complete Detail inventory Report>
-- =============================================
CREATE PROCEDURE [dbo].[PaymentBalanceReport]
@CompanyId INT,
@PartyId INT,
@StartDate Date,
@EndDate Date  -- Purchase/Sale/Return
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
					 WITH Inventory(Type,Id,Batch,CompanyId,Company,CompanyAddress,PartyId,Party,PartyAddress,StartDate,EndDate,InvoiceNumber,Product,Quantity,TaxAmnt,DiscountAmnt,ProductAmount,TotalTax,TotalDiscount,TotalAmount,GivenAmnt,BalanceAmnt,PaymentMode,Date)
AS
(
(SELECT 'Purchase',p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,p.total_tax,p.total_discount,p.total_amnt,p.given_amnt,p.balance_amnt,pm.paymentmode_name,p.Po_Date
FROM tbl_purchase p Inner Join tbl_purchasedetails pd on p.purchase_id=pd.purchase_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id) UNion ALL 
(SELECT 'Purchase Return',p.purchase_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.discount_amnt,pd.amount,p.total_tax,p.total_discount,p.total_amount,p.given_amnt,p.balance_amnt,pm.paymentmode_name,p.created_date
FROM tbl_purchasereturn p  inner join tbl_purchasereturndetails pd on p.purchasereturn_id=pd.purchasereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id) 
UNION ALL
(SELECT 'Sale',p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_name,pa.party_id,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,p.total_tax,p.total_discount,p.total_amount,p.given_amnt,p.balance_amnt,pm.paymentmode_name,p.sale_date as created_date
FROM tbl_sale p Inner Join tbl_saledetails pd on p.sale_id=pd.sale_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id)
 UNion ALL 
(SELECT 'Sale Return', p.sale_id,b.batch_name,c.company_id,c.company_name,c.company_address,pa.party_id,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,p.total_tax,p.total_discount,p.total_amount,p.given_amnt,p.balance_amnt,pm.paymentmode_name,p.created_date
FROM tbl_salereturn p  inner join tbl_salereturndetails pd on p.salereturn_id=pd.salereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id)  
)
SELECT *FROM Inventory where (CompanyId=@CompanyId) OR (Date between @StartDate and @EndDate) OR (PartyId=@PartyId)
END
GO
/****** Object:  StoredProcedure [dbo].[ProductReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/03/2018>
-- Description:	<Complete Detail inventory Report>
-- =============================================
CREATE PROCEDURE [dbo].[ProductReport]
@CompanyId INT

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
					 
SELECT *FROM tbl_product p  where company_id=@CompanyId
END
GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrPurchaseReturnReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/08/2018>
-- Description:	<Gives Purchase or Purchase Return Data>
-- =============================================
CREATE PROCEDURE [dbo].[PurchaseOrPurchaseReturnReport] --5052,'COMBINEPURCHASEANDRETURNREPORT'
@Id INT,
@FromTable NVARCHAR(50)
 -- Purchase/Sale/Return
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
				   IF(@FromTable='PURCHASE')
				  BEGIN
				  SELECT c.company_name,pa.party_name,pa.party_address,
pa.contact_no,c.company_address,pd.TaxAmount as total_tax,pd.DiscountAmount as total_discount,pd.SubTotal as total_amount,
pd.GrandTotal as grand_total,pr.InvoiceNumber,pm.paymentmode_name ,pd.GivenAmnt as given_amnt ,pd.BalanceAmnt as balance_amnt,p.product_name,ap.purchase_rate,ap.sale_price, prd.tax_amt,bt.batch_name,prd.quantity,prd.amount,pr.created_date
FROM     tbl_purchase pr  inner Join tbl_purchasedetails prd on pr.purchase_id=prd.purchase_id inner join tbl_product p on p.product_id=prd.product_id inner join
				  tbl_paymentmode pm on pr.paymentmode_id=pm.paymentode_id inner join tbl_batch bt on bt.batch_id=prd.batch_id inner join tbl_company c on c.company_id=pr.company_id inner join tbl_party pa on pa.party_id=pr.party_id
				  inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=pr.purchase_id and ap.product_id=prd.product_id
				  inner join tbl_PurchasePaymentDetials pd on pd.PurchaseId=pr.purchase_id
				  where pr.purchase_id=@Id		order by pr.created_date asC
				  END				  
				   ELSE IF(@FromTable='PURCHASEREPORT')
				  BEGIN
				  SELECT c.company_name,pa.party_name,pa.party_address,
pa.contact_no,c.company_address,pd.TaxAmount as total_tax,pd.DiscountAmount as discount_amnt,pd.SubTotal as total_amount,
pd.GrandTotal as grand_total,pr.InvoiceNumber,pm.paymentmode_name ,pd.GivenAmnt as given_amnt ,pd.BalanceAmnt as balance_amnt,p.product_name,ap.purchase_rate,ap.sale_price, prd.tax_amt,bt.batch_name,prd.quantity,prd.amount,pr.created_date
FROM     tbl_purchase pr  inner Join tbl_purchasedetails prd on pr.purchase_id=prd.purchase_id inner join tbl_product p on p.product_id=prd.product_id inner join
				  tbl_paymentmode pm on pr.paymentmode_id=pm.paymentode_id inner join tbl_batch bt on bt.batch_id=prd.batch_id inner join tbl_company c on c.company_id=pr.company_id inner join tbl_party pa on pa.party_id=pr.party_id
				  inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=pr.purchase_id and ap.product_id=prd.product_id
				  inner join tbl_PurchasePaymentDetialsHistory pd on pd.PurchaseId=pr.purchase_id and pd.FromTable='Purchase'
				  where pr.purchase_id=@Id order by pr.created_date asC
				  END				  
				  ELSE IF(@FromTable='PURCHASERETURN')
	BEGIN
    -- Insert statements for procedure here
	SELECT c.company_name,pa.party_name,pa.party_address,
pa.contact_no,c.company_address,pd.TaxAmount as total_tax,pd.DiscountAmount as total_discount,pd.SubTotal as total_amount,
pd.GrandTotal as grand_total,pr.InvoiceNumber,pm.paymentmode_name ,pd.GivenAmnt as given_amnt ,pd.BalanceAmnt as balance_amnt,p.product_name,ap.purchase_rate,ap.sale_price, prd.tax_amt,bt.batch_name,prd.quantity,prd.amount,pr.created_date
FROM     tbl_purchasereturn pr  inner Join tbl_purchasereturndetails prd on pr.purchasereturn_id=prd.purchasereturn_id inner join tbl_product p on p.product_id=prd.product_id inner join
				  tbl_paymentmode pm on pr.paymentmode_id=pm.paymentode_id inner join tbl_batch bt on bt.batch_id=prd.batch_id inner join tbl_company c on c.company_id=pr.company_id inner join tbl_party pa on pa.party_id=pr.party_id
				  inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=pr.purchase_id and ap.product_id=prd.product_id
				   inner join tbl_PurchasePaymentDetials pd on pd.PurchaseId=pr.purchase_id
				  where pr.purchase_id=@Id	order by pr.created_date ASC
				  END
				  ELSE IF(@FromTable='PURCHASERETURNREPORT')
	BEGIN
  
	SELECT c.company_name,pa.party_name,pa.party_address,prd.discount_amnt,pd.FromTable,
pa.contact_no,c.company_address,pd.TaxAmount as total_tax,pd.DiscountAmount as total_discount,pd.SubTotal as total_amount,
pd.GrandTotal as grand_total,pr.InvoiceNumber,pm.paymentmode_name ,pd.GivenAmnt as given_amnt ,pd.BalanceAmnt as balance_amnt,p.product_name,ap.purchase_rate,ap.sale_price, prd.tax_amt,bt.batch_name,prd.quantity,prd.amount,pr.created_date
FROM     tbl_purchasereturn pr  inner Join tbl_purchasereturndetails prd on pr.purchasereturn_id=prd.purchasereturn_id inner join tbl_product p on p.product_id=prd.product_id inner join
				  tbl_paymentmode pm on pr.paymentmode_id=pm.paymentode_id inner join tbl_batch bt on bt.batch_id=prd.batch_id inner join tbl_company c on c.company_id=pr.company_id inner join tbl_party pa on pa.party_id=pr.party_id
				  inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=pr.purchase_id and ap.product_id=prd.product_id
				   inner join tbl_PurchasePaymentDetialsHistory pd on pd.PurchaseId=pr.purchase_id and pd.FromTable='Return'
				  where pr.purchase_id=@Id	order by pr.created_date ASC
				  END
				  ELSE IF(@FromTable='COMBINEPURCHASEANDRETURN')
				  BEGIN
				 				 WITH PurchaseAndPurchaseReturn(Id,Batch,Company,CompanyAddress,Party,PartyAddress,StartDate,EndDate,InvoiceNumber,PoNo,Product,PurchaseRate,SaleRate,Quantity,TaxAmnt,DiscountAmnt,ProductAmount,TotalTax,TotalDiscount,TotalAmount,GrandTotal,GivenAmnt,BalanceAmnt,PaymentMode,Date,Type)
AS
(
(SELECT p.purchase_id,b.batch_name,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,p.po_no,product_name,ap.purchase_rate,ap.sale_price,quantity,pd.tax_amt,isnull(pd.dicount_amt,0)
,pd.amount,payd.TaxAmount,payd.DiscountAmount,payd.SubTotal,payd.GrandTotal,payd.GivenAmnt,payd.BalanceAmnt,pm.paymentmode_name,p.created_date,'Purchase'
FROM tbl_purchase p Inner Join tbl_purchasedetails pd on p.purchase_id=pd.purchase_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=p.purchase_id and ap.product_id=pd.product_id
inner join tbl_PurchasePaymentDetialsHistory payd on payd.PurchaseId=p.purchase_id and payd.FromTable='Purchase') UNion ALL 
(SELECT p.purchase_id,b.batch_name,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,'',product_name,ap.purchase_rate,ap.sale_price,quantity,pd.tax_amt,
isnull(pd.discount_amnt,0),pd.amount,payd.TaxAmount,payd.DiscountAmount,payd.SubTotal,payd.GrandTotal,payd.GivenAmnt,payd.BalanceAmnt,pm.paymentmode_name,p.created_date,'Return'
FROM tbl_purchasereturn p  inner join tbl_purchasereturndetails pd on p.purchasereturn_id=pd.purchasereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=p.purchase_id and ap.product_id=pd.product_id
inner join tbl_PurchasePaymentDetialsHistory payd on payd.PurchaseId=p.purchase_id and payd.FromTable='Return')  
)
SELECT * from PurchaseAndPurchaseReturn p   where p.Id=@Id order by Date ASC
				 END 
				    ELSE IF(@FromTable='COMBINEPURCHASEANDRETURNREPORT')
				  BEGIN
				 WITH PurchaseAndPurchaseReturn(Id,Batch,Company,CompanyAddress,Party,PartyAddress,StartDate,EndDate,InvoiceNumber,PoNo,Product,PurchaseRate,SaleRate,Quantity,TaxAmnt,DiscountAmnt,ProductAmount,TotalTax,TotalDiscount,TotalAmount,GrandTotal,GivenAmnt,


BalanceAmnt,PaymentMode,Date,Type)
AS
(
(SELECT p.purchase_id,b.batch_name,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,p.po_no,product_name,ap.purchase_rate,ap.sale_price,quantity,pd.tax_amt,isnull(pd.dicount_amt,0),pd.amount,payd.TaxAmount,payd.DiscountAmount,payd.SubTotal,payd.GrandTotal,payd.GivenAmnt,payd.BalanceAmnt,pm.paymentmode_name,p.created_date,'Purchase'
FROM tbl_purchase p Inner Join tbl_purchasedetails pd on p.purchase_id=pd.purchase_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=p.purchase_id and ap.product_id=pd.product_id
inner join tbl_PurchasePaymentDetialsHistory	 payd on payd.PurchaseId=p.purchase_id and payd.FromTable='Purchase') UNion ALL 
(SELECT p.purchase_id,b.batch_name,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,'',product_name,ap.purchase_rate,ap.sale_price,quantity,pd.tax_amt,isnull(pd.discount_amnt,0),pd.amount,payd.TaxAmount,payd.DiscountAmount,payd.SubTotal,payd.GrandTotal,payd.GivenAmnt,payd.BalanceAmnt,pm.paymentmode_name,p.created_date,'Return'
FROM tbl_purchasereturn p  inner join tbl_purchasereturndetails pd on p.purchasereturn_id=pd.purchasereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=p.purchase_id and ap.product_id=pd.product_id
inner join tbl_PurchasePaymentDetialsHistory payd on payd.PurchaseId=p.purchase_id and payd.FromTable='Return')  
)
SELECT * from PurchaseAndPurchaseReturn p   where p.Id=@Id order by Date ASC
				  END 
				  				 
END

GO
/****** Object:  StoredProcedure [dbo].[SaleOrderReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/08/2018>
-- Description:	<Sale Order / Actual Invoice Report>
-- =============================================
CREATE PROCEDURE [dbo].[SaleOrderReport]
@SaleId Int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.company_name as CompanyName,pa.party_name as PartyName,pa.party_address as PartyAddress,
pa.contact_no as PartyContactNo,c.company_address as CompanyAddress,p.product_name as ProductName,s.created_date as InvoiceDate,sd.quantity,sd.dicount_amt,
sd.tax_amt,t.tax_percentage,sd.amount as Total
FROM     tbl_sale s INNER JOIN
                  tbl_saledetails sd ON s.sale_id = sd.sale_id inner join tbl_product p on sd.product_id=p.product_id inner Join 
				  tbl_tax t on t.tax_id=sd.tax_id inner join tbl_company c on c.company_id=s.company_id inner Join tbl_party pa on pa.party_id=s.party_id
				  where s.sale_id=@SaleId
END

GO
/****** Object:  StoredProcedure [dbo].[SaleOrPurchaseOrReturnReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Awez Khan>
-- Create date: <03/01/2019>
-- Description:	<Gives Purchase or Sale Or Return Data>
-- =============================================
CREATE PROCEDURE [dbo].[SaleOrPurchaseOrReturnReport]-- 5055,'COMBINEPURCHASEANDRETURNREPORT'
@Id INT,
@FromTable NVARCHAR(50)
 -- Purchase/Sale/Return
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
			IF(@FromTable='COMBINEPURCHASEANDRETURNREPORT')
			begin
				 				 WITH PurchaseAndReturn(Id,SubTotal,TaxAmount,DiscountAmount,GrandTotal,GivenAmnt,BalanceAmnt,Date)
AS
(
select PurchaseId as Id,SubTotal,TaxAmount,DiscountAmount,GrandTotal,GivenAmnt,BalanceAmnt,CreatedDate as Date from tbl_PurchasePaymentDetials 
)
SELECT * from PurchaseAndReturn p   where p.Id=@Id order by Date ASC
				 END 
				    ELSE IF(@FromTable='COMBINESALEANDRETURN')
				  BEGIN
				 WITH SaleAndSaleReturn(Id,SubTotal,TaxAmount,DiscountAmount,GrandTotal,GivenAmnt,BalanceAmnt,Date)
AS
(
select SaleId as Id,SubTotal,TaxAmount,DiscountAmount,GrandTotal,GivenAmnt,BalanceAmnt,CreatedDate as Date from tbl_SalePaymentDetails
)
SELECT * from SaleAndSaleReturn p   where p.Id=@Id order by Date ASC
				  END 
				  				 
END

GO
/****** Object:  StoredProcedure [dbo].[SaleOrSaleReturnReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <24/10/2018>
-- Description:	<Gives Purchase or Purchase Return Data>
-- Modified By : <Awez Khan>
-- Create date: <24/12/2018>
-- =============================================
CREATE PROCEDURE [dbo].[SaleOrSaleReturnReport]
@Id INT,
@FromTable NVARCHAR(50)
 -- Purchase/Sale/Return
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
				   IF(@FromTable='SALE')
				  BEGIN
				  SELECT c.company_name,pa.party_name,pa.party_address,
pa.contact_no,c.company_address,pd.TaxAmount as total_tax,pd.DiscountAmount as discount_amnt,pd.SubTotal as total_amount,
pd.GrandTotal as grand_total,pr.InvoiceNumber,pm.paymentmode_name ,pd.GivenAmnt as given_amnt ,pd.BalanceAmnt as balance_amnt,p.product_name,ap.sale_rate, prd.tax_amt,bt.batch_name,prd.quantity,prd.amount,pr.sale_date as created_date
FROM     tbl_sale pr  inner Join tbl_saledetails prd on pr.sale_id=prd.sale_id inner join tbl_product p on p.product_id=prd.product_id inner join
				  tbl_paymentmode pm on pr.paymentmode_id=pm.paymentode_id inner join tbl_batch bt on bt.batch_id=prd.batch_id inner join tbl_company c on c.company_id=pr.company_id inner join tbl_party pa on pa.party_id=pr.party_id
				   inner join tbl_ActualSalesTaxAndPrice ap on ap.sale_id=pr.sale_id and ap.product_id=prd.product_id
				   inner join tbl_SalePaymentDetails pd on pd.SaleId=pr.sale_id
				  where pr.sale_id=@Id	order by pr.created_date asc
				  END
				  ELSE IF(@FromTable='SALERETURN')
	BEGIN
    -- Insert statements for procedure here
	SELECT c.company_name,pa.party_name,pa.party_address,
pa.contact_no,c.company_address,pd.TaxAmount as total_tax,pd.DiscountAmount as discount_amnt,pd.SubTotal as total_amount,
pd.GrandTotal as grand_total,pr.InvoiceNumber,pm.paymentmode_name ,pd.GivenAmnt as given_amnt ,pd.BalanceAmnt as balance_amnt,p.product_name,ap.sale_rate, prd.tax_amt,bt.batch_name,prd.quantity,prd.amount,pr.created_date as created_date
FROM     tbl_salereturn pr  inner Join tbl_salereturndetails prd on pr.salereturn_id=prd.salereturn_id inner join tbl_product p on p.product_id=prd.product_id inner join
				  tbl_paymentmode pm on pr.paymentmode_id=pm.paymentode_id inner join tbl_batch bt on bt.batch_id=prd.batch_id inner join tbl_company c on c.company_id=pr.company_id inner join tbl_party pa on pa.party_id=pr.party_id
				  inner join tbl_ActualSalesTaxAndPrice ap on ap.sale_id=pr.sale_id and ap.product_id=prd.product_id
				  inner join tbl_SalePaymentDetails pd on pd.SaleId=pr.sale_id
				  where pr.sale_id=@Id	order by pr.created_date asc
				  END
				  ELSE IF(@FromTable='COMBINESALEANDRETURN')
				  BEGIN
				 WITH SaleAndSaleReturn(Id,Batch,Company,CompanyAddress,Party,PartyAddress,StartDate,EndDate,InvoiceNumber,Product,SaleRate,Quantity,TaxAmnt,DiscountAmnt,ProductAmount,TotalTax,TotalDiscount,TotalAmount,GrandTotal,GivenAmnt,BalanceAmnt,PaymentMode,Date,Type)
AS
(
(SELECT p.sale_id,b.batch_name,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,ap.sale_rate,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount,payd.DiscountAmount,payd.SubTotal,


payd.GrandTotal,payd.GivenAmnt,payd.BalanceAmnt,pm.paymentmode_name,p.sale_date as created_date,'Sale' as FromTable
FROM tbl_sale p Inner Join tbl_saledetails pd on p.sale_id=pd.sale_id inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_ActualSalesTaxAndPrice ap on ap.sale_id=p.sale_id and ap.product_id=pd.product_id
inner join tbl_SalePaymentDetailsHistory payd on payd.SaleId=p.sale_id and payd.FromTable='Sale')
 UNion ALL 
(SELECT p.sale_id,b.batch_name,c.company_name,c.company_address,pa.party_name,pa.party_address,f.start_date,f.end_date,p.InvoiceNumber,product_name,ap.sale_rate,quantity,pd.tax_amt,pd.dicount_amt,pd.amount,payd.TaxAmount,payd.DiscountAmount,payd.SubTotal,


payd.GrandTotal,payd.GivenAmnt,payd.BalanceAmnt,pm.paymentmode_name,p.created_date,'Return' as FromTable
FROM tbl_salereturn p  inner join tbl_salereturndetails pd on p.salereturn_id=pd.salereturn_id   inner join tbl_product on pd.product_id=tbl_product.product_id 
inner join tbl_paymentmode pm on p.[PaymentMode_id]=pm.paymentode_id inner join tbl_batch b on b.batch_id=pd.batch_id inner join tbl_company c on c.company_id=p.company_id inner join tbl_financialyear f on f.financialyear_id=p.financialyear_id
inner join tbl_party pa on pa.party_id=p.party_id inner join tbl_ActualSalesTaxAndPrice ap on ap.sale_id=p.sale_id and ap.product_id=pd.product_id
inner join tbl_SalePaymentDetailsHistory payd on payd.SaleId=p.sale_id and payd.FromTable='Return')  
)
SELECT * from SaleAndSaleReturn p   where p.Id=@Id order by Date asc
				  END 
				    
				  				
END

GO
/****** Object:  StoredProcedure [dbo].[SaleReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/0/2018>
-- Description:	<Complete Detail Sale Report>
-- =============================================
CREATE PROCEDURE [dbo].[SaleReport]

@saledetails_id int 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
    -- Insert statements for procedure here
	SELECT * from tbl_saledetails s where saledetails_id=@saledetails_id
END



GO
/****** Object:  StoredProcedure [dbo].[SelectProductTaxGroup]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure[dbo].[SelectProductTaxGroup] --1007,6026,25
@groupId int,
@productId int,
@qty decimal



as
 Begin
 declare @productPrice decimal,@totalTaxAmnt decimal,@var decimal,@totalTaxPercetage decimal


set @totalTaxPercetage=(select sum(tax_percentage)   from tbl_taxdetails where group_id=1007)
set @productPrice =(select tbl_product.purchas_price from tbl_product where product_id=@productId)
set @var=@productPrice*@qty
set @totalTaxAmnt=@var*@totalTaxPercetage/100



    select @totalTaxPercetage as totalTaxPercetage, @totalTaxAmnt as totalTaxAmnt,grouptax.group_name,prouctGrptax.product_id,typeTax.type_id,detail.tax_percentage,product.product_name,
	product.purchas_price,typeTax.type_name ,grouptax.group_id from tbl_taxgroup  grouptax 
	inner join tbl_productTaxGroup prouctGrptax on prouctGrptax.group_id=grouptax.group_id
	inner join tbl_taxdetails detail on detail.group_id=grouptax.group_id
	inner join tbl_product product on product.product_id=prouctGrptax.product_id
	inner join tbl_taxtype typeTax on typeTax.type_id=detail.type_id
	where grouptax.group_id=@groupId and prouctGrptax.product_id=@productId
	end


	
GO
/****** Object:  StoredProcedure [dbo].[SelectPurcahseProductTaxGroup]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[SelectPurcahseProductTaxGroup] 
@purchaseTaxgroupId int,
@productId int,
@qty decimal



as
 Begin
 declare @productPrice decimal,@totalTaxAmnt decimal,@var decimal,@totalTaxPercetage decimal, @purchaseId int


set @totalTaxPercetage=(select sum(tax_percentage)   from tbl_purchasetaxdetails where purchasetaxgroup_id=@purchaseTaxgroupId)
set @purchaseId=(select purchaseId from tbl_purchasetaxgroup where purchasetaxgroup_id=@purchaseTaxgroupId)
set @productPrice =(select sale_price from tbl_ActualPurchaseTaxAndPrice where product_id=@productId and purchase_id=@purchaseId)
set @var=@productPrice* @qty
set @totalTaxAmnt=@var*@totalTaxPercetage/100



    select @totalTaxPercetage as totalTaxPercetage, @totalTaxAmnt as totalTaxAmnt,grouptax.group_name,prouctGrptax.product_id,
	typeTax.type_id,detail.tax_percentage,product.product_name,
	product.purchas_price,typeTax.type_name ,grouptax.group_id from tbl_purchasetaxgroup  grouptax 
	inner join tbl_ActualPurchaseTaxAndPrice prouctGrptax on prouctGrptax.purchaseTaxId=grouptax.purchasetaxgroup_id
	inner join tbl_purchasetaxdetails detail on detail.purchasetaxgroup_id=grouptax.purchasetaxgroup_id
	inner join tbl_product product on product.product_id=prouctGrptax.product_id
	inner join tbl_taxtype typeTax on typeTax.type_id=detail.type_id
	where grouptax.purchasetaxgroup_id=@purchaseTaxgroupId and prouctGrptax.product_id=@productId
	end


GO
/****** Object:  StoredProcedure [dbo].[sp_ActiveUser]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ActiveUser]
@userid int,
@uniqueid nvarchar(max)

as
 Begin
		UPDATE Tbl_EmailVerify set status=1 where user_id=@userid and uniqueidentifier = @uniqueid
		update tbl_User set status=1 where user_id=@userid 
		SELECT user_id,USER_NAME,first_name,last_name FROM tbl_User WHERE user_id=@userid

End

GO
/****** Object:  StoredProcedure [dbo].[sp_AddUser2]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_AddUser2]
@user_name nvarchar(50),
@user_emailid nvarchar(50),
@user_mobileno nvarchar(50),
@password nvarchar(50),
@role_id int,
@branch_id int,
@company_id int,
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@first_name nvarchar(50),
@last_name nvarchar(50)

as
begin   
	 IF not EXISTS(select 1 from tbl_User where user_Emai = @user_emailid and user_mobieno = @user_mobileno)
	 begin 
	   Begin Try
			Begin Transaction
				Insert into tbl_User(user_name,user_Emai,user_mobieno,password,status,created_by,created_date,first_name,last_name)
				values (@user_name,@user_emailid,@user_mobileno,@password,@status,@created_by,@created_date,@first_name,@last_name)

				declare @user_id int 
				Select @user_id = @@identity

				insert into tbl_userbranch(role_id,user_id,branch_id,status,created_by,created_date,company_id) 
				values(@role_id,@user_id,@branch_id,@status,@created_by,@created_date,@company_id)
			Commit Transaction
		End Try
	Begin Catch 
		Rollback Transaction
			insert into tbl_error_log(Error_Type,Error_Msg) values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
	End Catch 
	end
End


GO
/****** Object:  StoredProcedure [dbo].[sp_BatchInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_BatchInsert] 
@company_id int,
@branch_id int,
@batch_name nvarchar(50),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_batch (company_id,branch_id ,batch_name,status,created_by,created_date,modified_by,modified_date) values (@company_id,@branch_id,@batch_name,@status,@created_by,@created_date,@modified_by,@modified_date)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_CategoryInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_CategoryInsert] 
@company_id int,
@branch_id int,
@category_name nvarchar(50),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_category (company_id,branch_id ,category_name,status,created_by,created_date,modified_by,modified_date) values (@company_id,@branch_id,@category_name,@status,@created_by,@created_date,@modified_by,@modified_date)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_checklicense]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--sp_helptext sp_checklicense


     CREATE PROCEDURE [dbo].[sp_checklicense] 
  @company_id int,
  @user_id int,
  @free_count int out,
  @Subscription_count int out
 as
 begin
	 declare @e_date smalldatetime,
			 @s_date smalldatetime,
			 @daydiff int

			 if exists(select * from tbl_subscription where company_id=@company_id and status=1 )
				 begin
			    	 select @s_date=start_date,@e_date =end_date from tbl_paidpayment as p inner join tbl_subscription as s
						 on s.subscription_id=p.subscription_id  where p.company_id=@company_id 
						 and s.status=1

						 SET @daydiff= DATEDIFF(day, GETDATE(), @e_date)  
 
						 if (@daydiff>=1)
								  begin
									set @Subscription_count=1
										set @free_count=1
								  end
						 else
								  begin
									set @Subscription_count=0
									set @free_count=0
								  end
				 end
			 
			 else
			    begin
					select @s_date=created_date from tbl_company where company_id=@company_id
					select @e_date= (@s_date+30)
						 SET @daydiff= DATEDIFF(day, GETDATE(), @e_date) 
						  if (@daydiff>=1)
								  begin
									set @free_count=1
									set @Subscription_count=1
								  end
						 else
								  begin
									set @free_count=0
									set @Subscription_count=0
								  end
				end

		
  end






GO
/****** Object:  StoredProcedure [dbo].[sp_checkrackingodown]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_checkrackingodown] 
  @company_id int,
  @godown_id int,
  @value nvarchar(50)
 as
 begin

 Select rack_name from tbl_rack where company_id=@company_id and godown_id=@godown_id and rack_name=@value
 
 
  end


GO
/****** Object:  StoredProcedure [dbo].[Sp_checkResetPwdlink]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Created By :- AL hamed Mohammed
--Created Date :- 04/04/2018
--Perpose :- For Updating new password

CREATE PROCEDURE [dbo].[Sp_checkResetPwdlink] 
@userid int,
 @uniqueid varchar(max),
 @pid int
as
 Begin
    Begin Try
     Begin Transaction
		
			select * from Tbl_VerifyResetPass where user_id=@userid And Passverify_ID = @pid And uniqueidentifier=@uniqueid 
			
Commit Transaction
	End Try
	Begin Catch 
	Rollback Transaction
		insert into tbl_error_log(error_type,error_msg)
		values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
	End Catch 
End



GO
/****** Object:  StoredProcedure [dbo].[sp_checkuser]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_checkuser] 
  @user_Emai nvarchar(50)
 as
 begin
 begin try
 begin transaction

 Select user_Emai from tbl_User where user_Emai=@user_Emai
 
 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_checkusermobil]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_checkusermobil] 
  @user_mobieno nvarchar(50)
 as
 begin
 begin try
 begin transaction

 Select user_mobieno from tbl_User where user_mobieno=@user_mobieno
 
 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_CompanyInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_CompanyInsert] 
@company_name nvarchar(50),
@owner_emailid nvarchar(50),
@owner_mobileno nvarchar(50),
@country_id int,
@pincode nvarchar(50),
@created_by nvarchar(50),
@created_date smalldatetime,
@first_name nvarchar(50),
@last_name nvarchar(50)


as
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_company(company_name,owner_emailid,owner_mobileno,country_id,pincode,status,created_by,created_date,first_name,last_name)
 values (@company_name,@owner_emailid,@owner_mobileno,@country_id,@pincode,1,@created_by,@created_date,@first_name,@last_name)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(Error_Type,Error_Msg) values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End

GO
/****** Object:  StoredProcedure [dbo].[sp_dashboarddata]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_dashboarddata]
@conpanyid int
as
begin

	select count(purchase_id) as [TotalPurchaseOrder], sum(payd.GrandTotal) as [TotalAmountofPurchase] 
	from tbl_purchase  inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=purchase_id
	where created_date between Getdate() - 30 and Getdate() and status = 1
	and company_id = @conpanyid
	
	select count(sale_id) as [TotalSalesOrder], sum(payd.GrandTotal) as [TotalAmountofSale] 
	from tbl_sale  inner join tbl_SalePaymentDetails payd on payd.SaleId=sale_id
	where created_date between Getdate() - 30 and Getdate() and status = 1
	and company_id = @conpanyid

	select top 10 p.product_name, count(sd.product_id) as [ProductCount], sd.product_id as [ProductID], sum(sd.amount) as [TotalSaleAmount] 
	from tbl_saledetails sd
	join tbl_product p on p.product_id = sd.product_id  
	where sd.created_date between DATEADD(day,-30, getdate()) and getdate()
	and company_id = @conpanyid
	group by sd.product_id, p.product_name
	order by count(sd.product_id) desc

	select COUNT(party_id) as [Total Count], party_type from tbl_party
	where company_id = @conpanyid and party_type in ('Vendor','Customer')
	group by party_type

end

GO
/****** Object:  StoredProcedure [dbo].[sp_Deletebatch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_Deletebatch] 
 @company_id int,
 @batch_id int,
 @branch_id int
 as
 begin
 begin try
 begin transaction
  update tbl_batch set status=0  where company_id=@company_id and batch_id=@batch_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteBranch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteBranch] 
 
 @branch_id int,
 @company_id int
 as
 begin
 begin try
 begin transaction
  update tbl_branch set status=0
     where company_id=@company_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCategory]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteCategory] 
 @company_id int,
 @category_id int,
 @branch_id int
 as
 begin
 begin try
 begin transaction
  update tbl_category set status=0  where company_id=@company_id and category_id=@category_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteExpense]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteExpense] 
 @company_id int,
 @branch_id int,
 @expense_id int
 as
 begin
 begin try
 begin transaction
  update tbl_expense set status=0  where company_id=@company_id and expense_id=@expense_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteFyear]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteFyear] 
 @company_id int,
 @branch_id int,
 @financialyear_id int
 as
 begin
 begin try
 begin transaction
  update tbl_financialyear set status=0  where company_id=@company_id and financialyear_id=@financialyear_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteGodown]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteGodown] 
@company_id int,
@branch_id int,
@godown_id int
 as
 begin
 begin try
 begin transaction
  update tbl_godown set status=0
    where company_id=@company_id and godown_id=@godown_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteParty]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_DeleteParty] 
@company_id int, 
@branch_id int,
@party_id int
 as
 begin
 begin try
 begin transaction
  update tbl_party set status=0
   where company_id=@company_id and party_id=@party_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePMode]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeletePMode] 
 @company_id int,
 @branch_id int,
 @paymentode_id int
 as
 begin
 begin try
 begin transaction
  update tbl_paymentmode set status=0
  where company_id=@company_id and paymentode_id=@paymentode_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteProduct]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteProduct] 
 @company_id int,
 @product_id int
 as
 begin
 begin try
 begin transaction
  update tbl_product set status=0  
   where company_id=@company_id and product_id=@product_id 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePurchasedetailbyreutrn]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_DeletePurchasedetailbyreutrn] 



@purchase_id int,
@purchasedetails_id int
 as
 begin
 begin try
 begin transaction

update tbl_purchasedetails set status=0 where purchase_id=@purchase_id and purchasedetails_id=@purchasedetails_id 


 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteRack]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteRack] 
 @company_id int,
 @branch_id int,
 @rack_id int
 as
 begin
 begin try
 begin transaction
  update tbl_rack set status=0
     where company_id=@company_id and rack_id=@rack_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_deleteSladetail]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_deleteSladetail]
   
@sale_id int,
@saledetails_id int


 as
 begin
 begin try
 begin transaction

		update tbl_saledetails set status=0 where sale_id=@sale_id and saledetails_id=@saledetails_id

		 
   
    commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteTax]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteTax] 
 @company_id int,
  @branch_id int,
 @tax_id int
 as
 begin
 begin try
 begin transaction
  update tbl_tax set status=0
    where company_id=@company_id and tax_id=@tax_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUnit]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteUnit] 
 @company_id int,
 @branch_id int,
 @unit_id int
 as
 begin
 begin try
 begin transaction
  update tbl_unit set status=0  
  where company_id=@company_id and unit_id=@unit_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUser]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_DeleteUser] 
 @company_id int,
 @userbranch_id int,
 @user_id int,
 @branch_id int
 as
 begin
 begin try
 begin transaction
  update tbl_userbranch set status=0  where company_id=@company_id and userbranch_id=@userbranch_id and branch_id=@branch_id

  
  update tbl_user set status=0  where user_id=@user_id 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_ExpenseInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_ExpenseInsert] 
@company_id int,
@branch_id int,
@expense_name nvarchar(50),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
if not EXISTS(select 1 from tbl_expense where company_id=@company_id and branch_id=@branch_id and expense_name=@expense_name)
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_expense(company_id,branch_id ,expense_name,status,created_by,created_date,modified_by,modified_date) values (@company_id,@branch_id,@expense_name,@status,@created_by,@created_date,@modified_by,@modified_date)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_FyInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_FyInsert] 
@company_id int,
@branch_id int,
@start_date nvarchar(50),
@end_date nvarchar(50),
@created_by nvarchar(50),
@created_date smalldatetime


as
 Begin
	 declare @e_date smalldatetime
		select @e_date=end_date  from tbl_financialyear where company_id=@company_id and status=1
			 if(GETDATE()>@e_date)
				 begin
					 Insert into tbl_financialyear(company_id,branch_id ,start_date,end_date,status,created_by,created_date,Is_new)
					 values (@company_id,@branch_id,@start_date,@end_date,1,@created_by,@created_date,0)
				 end
			 else
				 begin
					Insert into tbl_financialyear(company_id,branch_id ,start_date,end_date,Is_new,created_by,created_date,status)
					 values (@company_id,@branch_id,@start_date,@end_date,1,@created_by,@created_date,0)
				 end
   End

GO
/****** Object:  StoredProcedure [dbo].[Sp_GetExistsMobile]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[Sp_GetExistsMobile] 
 @user_mobieno varchar(50)
 as
begin
begin try
begin transaction
	 Select @user_mobieno from tbl_User where user_mobieno = @user_mobieno;
commit transaction
end try
begin catch
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[sp_GetPurchaseDetailsById]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext sp_GetPurchaseDetailsById

--sp_helptext sp_GetPurchaseDetailsById



  CREATE PROCEDURE [dbo].[sp_GetPurchaseDetailsById] 

@purchsae_id int

 as
 begin


 select
 pd.purchasedetails_id,
pd.product_id,pd.batch_id,pd.unit_id,pd.tax_id,
pd.amount,pd.dicount_amt,pd.tax_amt,ap.purchase_rate,ap.sale_price as sale_rate,
pd.quantity,
pt.product_name,
u.unit_name,
b.batch_name,
ptg.group_id,
ptg.totalTaxPercentage as tax_percentage,
ap.discount_percent,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,payd.SubTotal as total_amnt,payd.DiscountAmount as total_discount,payd.TaxAmount as total_tax,payd.GrandTotal as grand_total
 from (((( tbl_purchasedetails as pd inner join tbl_purchase p on p.purchase_id=pd.purchase_id
inner join tbl_product as pt on pt.product_id=pd.product_id)
inner join tbl_unit as u  on u.unit_id=pd.unit_id)
inner  join tbl_batch as b on b.batch_id=pd.batch_id)
inner join tbl_purchasetaxgroup ptg on ptg.purchaseId=p.purchase_id)
inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=pd.purchase_id and ap.product_id=pd.product_id
inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=p.purchase_id
 where pd.purchase_id=@purchsae_id and pd.status=1




  end

GO
/****** Object:  StoredProcedure [dbo].[sp_GetSaleDetailsById]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_GetSaleDetailsById] 

@saleId int

 as
 begin

 select
 sd.saledetails_id,
sd.product_id,sd.batch_id,sd.unit_id,stg.group_id,
sd.amount,sd.dicount_amt,sd.tax_amt,ap.sale_rate,
sd.quantity,
pt.product_name,
u.unit_name,
b.batch_name,
stg.totalTaxPercentage as tax_percentage,
ap.discount_percent,payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt,
payd.SubTotal as total_amnt,payd.DiscountAmount as total_discount,payd.TaxAmount as total_tax,payd.GrandTotal as grand_total
 from (((( tbl_saledetails as sd inner join tbl_sale s on s.sale_id=sd.sale_id
inner join tbl_product as pt on pt.product_id=sd.product_id)
inner join tbl_unit as u  on u.unit_id=sd.unit_id)
inner  join tbl_batch as b on b.batch_id=sd.batch_id)
inner join tbl_saleTaxGroup stg on stg.sale_id=s.sale_id)
inner join tbl_ActualSalesTaxAndPrice ap on ap.sale_id=sd.sale_id and ap.product_id=sd.product_id
inner join tbl_SalePaymentDetails payd on payd.SaleId=s.sale_id
 where sd.sale_id=@saleId and sd.status=1

 

  end

GO
/****** Object:  StoredProcedure [dbo].[sp_godowninsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_godowninsert] 

@company_id int,
@branch_id int,
@godown_name nvarchar(50),
@godown_address nvarchar(50),
@contact_no varchar(50),
@contact_person nvarchar(50),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_godown(company_id,branch_id ,godown_name,godown_address,contact_no,contact_person,status,created_by,created_date,modified_by,modified_date) values (@company_id,@branch_id,@godown_name,@godown_address,@contact_no,@contact_person,@status,@created_by,@created_date,@modified_by,@modified_date)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_insert_purchase_return]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    CREATE PROCEDURE [dbo].[sp_insert_purchase_return] 
@purchasedetails_id int,
@purchasereturn_id int,
@batch_id int,
@product_id int,
@tax_amt decimal(18, 0),
@quantity decimal(18, 0),
@amount	decimal(18, 0),
@created_by nvarchar(50),
@created_date nvarchar(50)


 as
 begin

 declare 
 
		@unit_id int,
		@tax_id int,
		@transactio_type_id int,
		@qty1 decimal(18, 0),
		@diffrence_qty decimal(18, 0),
		@company_id int,
		@branch_id int ,
		@quanty decimal(18, 0),
		@quanty1 decimal(18, 0)
					select      @unit_id=unit_id,@tax_id=tax_id from tbl_product where product_id=@product_id 

					select      @quanty1=quantity from tbl_purchasedetails where purchasedetails_id=@purchasedetails_id and product_id=@product_id 
					insert into tbl_purchasereturndetails (purchasereturn_id,batch_id,product_id,unit_id,tax_id,tax_amt,quantity,amount,status,created_by,created_date)
					values		(@purchasereturn_id,@batch_id,@product_id,@unit_id,@tax_id,@tax_amt,@quantity,@amount,1,@created_by,@created_date)
		
					select		@transactio_type_id=@@IDENTITY
				   -- set			@diffrence_qty=@quanty1-@quantity
					--select		@qty1=qty from tbl_stock where product_id=@product_id 
					update		 tbl_stock set qty = qty-@quantity

					where		 product_id=@product_id 
					select      @quanty=quantity from tbl_purchasereturndetails where purchasereturndetails_id=@transactio_type_id
					select		@company_id=company_id, @branch_id=branch_id from tbl_product where product_id=@product_id


		    insert into tbl_stocktransaction
													(company_id,
													branch_id,
													stocktransaction_typ,
													product_id,
													batch_id,
													qty,
													in_out,
													status,
													created_by,
													created_date,
													transactio_type_id
													) 
											values (@company_id,
													@branch_id,
													'Purchase Return',
													@product_id,
													@batch_id,
													@quantity,
													'out',
													1,
													@created_by,
													@created_date,
													@transactio_type_id)
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertBranch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_InsertBranch] 
 @company_id int,
 @branch_name nvarchar(50),
 @branch_address nvarchar(500),
 @pincode nvarchar(50),
 @telephone_no nvarchar(50),
 @fax_no nvarchar(50),
 @country_id int,
 @state_id int,
 @city nvarchar(200),
 @created_by  nvarchar(50),
 @created_date datetime
 as
 begin
 begin try
 begin transaction
  insert into tbl_branch(company_id,branch_name,branch_address,country_id,state_id,pincode,city,telephone_no,fax_no,status,created_by,created_date)
  values (@company_id,@branch_name,@branch_address,@country_id,@state_id,@pincode,@city,@telephone_no,@fax_no,1,@created_by,@created_date)
   
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertMonyTransaction]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure[dbo].[sp_InsertMonyTransaction] 
@company_id int,
@branch_id int,
@party_id int,
@given_amt decimal(18, 0),
@grand_total decimal(18, 0),
@balance_amt decimal(18, 0),
@in_out varchar(20),
@paymentmode_id int,
@transaction_typ nvarchar(100),
@transactio_type_id int,
@created_by nvarchar(50),
@created_date smalldatetime
as
 Begin   
			insert into tbl_monytransaction(
						company_id,
						branch_id,
						transaction_typ,
						paymentmode_id,
						total_bil_amt,
						given_amt,
						balance_amt,
						in_out,
						status,
						party_id,
						transactio_type_id,
						created_by,
						created_date)
				values(
						@company_id,
						@branch_id,
						@transaction_typ,
						@paymentmode_id,
						@grand_total,
						@given_amt,
						@balance_amt,
						@in_out
						,1,
						@party_id,
						@transactio_type_id,
						@created_by,
						@created_date)

						---Mony Logic-----
						 declare @reciveableamt decimal(18, 0)= 0
											,@payableamt decimal(18, 0)= 0
								 	IF NOT EXISTS (SELECT * FROM tbl_mony where party_id=@party_id and company_id=@company_id)
										   begin
										     	if(@in_out='in')
													 begin 
														set @reciveableamt=@balance_amt
													 end
												else
													  begin
														set @payableamt=@balance_amt
													  end
										            
												 insert into tbl_mony(company_id,branch_id,party_id,payableamt,reciveableamt,status,created_by,created_date)
												 values(@company_id,@branch_id,@party_id,@payableamt,@reciveableamt,1,@created_by,@created_date)
											 end
									else
										   begin

										   if(@balance_amt>0)
												 begin
														select @reciveableamt=reciveableamt,@payableamt=payableamt from tbl_mony 
														where company_id=@company_id and party_id=@party_id

													if(@in_out='in')
														 	 	 begin 
												set	@reciveableamt=@balance_amt+@reciveableamt
													 end
													else
														  	  	  begin
												set	  @payableamt=@balance_amt+@payableamt
													  end
													IF(@payableamt>@reciveableamt)
														 begin
														set	@payableamt=@payableamt-@reciveableamt
													set		@reciveableamt=0
														 end
													else
													     begin
													set	   @reciveableamt=@reciveableamt-@payableamt
												set		   @payableamt=0
														 end
														update tbl_mony set payableamt=@payableamt,reciveableamt=@reciveableamt,
														modified_by=@created_by,modified_date=@created_date
													    where party_id=@party_id and company_id=@company_id
												  end
											end
						

					
    end

 


GO
/****** Object:  StoredProcedure [dbo].[sp_insertpurchasereturnmain]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure[dbo].[sp_insertpurchasereturnmain] 
@company_id int,
@branch_id int,
@purchase_id int,
@total_tax decimal(18,0),
@actual_amount decimal(18, 0),
@grand_total decimal(18, 0),
@total_discount decimal(18, 0),
@created_by nvarchar(50),
@created_date smalldatetime,
@purchasereturnmain_id int out

as
 Begin
 
	 declare @financialyear_id int
	  select @financialyear_id=financialyear_id from tbl_financialyear where company_id=@company_id and status=1 
	 insert into tbl_purchasereturnmain(company_id,branch_id,purchase_id,financialyear_id,total_tax,total_discount,actual_amount,grand_total,status,created_by,created_date) 
	 values(@company_id,@branch_id,@purchase_id,@financialyear_id,@total_tax,@total_discount,@actual_amount,@grand_total,1,@created_by,@created_date)

	 
	 set @purchasereturnmain_id=@@IDENTITY
   
   End



GO
/****** Object:  StoredProcedure [dbo].[Sp_InsertResetPass]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Created By :- AL hamed Mohammed
--Created Date :- 28/03/2018
--Perpose :- For Insert in Tbl_VerifyResetPass and get details of User by UserEmail

CREATE PROCEDURE [dbo].[Sp_InsertResetPass] 
 @email varchar(50),
 @uniqueid varchar(max),
 @created_date smalldatetime
as
 Begin
    Begin Try
     Begin Transaction

		declare @userid int
		if Exists (Select user_Emai from tbl_User where user_Emai = @email)
		Begin
			 Select @userid = user_id from tbl_User where user_Emai = @email;
	
			Insert Into Tbl_VerifyResetPass ([user_id],[uniqueidentifier],[created_date],[status])
			Values (@userid,@uniqueid,@created_date,1)

				select top 1 u.first_name +' '+ u.last_name AS [username],u.user_id,vr.uniqueidentifier,vr.status,vr.Passverify_ID from tbl_User u join Tbl_VerifyResetPass vr on vr.user_id=u.user_id
				 where u.user_id = @userid order by Passverify_ID desc;
		END
		Else
		Begin
			Select 'This Email is not register with IMSbizz' 
		End
Commit Transaction
	End Try
	Begin Catch 
	Rollback Transaction
		insert into tbl_error_log(error_type,error_msg)
		values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
	End Catch 
End

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertSaleTransaction]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure[dbo].[sp_InsertSaleTransaction] 
@company_id int,
@branch_id int,
@product_id int,
@bacth_id int,
@in_out varchar(20),
@qty decimal(18, 0),
@transactio_type_id int,
@stocktransaction_typ nvarchar(100),
@created_by nvarchar(50),
@created_date smalldatetime
as
 Begin  
 ------ For Sale Stock & Stock Transaction Logic
   
       
         IF EXISTS (select * from tbl_stock where product_id=@product_id and company_id=@company_id and branch_id=@branch_id )
           Begin
             declare @qty1 int
               select @qty1=qty from tbl_stock where product_id=@product_id and company_id=@company_id and branch_id=@branch_id 
               Update tbl_stock set qty=@qty1-@qty where product_id=@product_id and company_id=@company_id and branch_id=@branch_id
           end
         ELSE 

          Begin
	         insert into tbl_stock(
	           company_id,
	           branch_id,
	           product_id,
	           batch_id,
	           qty,
	           status,
	           created_by,
			   created_date)
			 values 
			   (@company_id,
			    @branch_id,
				@product_id,
				@bacth_id,
				@qty,
				1,
				@created_by,
				 @created_date)
	
			
		End
		insert into tbl_stocktransaction
				(company_id,
				branch_id,
				stocktransaction_typ,
				product_id,
				batch_id,
				qty,
				in_out,
				status,
				created_by,
				created_date,
				transactio_type_id)
			values (@company_id,
				@branch_id,
				@stocktransaction_typ,
				@product_id,
				@bacth_id,
				@qty,
				@in_out,
				1,
				@created_by,
				@created_date,
				@transactio_type_id)
End


GO
/****** Object:  StoredProcedure [dbo].[sp_insertsalreturnmain]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure[dbo].[sp_insertsalreturnmain] 
@company_id int,
@branch_id int,
@sale_id int,
@total_tax decimal(18,0),
@actual_amount decimal(18, 0),
@grand_total decimal(18, 0),
@total_discount decimal(18, 0),
@created_by nvarchar(50),
@created_date smalldatetime,
@salereturnmain_id int out

as
 Begin
 
	 declare @financialyear_id int
	  select @financialyear_id=financialyear_id from tbl_financialyear where company_id=@company_id and branch_id=@branch_id and status=1 
	 insert into tbl_salereturnmain(company_id,branch_id,sale_id,financialyear_id,total_tax,total_discount,actual_amount,grand_total,status,created_by,created_date) 
	 values(@company_id,@branch_id,@sale_id,@financialyear_id,@total_tax,@total_discount,@actual_amount,@grand_total,1,@created_by,@created_date)

	 
	 set @salereturnmain_id=@@IDENTITY
   
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_InsertTransaction]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure[dbo].[sp_InsertTransaction] 
@company_id int,
@branch_id int,
@product_id int,
@bacth_id int,
@in_out varchar(20),
@qty decimal(18, 0),
@transactio_type_id int,
@stocktransaction_typ nvarchar(100),
@created_by nvarchar(50),
@created_date smalldatetime
as
 Begin  
 

		
 ------ For Purchase Stock & Stock Transaction Logic
	
		begin
			IF EXISTS (select * from tbl_stock where product_id=@product_id and company_id=@company_id )
				Begin
				declare @qty1 int
               select @qty1=qty from tbl_stock where product_id=@product_id and company_id=@company_id
			   
				    if(@qty1 is not null)
						begin
							Update tbl_stock set qty= (@qty+@qty1) where product_id=@product_id and company_id=@company_id 
						end

					else
					  begin 
					  set @qty1=0
					  Update tbl_stock set qty=@qty+@qty1 where product_id=@product_id and company_id=@company_id 
					  end
				end
			ELSE 
				 Begin
				insert into tbl_stock(
					company_id,
					 branch_id,
					product_id,
					 batch_id,
					qty,
					status,
					created_by,
					created_date)
				 values 
					(@company_id,
					 @branch_id,
					 @product_id,
					 @bacth_id,
					 @qty,
					 1,
					 @created_by,
					 @created_date)
	 
				
				 end
				 insert into tbl_stocktransaction
						(company_id,
						branch_id,
						stocktransaction_typ,
						product_id,
						batch_id,
						qty,
						in_out,
						status,
						created_by,
						created_date,
						transactio_type_id)
				values (@company_id,
						@branch_id,
						@stocktransaction_typ,
						@product_id,
						@bacth_id,
						@qty,
						@in_out,
						1,
						@created_by,
						@created_date,
						@transactio_type_id)
	
		End
	

 End




GO
/****** Object:  StoredProcedure [dbo].[sp_last15daysf_year]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_last15daysf_year] 
  @company_id int,
  @days_flag int out,
  @enddays_flag int out,
  @s_date smalldatetime,
  @days_left int out
 as
 begin

declare @e_date smalldatetime
select @e_date=end_date  from tbl_financialyear where company_id=@company_id and status=1
set  @days_left=DATEDIFF(day, @s_date, @e_date) 

		 if(@days_left<=15 AND @days_left>=1 )
			 begin
			set	@days_flag=1
			 end
		  else if(@days_left<=0)
				begin 
				--logic for Popup
						--set end days flag to 0
						set @enddays_flag=1

				-- update previous fy to non-active
					update tbl_financialyear set status=0 where company_id=@company_id and status=1
				end
		IF  EXISTS (select * from tbl_financialyear where company_id=@company_id and Is_new=1)
					begin
					--logic for notification
						--set flag to 1
						set @enddays_flag=0
						set @days_flag=0
						-- update new fy to active
						 if(@days_left<=0)
							begin 
							--logic for Popup
									--set end days flag to 0
								update tbl_financialyear set is_new=0 ,status=1 where company_id=@company_id and status=0 and  Is_new=1
							end
						
					end
				
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_PartyInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_PartyInsert] 
@company_id int,
@branch_id int,
@party_name nvarchar(50),
@party_address nvarchar(500),
@contact_no varchar(50),
@gstin_no nvarchar(20),
@party_type nvarchar(20),
@status bit,
@state_id int,
@created_by nvarchar(50),
@created_date smalldatetime


as
if not EXISTS(select 1 from tbl_party where company_id=@company_id and branch_id=@branch_id and party_name=@party_name)
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_party(company_id,branch_id ,party_name,party_address,contact_no,gstin_no,party_type,status,created_by,created_date,state_id)
 values (@company_id,@branch_id,@party_name,@party_address,@contact_no,@gstin_no,@party_type,@status,@created_by,@created_date,@state_id)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_partyprint]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_partyprint] 
 @company_id int
 ,@branch_id int,
 @party_id int,
 @party_type nvarchar(50)
 as
 begin
  select party_name,party_address,contact_no from tbl_party where company_id=@company_id 
  and party_id=@party_id and party_type=@party_type
 
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_PaymentModeInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_PaymentModeInsert] 
@company_id int,
@branch_id int,
@paymentmode_name nvarchar(50),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_paymentmode(company_id,branch_id ,paymentmode_name,status,created_by,created_date,modified_by,modified_date)
 values (@company_id,@branch_id,@paymentmode_name,@status,@created_by,@created_date,@modified_by,@modified_date)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End


GO
/****** Object:  StoredProcedure [dbo].[sp_planall]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_planall] 

 as
 begin
	 select * from tbl_plan
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_product_relorderlevel_report_companybranch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_product_relorderlevel_report_companybranch]  
@company_id int,
@branch_id int 
as
begin
	Select s.stock_id, s.batch_id, p.product_id,p.product_name,p.hsn_code,p.product_code,p.reorder_level as [Reorderlevel], s.qty as [quantity],b.batch_name from tbl_product p
	join tbl_stock s on s.product_id = p.product_id inner join tbl_batch b on b.batch_id=s.batch_id
	where p.company_id = @company_id and p.branch_id = @branch_id and p.status = 1 and s.status = 1
	and s.qty < p.reorder_level
end


GO
/****** Object:  StoredProcedure [dbo].[sp_product_relorderlevel_report_forcompany_only]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_product_relorderlevel_report_forcompany_only]  
@company_id int
as
begin
	Select s.stock_id, s.batch_id, p.product_id,p.product_name,p.hsn_code,p.product_code,p.reorder_level as [Reorderlevel], s.qty as [quantity],b.batch_name from tbl_product p
	join tbl_stock s on s.product_id = p.product_id inner join tbl_batch b on b.batch_id=s.batch_id
	where p.company_id = @company_id and p.status = 1 and s.status = 1
	and s.qty < p.reorder_level
end



GO
/****** Object:  StoredProcedure [dbo].[sp_ProductInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_ProductInsert] 
@company_id int,
@branch_id int,
@category_id int,
@unit_id int,
@godown_id int,
@rack_id int,
@tax_id int,
@reorder_level int,
@product_name nvarchar(50),
@product_code nvarchar(500),
@hsn_code varchar(50),
@purchas_price decimal(18,0),
@sales_price decimal(18,0),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
if not EXISTS(select 1 from tbl_product where company_id=@company_id and branch_id=@branch_id and product_name=@product_name)
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_product(
company_id,
branch_id ,
category_id,
unit_id,
godown_id,
rack_id,
tax_id,
product_name,
product_code,
hsn_code,
reorder_level,
purchas_price,
sales_price,
status,
created_by,
created_date,
modified_by,
modified_date
)
 values (
 @company_id,
 @branch_id,
 @category_id,
 @unit_id,
 @godown_id,
 @rack_id,
 @tax_id,
 @product_name,
 @product_code,
 @hsn_code,
 @reorder_level,
 @purchas_price,
 @sales_price,
 @status,
 @created_by,
 @created_date,
 @modified_by,
 @modified_date
 )


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_productwithquantity]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_productwithquantity] 
 @company_id int,
 @branch_id int
AS
 BEGIN
 select p.product_id,p.product_name,p.product_code,p.purchas_price,p.sales_price,s.qty,p.reorder_level from tbl_product as p 
inner join tbl_stock as s on p.product_id=s.product_id where p.company_id=@company_id and p.branch_id=@branch_id
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_PurchaseDetailinsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_PurchaseDetailinsert] 
@product_id int,
@purchase_id int,
@batch_id int,
@user_id int,
@created_date nvarchar(500),
@tax_amt decimal(18,0),
@dicount_amt decimal(18, 0),
@quantity decimal(18, 0),
@amount decimal(18, 0),
@purchase_rate decimal(18, 0),
@sale_rate decimal(18, 0),
@purchasedetails_id int out


as
 Begin
	 declare 
@tax_id int,
@unit_id int
select @tax_id=tax_id,@unit_id=unit_id from tbl_product where product_id=@product_id 

insert into 
tbl_purchasedetails(purchase_id,product_id,batch_id,tax_id,unit_id,tax_amt,dicount_amt,quantity,amount,purchase_rate,sale_rate,created_by,created_date,status)
              values(@purchase_id,@product_id,@batch_id,@tax_id,@unit_id,@tax_amt,@dicount_amt,@quantity,@amount,@purchase_rate,@sale_rate,@user_id,@created_date,1)
			  select @purchasedetails_id=@@IDENTITY

End

GO
/****** Object:  StoredProcedure [dbo].[sp_Purchaseinsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_Purchaseinsert] 
@company_id int,
@branch_id int,
@party_id int,
@po_no nvarchar(100),
@Po_Date nvarchar(100),
@total_tax decimal(18,0),
@total_amnt decimal(18, 0),
@grand_total decimal(18, 0),
@total_discount decimal(18, 0),
@created_by nvarchar(50),
@created_date smalldatetime,
@InvoiceNumber nvarchar(50),
@PaymentMode_id int,
@given_amnt decimal(18, 0),
@balance_amnt decimal(18, 0),
@purchase_id int out


as
 Begin
	 declare @financialyear_id int
	  select @financialyear_id=financialyear_id from tbl_financialyear where company_id=@company_id  and status=1 
	 insert into tbl_purchase (company_id,branch_id,party_id,po_no,financialyear_id,Po_Date,total_tax,total_discount,total_amnt,grand_total,status,created_by,created_date,InvoiceNumber,PaymentMode_id,given_amnt,balance_amnt) 
	 values(@company_id,@branch_id,@party_id,@po_no,@financialyear_id,@Po_Date,@total_tax,@total_discount,@total_amnt,@grand_total,1,@created_by,@created_date,@InvoiceNumber,@PaymentMode_id,@given_amnt,@balance_amnt)

	  
	 select @purchase_id=@@IDENTITY
   
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_rackInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_rackInsert] 
@company_id int,
@branch_id int,
@godown_id int,
@rack_name nvarchar(50),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_rack(company_id,branch_id ,rack_name,godown_id,status,created_by,created_date,modified_by,modified_date) values (@company_id,@branch_id,@rack_name,@godown_id,@status,@created_by,@created_date,@modified_by,@modified_date)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End

GO
/****** Object:  StoredProcedure [dbo].[sp_Register]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--sp_helptext sp_Register


--sp_helptext sp_Register

  
CREATE procedure[dbo].[sp_Register]     
@company_name nvarchar(50),    
@first_name nvarchar(100),    
@last_name nvarchar(100),    
@owner_emailid nvarchar(50),    
@owner_mobileno nvarchar(50),    
@user_password nvarchar(50),    
@country_id int,    
@pincode nvarchar(50),    
@created_by nvarchar(50),    
@created_date smalldatetime,    
@start_date nvarchar(50),    
@end_date nvarchar(50),    
@uniqueidentity nvarchar(max),    
@IsVerified bit,    
@Ref_Mobile nvarchar(max)      
    
as    
 Begin    
  Insert into tbl_company(company_name,first_name,last_name,owner_emailid,owner_mobileno,country_id,pincode,status,created_by,created_date)     
  values (@company_name,@first_name,@last_name,@owner_emailid,@owner_mobileno,@country_id,@pincode,1,@created_by,@created_date)    
    
  declare @company_id int    
  Select @company_id=@@identity    
    
    
 Insert into tbl_branch(branch_name,company_id,country_id,pincode,status,created_by,created_date,IsMainBranch)    
 values (@company_name,@company_id,@country_id,@pincode,1,@created_by,@created_date,1)    
    
 declare @branch_id int    
 select @branch_id=@@IDENTITY    
    
 Insert into tbl_User(user_name,user_Emai,user_mobieno,password,created_by,created_date,first_name,last_name,IsVerified,Ref_Mobile,status)    
 values (@owner_emailid,@owner_emailid,@owner_mobileno,@user_password,@created_by,@created_date,@first_name,@last_name,@IsVerified,@Ref_Mobile,0)    
 declare @user_id int    
 select @user_id=@@IDENTITY    
    
 insert into tbl_userbranch(role_id,user_id,branch_id,status,created_by,created_date,company_id)    
 values(3,@user_id,@branch_id,1,@created_by,@created_date,@company_id)    
    
 Insert into tbl_financialyear(company_id,branch_id ,start_date,end_date,status,created_by,created_date)     
 values (@company_id,@branch_id,@start_date,@end_date,1,@created_by,@created_date)    
    
 insert into tbl_emailverify([user_id],[uniqueidentifier],[status],[created_date])    
 values (@user_id,@uniqueidentity,0,@created_date)    
    
 select u.first_name +' '+ u.last_name,u.user_id,ev.uniqueidentifier from tbl_User u join Tbl_EmailVerify ev on ev.user_id=u.user_id where u.user_id = @user_id;    
    
       
 End 


GO
/****** Object:  StoredProcedure [dbo].[sp_salereturn]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_salereturn] 

@sale_id int,
@saledetails_id int,
@product_id int,
@batch_id int,
@tax_amt decimal(18,0),
@dicount_amt decimal(18, 0),
@quantity int,
@amount decimal(18, 0),
@price decimal(18, 0),
@created_by nvarchar(50),
@created_date nvarchar(50)


 as
 begin
 begin try
 begin transaction
 declare @unit_id int,@tax_id int,@qty1 decimal(18,0)
 

        select       @unit_id=unit_id , @tax_id=tax_id  
		from         tbl_product
		where        product_id=@product_id
		select      @qty1=quantity from tbl_saledetails where saledetails_id=@saledetails_id and product_id=@product_id 
		insert into  tbl_salesreturn(sale_id,batch_id,product_id,unit_id,tax_id,tax_amt,quantity,amount,status,created_by,created_date)
		values		 (@sale_id,@batch_id,@product_id,@unit_id,@tax_id,@tax_amt,(@qty1-@quantity),@amount,1,@created_by,@created_date)
		
		declare		 @transactio_type_id int,@qty12 decimal(18,0), @company_id int,@branch_id int 
		
		select		 @transactio_type_id=@@IDENTITY
		
		select	     @qty12=qty from tbl_stock where product_id=@product_id 
		
		update		 tbl_stock set qty=@qty12+@quantity
		where		 product_id=@product_id 
		
		select		 @company_id=company_id, @branch_id=branch_id from tbl_product where product_id=@product_id
		
		insert into  tbl_stocktransaction
					 (company_id,
					 branch_id,
					 stocktransaction_typ,
					 product_id,
					 batch_id,
					 qty,
					 in_out,
					 status,
					 created_by,
					created_date,
					transactio_type_id
					) 
		values	    (@company_id,
					 @branch_id,
					 'Sale Return',
					 @product_id,
					 @batch_id,
					(@qty1-@quantity),
					 'IN',
					 1,
					 @created_by,
					 @created_date,
					 @transactio_type_id
					)

  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SalesDetailinsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure[dbo].[sp_SalesDetailinsert] 
@product_id int,
@sale_id int,
@batch_id int,
@user_id int,
@created_date nvarchar(500),
@tax_amt decimal(18,0),
@dicount_amt decimal(18, 0),
@quantity decimal(18, 0),
@amount decimal(18, 0),
@price decimal(18, 0),
@saledetails_id int out


as
 Begin
    
	 declare 
@tax_id int,
@unit_id int
select @tax_id=tax_id,@unit_id=unit_id from tbl_product where product_id=@product_id 

insert into 
tbl_saledetails(sale_id,product_id,batch_id,tax_id,unit_id,tax_amt,dicount_amt,quantity,amount,price,created_by,created_date,status)
              values(@sale_id,@product_id,@batch_id,@tax_id,@unit_id,@tax_amt,@dicount_amt,@quantity,@amount,@price,@user_id,@created_date,1)
    set @saledetails_id=@@IDENTITY
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_Salesinsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_Salesinsert] 
@company_id int,
@branch_id int,
@party_id int,
@invoice_no nvarchar(100),
@total_tax decimal(18,0),
@actual_amount decimal(18, 0),
@grand_total decimal(18, 0),
@total_discount decimal(18, 0),
@created_by nvarchar(50),
@created_date smalldatetime,
@InvoiceNumber nvarchar(50),
@sale_id int out

as
 Begin
	 declare @financialyear_id int
	 select @financialyear_id=financialyear_id from tbl_financialyear where company_id=@company_id and branch_id=@branch_id and status=1 
	 insert into tbl_sale(company_id,branch_id,party_id,invoice_no,financialyear_id,total_tax,total_discount,actual_amount,grand_total,status,created_by,created_date,InvoiceNumber) 
	 values(@company_id,@branch_id,@party_id,@invoice_no,@financialyear_id,@total_tax,@total_discount,@actual_amount,@grand_total,1,@created_by,@created_date,@InvoiceNumber)

	 
	 set @sale_id=@@IDENTITY

   End



GO
/****** Object:  StoredProcedure [dbo].[sp_SalesreturnProduct]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE  PROCEDURE [dbo].[sp_SalesreturnProduct] 

@salereturnmain_id int

 as
 begin

 select
 pd.salesreturn_id,
pd.product_id,pd.batch_id,pd.unit_id,pd.tax_id,
pd.amount,pd.dicount_amt,pd.tax_amt,
pd.amount,pd.quantity,
pt.product_name,
u.unit_name,
b.batch_name,
t.tax_percentage from (((( tbl_salesreturn as pd
inner join tbl_product as pt on pt.product_id=pd.product_id)
inner join tbl_unit as u  on u.unit_id=pd.unit_id)
inner  join tbl_batch as b on b.batch_id=pd.batch_id)
inner  join tbl_tax as t on t.tax_id=pd.tax_id)
where pd.salereturnmain_id=@salereturnmain_id and pd.status=1
 

  end
GO
/****** Object:  StoredProcedure [dbo].[sp_saveerror]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE procedure[dbo].[sp_saveerror] 
@company_id int,
@branch_id int,
@error_type nvarchar(50),
@error_msg nvarchar(max),
@created_by nvarchar(50),
@created_date datetime
as
 Begin
    Begin Try
     Begin Transaction

	 
Insert into tbl_error_log (company_id,branch_id,error_type,error_msg,created_by,created_date) OUTPUT INSERTED.error_log_id values (@company_id,@branch_id,@error_type,@error_msg,@created_by,@created_date)

   
     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectBatch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectBatch] 
 @company_id int
 ,@branch_id int
 as
 begin
 begin try
 begin transaction
  select batch_id, batch_name from tbl_batch where company_id=@company_id and status=1 and branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_selectbatchbyproduct]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_selectbatchbyproduct] 
 @company_id int
 ,@branch_id int,
 @product_id int
 as
 begin
 select distinct p.batch_id,b.batch_name from tbl_purchasedetails p
join tbl_batch b on p.batch_id = b.batch_id inner join tbl_ActualPurchaseTaxAndPrice ap on ap.batch_id=b.batch_id
where ap.product_id = @product_id and b.company_id=@company_id and b.branch_id=@branch_id order by batch_id
 
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_selectbatchwisequantity]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure[dbo].[sp_selectbatchwisequantity] 
@batch_id int,
@product_id int

as
 Begin
 
	--;with result as (
	--					select batch_id, 
	--					  case when in_out = 'in' then sum(qty) 
	--					   else 0
	--					  end as inTot
	--					  ,case when in_out = 'out' then sum(qty) 
	--					   else 0
	--					  end as outTot
	--					from tbl_stocktransaction where product_id = @product_id and batch_id = @batch_id
	--					group by batch_id, in_out
	--				) 
	--				select batch_id,(sum(inTot) - sum(outTot)) as StockAvl from result
	--				group by batch_id

 --  SELECT * FROM tbl_stocktransaction

 WITH StockCTE(PurchaseQty,PurchaseReturnQty,SaleQty,SaleReturnQty)
					AS
					(					
					SELECT isnull(sum(quantity),0) as PurchaseQty,0,0,0 FROM tbl_purchasedetails where product_id=@product_id and batch_id=@batch_id -- in
					union all 
					SELECT  0,isnull(sum(quantity),0) as PurchaseReturnQty,0,0  FROM tbl_purchasereturndetails  where product_id=@product_id and batch_id=@batch_id --out
					union all 
					SELECT  0,0,isnull(sum(quantity),0) as SaleQty,0 FROM tbl_saledetails  where product_id=@product_id and batch_id=@batch_id --out 
					union all 
					SELECT  0,0,0,isnull(sum(quantity),0) as SaleReturnQty  FROM tbl_salereturndetails  where product_id=@product_id and batch_id=@batch_id --in 
					)
					SELECT @batch_id as batch_id,(SUM(PurchaseQty)+SUM(SaleReturnQty))-(SUM(PurchaseReturnQty)+SUM(SaleQty)) as StockAvl FROM StockCTE
					
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_SelectBranch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectBranch] 
 @company_id int
 as
 begin
 begin try
 begin transaction
  select tbl_branch.branch_id,tbl_branch.branch_name,tbl_branch.branch_address,tbl_branch.pincode,tbl_branch.city,
  tbl_branch.state_id,tbl_branch.fax_no,tbl_branch.telephone_no,tbl_branch.country_id,tbl_country.country_name,tbl_state.state_name
  from((tbl_branch inner join tbl_country on tbl_branch.country_id=tbl_country.country_id)
  inner join tbl_state on tbl_branch.state_id=tbl_state.state_id) 
  where tbl_branch.company_id=@company_id and tbl_branch.status=1
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectBranchName]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectBranchName] 
 @company_id int,
 @value nvarchar(50)
 as
 begin
 begin try
 begin transaction
  select branch_name from tbl_branch where company_id=@company_id and branch_name=@value
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCategory]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectCategory] 
 @company_id int,
 @branch_id int
 as
 begin
  select category_id, category_name from tbl_category where company_id=@company_id and status=1 and branch_id=@branch_id
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCompany]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_SelectCompany] 
@company_id int


as
 Begin
    Begin Try
     Begin Transaction

select c.company_name,c.company_address,c.country_id,c.state_id,c.city,c.telephone_no,c.fax_no,c.pincode
,c.GSTIN,c.website,c.first_name,c.last_name,c.owner_emailid,c.owner_mobileno,cy.country_name,s.state_name
  from ((tbl_company as c left join tbl_country as cy on c.country_id=cy.country_id)
 left join tbl_state as s on c.state_id=s.state_id) where c.company_id=@company_id
     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(Error_Type,Error_Msg) values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCompany_name]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_SelectCompany_name] 

@user_id int


as
 Begin
    Begin Try
     Begin Transaction

	 select company_name from tbl_company where company_id=(select company_id from tbl_userbranch where user_id=@user_id)

     Commit Transaction
End Try
Begin Catch 

 Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End


GO
/****** Object:  StoredProcedure [dbo].[sp_selectcompanylogo]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure[dbo].[sp_selectcompanylogo] 
@company_id int

as
 Begin
 
	select logo from tbl_company where company_id=@company_id

   
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCountry]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectCountry] 
 as
 begin
 begin try
 begin transaction
  select country_id,country_name from tbl_country where status=1
  commit transaction
  end try
  begin catch

  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_SelectExpense]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[sp_SelectExpense] 
 @company_id int,
 @branch_id int
 as
 begin
 begin try
 begin transaction
  select expense_id, expense_name from tbl_expense where company_id=@company_id and status=1 and branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end

     ----------------------------------------Select FY------------------------------------------------------

	 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_SelectFY')) 
exec('CREATE PROCEDURE [dbo].[sp_SelectFY] AS BEGIN SET NOCOUNT ON; END') 

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectFinicialyeardate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_SelectFinicialyeardate] 


@company_id int

 as
 begin
 begin try
 begin transaction

select start_date,end_date from tbl_financialyear where company_id=@company_id and status=1
 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectFY]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectFY] 
 @company_id int
  ,@branch_id int
 as
 begin
 begin try
 begin transaction
  select financialyear_id, start_date,end_date from tbl_financialyear where company_id=@company_id and status=1 and branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_Selectgodown]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_Selectgodown] 
 @company_id int
  ,@branch_id int
 as
 begin
 begin try
 begin transaction
  select godown_id, godown_name,godown_address,contact_no,contact_person from tbl_godown where company_id=@company_id and status=1 and branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectParty]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectParty] 
 @company_id int
  ,@branch_id int
 as
 begin
 begin try
 begin transaction
   select tbl_party.party_id,tbl_party.party_name,tbl_party.party_address,tbl_party.contact_no,tbl_party.gstin_no,tbl_party.party_type,
  tbl_party.state_id,tbl_state.state_name from tbl_party left join tbl_state on tbl_state.state_id=tbl_party.state_id
   where tbl_party.company_id=@company_id and tbl_party.status=1 and tbl_party.branch_id=@branch_id

  commit transaction
  end try
  begin catch

  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_SelectPM]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectPM] 
 @company_id int
  ,@branch_id int
 as
 begin
 begin try
 begin transaction
  select paymentode_id , paymentmode_name from tbl_paymentmode where company_id=@company_id and status=1 and
  branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_SelectPrice]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_SelectPrice]
@company_id int,
@product_id int
 as
 begin
 begin try
 begin transaction

 Select purchas_price,sales_price  from tbl_product where product_id=@product_id and company_id=@company_id 
 
 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectProduct]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectProduct] 
 @company_id int
  ,@branch_id int
 as
 begin
 begin try
 begin transaction
  SELECT tbl_product.product_id,tbl_product.product_name,tbl_product.hsn_code,tbl_product.product_code,tbl_product.purchas_price,tbl_product.sales_price,tbl_product.reorder_level,
 tbl_product.category_id,tbl_product.godown_id,tbl_product.rack_id,tbl_product.tax_id,tbl_product.unit_id,tbl_category.category_name,tbl_unit.unit_name,tbl_godown.godown_name,tbl_rack.rack_name,tbl_tax.tax_name from((((
  ( tbl_product inner JOIN tbl_category ON tbl_product.category_id= tbl_category.category_id)
  inner JOIN tbl_unit ON tbl_product.unit_id = tbl_unit.unit_id)
   inner join tbl_godown on tbl_product.godown_id=tbl_godown.godown_id)
   inner join tbl_rack on tbl_product.rack_id=tbl_rack.rack_id)
   inner join tbl_tax on tbl_product.tax_id=tbl_tax.tax_id)
   where tbl_product.company_id=@company_id and tbl_product.status=1 and tbl_product.branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectProductbyid]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_SelectProductbyid] 

@purchsae_id int

 as
 begin
 begin try
 begin transaction

Select
pd.purchasedetails_id,
pd.product_id,pd.batch_id,pd.unit_id,pd.tax_id,
pd.amount,pd.dicount_amt,pd.tax_amt,ap.purchase_rate,
ap.sale_price,pd.quantity,
pt.product_name,
u.unit_name,
b.batch_name,
t.totalTaxPercentage from  tbl_purchasedetails as pd
inner join tbl_product as pt on pt.product_id=pd.product_id
inner join tbl_unit as u  on u.unit_id=pd.unit_id
inner  join tbl_batch as b on b.batch_id=pd.batch_id
inner  join tbl_purchasetaxgroup as t on t.purchaseId=pd.purchase_id
inner join tbl_ActualPurchaseTaxAndPrice ap on ap.purchase_id=pd.purchase_id
where pd.purchase_id=@purchsae_id and pd.status=1
 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_SelectPurchase]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectPurchase] 
 @company_id int
 as
 begin
 begin try
 begin transaction
   select tbl_purchase.purchase_id,tbl_purchase.party_id,tbl_purchase.po_no,tbl_purchase.grand_total,(CONVERT(nvarchar,tbl_purchase.created_date, 101)) as Date,
tbl_party.party_name from tbl_purchase left join tbl_party on tbl_party.party_id=tbl_purchase.party_id
where tbl_purchase.company_id=@company_id and tbl_purchase.status=1 order by tbl_purchase.purchase_id DESC  
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_selectpurchasebatch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure[dbo].[sp_selectpurchasebatch] 
@purchase_id int,
@product_id int

as
 Begin
 
	select ps.batch_id,b.batch_name from tbl_purchasedetails as ps 
	inner join tbl_batch as b on b.batch_id=ps.batch_id where purchase_id=@purchase_id and product_id=@product_id

   
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_SelectPurchaseinvoice]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectPurchaseinvoice] 
 @company_id int,
 @party_id int ,
 @invoiceNumber NVARCHAR(50),
 @start_date datetime ,
 @end_date datetime 
AS
 BEGIN
  Begin try
    begin transaction
			 DECLARE @start_dateFLAG int                
			 DECLARE @end_dateFLAG int
			 DECLARE @party_idFLAG int                
			 DECLARE @purchaseFLAG int   
			 DECLARE @bothdateflag int   
  
					if (@party_id is null or @party_id = 0)                 
						BEGIN                
							set @party_idFLAG = 1                
						END                
					else                
						BEGIN                
							set @party_idFLAG = 0                
						END  
			  
					if (@invoiceNumber is null or @invoiceNumber = '')                 
						BEGIN                
							set @purchaseFLAG = 1                
						END                
					else                
						BEGIN                
							set @purchaseFLAG = 0                
						END              
                        
					if (@start_date is null or @start_date = '')                
						BEGIN                
							set @start_dateFLAG =1                 
						END                
					else                
						BEGIN                
							set @start_dateFLAG =0                
						END                
                            
					if (@end_date is null or @end_date = '' )                
						BEGIN                
							set @end_dateFLAG =1                 
						END                
					else                
						BEGIN                
							set @end_dateFLAG =0                
						END 
                    
				    if (@start_dateFLAG = 0 and @end_dateFLAG = 0)
						begin
							set @bothdateflag = 0
						end
						else
						begin
							set @bothdateflag = 1
						end
        
		if (@bothdateflag = 0)
		Begin
					select tbl_purchase.purchase_id,tbl_purchase.party_id,tbl_purchase.InvoiceNumber,payd.GrandTotal as grand_total,(CONVERT(nvarchar,tbl_purchase.created_date, 101)) as Po_Date,
								tbl_party.party_name,payd.paidAmnt, payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt from tbl_purchase inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=purchase_id left join tbl_party on tbl_party.party_id=tbl_purchase.party_id								
								where
								 (tbl_purchase.company_id=@company_id and tbl_purchase.status=1) 
								 and (@purchaseFLAG=1 or tbl_purchase.InvoiceNumber=@invoiceNumber) 
								 and(@party_idFLAG=1 or tbl_purchase.party_id=@party_id)
								 and(@bothdateflag=1 or CAST(tbl_purchase.created_date as Date) between @start_date and @end_date)
								 --and(@end_dateFLAG=1 or (CONVERT(nvarchar,tbl_purchase.created_date, 101))=@end_date))
								 order by tbl_purchase.purchase_id DESC
	    end
		else
		Begin
				select tbl_purchase.purchase_id,tbl_purchase.party_id,tbl_purchase.InvoiceNumber,payd.GrandTotal as grand_total,(CONVERT(nvarchar,tbl_purchase.created_date, 101)) as Po_Date,
								tbl_party.party_name,payd.paidAmnt, payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt  from tbl_purchase inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=purchase_id left join tbl_party on tbl_party.party_id=tbl_purchase.party_id
								where
								 ((tbl_purchase.company_id=@company_id and tbl_purchase.status=1) 
								 and (@purchaseFLAG=1 or tbl_purchase.InvoiceNumber=@invoiceNumber) 
								 and(@party_idFLAG=1 or tbl_purchase.party_id=@party_id)
								 and(@start_dateFLAG=1 or (CAST(tbl_purchase.created_date as Date))=@start_date)
								 and(@end_dateFLAG=1 or (CAST(tbl_purchase.created_date as Date))=@end_date))
								  order by tbl_purchase.purchase_id DESC			
		End
          commit transaction
	 end try
	 begin catch
		  Rollback Transaction
				insert into tbl_error_log(error_type,error_msg)
				 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
	end catch
  end

  	----------------------------------------Select sp_SelectPurchaseinvoicebyid------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_SelectPurchaseinvoicebyid')) 
exec('CREATE PROCEDURE [dbo].[sp_SelectPurchaseinvoicebyid] AS BEGIN SET NOCOUNT ON; END') 

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectPurchaseinvoicebyid]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_SelectPurchaseinvoicebyid] 
@purchsae_id int,
@company_id int

 as
 begin
 begin try
 begin transaction

 select p.party_id,payd.SubTotal as actual_amount, (CONVERT(nvarchar,p.created_date, 101)) as Date,payd.DiscountAmount as discount,
p.po_no,payd.GrandTotal as grand_total,payd.TaxAmount as total_tax,
py.party_name,mony.balance_amt,mony.given_amt
 from (( tbl_purchase as p inner join tbl_PurchasePaymentDetials payd on payd.PurchaseId=p.purchase_id 
inner  join tbl_party as py on py.party_id=p.party_id)inner join tbl_monytransaction as mony on mony.transactio_type_id=p.purchase_id )
where  p.purchase_id=@purchsae_id and  p.company_id=@company_id and p.status=1
 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_Selectquantity]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE PROCEDURE [dbo].[sp_Selectquantity] 


@company_id int,
@product_id int

 as
 begin
 begin try
 begin transaction

select qty from tbl_stock where company_id=@company_id and product_id= @product_id

  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectRack]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectRack] 
 @company_id int
  ,@branch_id int
 as
 begin
  begin try
  begin transaction

 
  select tbl_rack.rack_id,tbl_rack.rack_name,tbl_godown.godown_name,tbl_rack.godown_id 
  from tbl_rack  right join tbl_godown on tbl_rack.godown_id=tbl_godown.godown_id
   where tbl_rack.company_id=@company_id and tbl_rack.status=1 and tbl_rack.branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end



GO
/****** Object:  StoredProcedure [dbo].[sp_Selectsaleid]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_Selectsaleid] 




 as
 begin
 begin try
 begin transaction

 SELECT max(sale_id) as order_id FROM tbl_sale

 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectSaleinvoice]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_SelectSaleinvoice] 

@sale_id int,
@company_id int

 as
 begin
 begin try
 begin transaction

 select p.party_id,payd.SubTotal as actual_amount, (CONVERT(nvarchar,p.created_date, 101)) as Date,payd.DiscountAmount as total_discount,
p.InvoiceNumber,payd.GrandTotal as grand_total,payd.TaxAmount as total_tax,
py.party_name,mony.balance_amt,mony.given_amt
 from (( tbl_sale as p inner join tbl_SalePaymentDetails payd on payd.SaleId=p.sale_id
inner  join tbl_party as py on py.party_id=p.party_id)inner join tbl_monytransaction as mony on mony.transactio_type_id=p.sale_id )
where  p.sale_id=@sale_id and  p.company_id=@company_id and p.status=1
 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_Selectsaleproduct]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_Selectsaleproduct] 

@sale_id int

 as
 begin
 begin try
 begin transaction

 select
 pd.saledetails_id,
pd.product_id,pd.batch_id,pd.unit_id,pd.tax_id,
pd.amount,pd.dicount_amt,pd.tax_amt,
ap.sale_rate,pd.quantity,
pt.product_name,
u.unit_name,
b.batch_name,
t.tax_percentage from  tbl_saledetails as pd
inner join tbl_product as pt on pt.product_id=pd.product_id
inner join tbl_unit as u  on u.unit_id=pd.unit_id
inner  join tbl_batch as b on b.batch_id=pd.batch_id
inner  join tbl_tax as t on t.tax_id=pd.tax_id
inner join tbl_ActualSalesTaxAndPrice as ap on ap.sale_id=pd.sale_id
where pd.sale_id=@sale_id and pd.status=1
 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_SelectSalesReport]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext sp_SelectSalesReport --4,0,null,null,null
--select * from tbl_sale where company_id=4

CREATE PROCEDURE [dbo].[sp_SelectSalesReport] 

 @company_id int,
 @partyid int,
 @invoiceNumber nvarchar(100),
 @fromdate smalldatetime,
 @enddate smalldatetime
 as
 begin
  DECLARE @bothdateflag int  
if (@partyid = 0 OR @partyid = null)
begin
 set @partyid = null
end	
if (@invoiceNumber = '' OR @invoiceNumber = null)
begin
 set @invoiceNumber = null
end	
if (@fromdate = '' OR @fromdate = null)
begin
 set @fromdate = null
end	
if (@enddate = '' OR @enddate = null)
begin
 set @enddate = null
end	
if((@fromdate != '' OR @fromdate != null) and (@enddate != '' OR @enddate != null))
begin
 set @bothdateflag = 0
end	
  else
    begin
	set @bothdateflag =1
	end
	if(@bothdateflag=0)
	begin
		  SELECT s.sale_id,spd.PaidAmnt,spd.BalanceAmnt,spd.GivenAmnt,s.InvoiceNumber,p.party_id,p.party_name as [customerName],payd.GrandTotal as grand_total,CONVERT(varchar(20), s.created_date,101) as [date], payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt
		  FROM tbl_sale s  inner join tbl_SalePaymentDetails payd on payd.SaleId=s.sale_id
		  JOIN tbl_party p on s.party_id = p.party_id 
		  inner join tbl_SalePaymentDetails as spd on spd.SaleId=s.sale_id
		  where s.company_id=@company_id and s.status=1
		  And (@partyid is Null or s.party_id=@partyid)
		  And (@invoiceNumber is Null or s.InvoiceNumber = @invoiceNumber)
		  And (@bothdateflag =1  or CAST(s.created_date as Date) between @fromdate and  @enddate) 
		  order by s.sale_id desc
		 
	end
	else
	  begin 
			SELECT s.sale_id,spd.PaidAmnt,spd.BalanceAmnt,spd.GivenAmnt,s.InvoiceNumber,p.party_id,p.party_name as [customerName],payd.GrandTotal as grand_total,CONVERT(varchar(20), s.created_date,101) as [date], payd.GivenAmnt as given_amnt,payd.BalanceAmnt as balance_amnt
			  FROM tbl_sale s inner join tbl_SalePaymentDetails payd on payd.SaleId=s.sale_id
			  JOIN tbl_party p on s.party_id = p.party_id 
		  inner join tbl_SalePaymentDetails as spd on spd.SaleId=s.sale_id
			  where s.company_id=@company_id and s.status=1
			  And (@partyid is Null or s.party_id=@partyid)
			  And (@invoiceNumber is Null or s.InvoiceNumber = @invoiceNumber)
			  And (@fromdate is Null or s.created_date >= @fromdate)
			  And (@enddate is Null or s.created_date <= @enddate)
			  order by s.sale_id desc
	  end
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_selectspurchaseproduct]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure[dbo].[sp_selectspurchaseproduct] 
@purchase_id int

as
 Begin
 
	select ps.product_id,p.product_name from tbl_purchasedetails as ps
	 inner join tbl_product as p on p.product_id=ps.product_id where purchase_id=@purchase_id
   
   End



GO
/****** Object:  StoredProcedure [dbo].[sp_SelectTax]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectTax] 
 @company_id int
 ,@branch_id int
 as
 begin
 begin try
 begin transaction
  select tax_id, tax_name,tax_percentage from tbl_tax where company_id=@company_id and status=1 and branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectTaxpercent]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectTaxpercent] 
 @company_id int,
 @product_id int
 as
 begin
 begin try
 begin transaction

 select tbl_product.tax_id,tbl_product.unit_id,tbl_tax.tax_percentage,
 tbl_unit.unit_name,tbl_purchasedetails.batch_id,tbl_batch.batch_name from((((
 tbl_product inner join tbl_tax on tbl_tax.tax_id=tbl_product.tax_id)inner join
 tbl_unit on tbl_unit.unit_id=tbl_product.unit_id) 
 left join tbl_purchasedetails on tbl_purchasedetails.product_id=tbl_product.product_id )
 left join tbl_batch on tbl_batch.batch_id=tbl_purchasedetails.batch_id) 
 where tbl_product.product_id=@product_id and tbl_product.company_id=@company_id 

  commit transaction
  end try
  begin catch
   Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_SelectUnit]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_SelectUnit] 
 @company_id int
 ,@branch_id int
 as
 begin
 begin try
 begin transaction
  select unit_id, unit_name from tbl_unit where company_id=@company_id and status=1 and branch_id=@branch_id
  commit transaction
  end try
  begin catch

  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectUserRole]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_SelectUserRole]
@company_id int

as
 Begin
    Begin Try
     Begin Transaction
	 Select tbl_userbranch.userbranch_id,tbl_role.role_id,tbl_userbranch.branch_id,tbl_User.user_id,tbl_User.user_Emai,tbl_User.password,
	 tbl_User.user_mobieno, tbl_User.first_name,tbl_User.last_name,tbl_role.role_name,tbl_branch.branch_name from (((
	 tbl_userbranch inner join tbl_User on tbl_userbranch.user_id=tbl_User.user_id)
	 inner join tbl_role on tbl_userbranch.role_id=tbl_role.role_id)
	 inner join tbl_branch on tbl_userbranch.branch_id=tbl_branch.branch_id)
	 where tbl_userbranch.company_id=@company_id and tbl_userbranch.status=1 and tbl_User.status=1
     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(Error_Type,Error_Msg) values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End




GO
/****** Object:  StoredProcedure [dbo].[sp_taxInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_taxInsert] 
@company_id int,
@branch_id int,
@tax_name nvarchar(50),
@tax_percentage decimal(18,2),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_tax(company_id,branch_id ,tax_name,tax_percentage,status,created_by,created_date,modified_by,modified_date) values (@company_id,@branch_id,@tax_name,@tax_percentage,@status,@created_by,@created_date,@modified_by,@modified_date)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End


GO
/****** Object:  StoredProcedure [dbo].[sp_UnitInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_UnitInsert] 

@company_id int,
@branch_id int,
@unit_name nvarchar(50),
@status bit,
@created_by nvarchar(50),
@created_date smalldatetime,
@modified_by nvarchar(50),
@modified_date smalldatetime


as
 Begin
    Begin Try
     Begin Transaction

Insert into tbl_unit (company_id,branch_id ,unit_name,status,created_by,created_date,modified_by,modified_date) values (@company_id,@branch_id,@unit_name,@status,@created_by,@created_date,@modified_by,@modified_date)


     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End


GO
/****** Object:  StoredProcedure [dbo].[sp_Updatebatch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_Updatebatch] 
 @company_id int,
 @batch_id int,
 @branch_id int,
 @batch_name nvarchar(50),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
 begin try
 begin transaction
  update tbl_batch set batch_name=@batch_name,modified_by=@modified_by,modified_date=GETDATE()   where company_id=@company_id and batch_id=@batch_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateBranch]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateBranch] 
 
 @branch_id int,
 @company_id int,
 @branch_name nvarchar(50),
 @branch_address nvarchar(500),
 @pincode nvarchar(50),
 @telephone_no nvarchar(50),
 @fax_no nvarchar(50),
 @country_id int,
 @state_id int,
 @city nvarchar(200),
 @modified_by nvarchar(50)
 as
 begin
 begin try
 begin transaction
  update tbl_branch set branch_name=@branch_name,branch_address=@branch_address,pincode=@pincode,telephone_no=@telephone_no,fax_no=@fax_no
  ,country_id=@country_id,state_id=@state_id,city=@city,modified_by=@modified_by,modified_date=GETDATE()
     where company_id=@company_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCategory]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateCategory] 
 @company_id int,
 @category_id int,
 @category_name nvarchar(50),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
 begin try
 begin transaction
  update tbl_category set category_name=@category_name,modified_by=@modified_by,modified_date=GETDATE()  
   where company_id=@company_id and category_id=@category_id 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCompany]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_UpdateCompany] 
@company_id int,
@company_name nvarchar(50),
@company_address nvarchar(500),
@state_id int,
@city nvarchar(50),
@telephone_no nvarchar(50),
@fax_no  nvarchar(50),
@website nvarchar(200),
@logo  nvarchar(500),
@logo_name nvarchar(100),
@GSTIN  nvarchar(50),
@modified_by nvarchar(50),
@modified_date smalldatetime


as
 Begin

update tbl_company set company_name=@company_name,company_address=@company_address,state_id=@state_id,city=@city,
telephone_no=@telephone_no,fax_no=@fax_no,website=@website,logo=@logo,logo_name=@logo_name,GSTIN=@GSTIN,modified_by=@modified_by,
modified_date=@modified_date where company_id=@company_id

   
   End

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateExpense]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateExpense] 
 @company_id int,
 @branch_id int,
 @expense_id int,
 @expense_name nvarchar(50),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
 begin try
 begin transaction
  update tbl_expense set expense_name=@expense_name,modified_by=@modified_by,modified_date=GETDATE()   where company_id=@company_id and expense_id=@expense_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateFyear]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateFyear] 
 @company_id int,
 @financialyear_id int,
 @branch_id int,
 @start_date nvarchar(50),
 @end_date nvarchar(50),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
 begin try
 begin transaction
  update tbl_financialyear set start_date=@start_date,end_date=@end_date,modified_by=@modified_by,modified_date=GETDATE()   where company_id=@company_id and financialyear_id=@financialyear_id and branch_id= @branch_id 
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGodown]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateGodown] 
@company_id int,
@branch_id int,
@godown_id int,
@godown_name nvarchar(50),
@godown_address nvarchar(500),
@contact_no varchar(50),
@contact_person nvarchar(50),
@modified_by nvarchar(50),
@modified_date smalldatetime
 as
 begin
 begin try
 begin transaction
  update tbl_godown set godown_name=@godown_name,godown_address=@godown_address,contact_no=@contact_no,contact_person=@contact_person,
  modified_by=@modified_by,modified_date=GETDATE()   where company_id=@company_id and godown_id=@godown_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateParty]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_UpdateParty] 
@company_id int, 
@branch_id int,
@party_id int,
@state_id int,
@party_name nvarchar(50),
@party_address nvarchar(500),
@contact_no varchar(50),
@party_type nvarchar(20),
@gstin_no nvarchar(20),
@modified_by nvarchar(50),
@modified_date smalldatetime
 as
 begin
 begin try
 begin transaction
  update tbl_party set party_name=@party_name,party_address=@party_address,contact_no=@contact_no,gstin_no=@gstin_no,party_type=@party_type,
  modified_by=@modified_by,modified_date=GETDATE(),state_id=@state_id   where company_id=@company_id and party_id=@party_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[Sp_UpdatePassword]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Created By :- AL hamed Mohammed
--Created Date :- 04/04/2018
--Perpose :- For Updating new password

CREATE PROCEDURE [dbo].[Sp_UpdatePassword] 
 @userid int ,
 @uniqueid varchar(max),
 @modify_date smalldatetime,
 @newpwd varchar(max),
 @pid int
as
 Begin
  

		
			UPDATE Tbl_VerifyResetPass SET status=0 WHERE user_id=@userid And Passverify_ID=@pid And uniqueidentifier = @uniqueid 
	
			UPDATE tbl_User SET password=@newpwd,modified_by=@userid,modified_date=@modify_date WHERE user_id=@userid 
			

	
End

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePMode]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdatePMode] 
 @company_id int,
 @branch_id int,
 @paymentode_id int,
 @paymentmode_name nvarchar(50),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
 begin try
 begin transaction
  update tbl_paymentmode set paymentmode_name=@paymentmode_name,modified_by=@modified_by,modified_date=GETDATE()   
  where company_id=@company_id and paymentode_id=@paymentode_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProduct]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateProduct] 
 @company_id int,
 @branch_id int,
 @product_id int,
 @category_id int,
 @rack_id int,
 @godown_id int,
 @tax_id int,
 @unit_id int,
 @reorder_level int,
 @purchas_price decimal(18, 0),
 @sales_price decimal(18, 0),
 @product_code nvarchar(50),
 @hsn_code nvarchar(50),
 @product_name nvarchar(50),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
	
  update tbl_product set product_name=@product_name,godown_id=@godown_id,category_id=@category_id,tax_id=@tax_id,hsn_code=@hsn_code,
  unit_id=@unit_id,modified_by=@modified_by,modified_date=GETDATE(),rack_id=@rack_id,purchas_price=@purchas_price,
  sales_price=@sales_price,reorder_level=@reorder_level
   where company_id=@company_id and product_id=@product_id and branch_id=@branch_id
	end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePurchase]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_UpdatePurchase] 

@purchase_id int,
@count int,
@company_id int,
@party_id int,
@po_no nvarchar(100),
@total_tax decimal(18,0),
@actual_amount decimal(18, 0),
@grand_total decimal(18, 0),
@discount decimal(18, 0),
@modified_by nvarchar(50),
@modifie_date nvarchar(50)


 as
 begin
 begin try
 begin transaction
 IF(@count!=0)
	begin
		 update tbl_purchase set po_no=@po_no,total_tax=@total_tax,actual_amount=@actual_amount
		 ,discount=@discount,grand_total=@grand_total,modified_by=@modified_by,modified_date=@modifie_date
		 where purchase_id=@purchase_id and company_id=@company_id
    end
 else
    begin
      update tbl_purchase set status=0 where purchase_id=@purchase_id and company_id=@company_id
     end
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePurchasedetails]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_UpdatePurchasedetails]
   
@purchasedetails_id int,
@product_id int,
@purchase_id int,
@batch_id int,
@tax_amt decimal(18,0),
@dicount_amt decimal(18, 0),
@quantity decimal(18, 0),
@amount decimal(18, 0),
@purchase_rate decimal(18, 0),
@sale_rate decimal(18, 0),
@modified_by nvarchar(50),
@modifie_date nvarchar(50)


 as
 begin
 begin try
 begin transaction
			
		 update tbl_purchasedetails set product_id=@product_id,batch_id=@batch_id,tax_amt=@tax_amt,dicount_amt=@dicount_amt,
		 quantity=@quantity,amount=@amount,purchase_rate=@purchase_rate,sale_rate=@sale_rate ,modified_by=@modified_by
		 ,modified_date=@modifie_date where purchase_id=@purchase_id and purchasedetails_id=@purchasedetails_id

		 
   
    commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateRack]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateRack] 
 @company_id int,
 @branch_id int,
 @rack_id int,
 @godown_id int,
 @rack_name nvarchar(50),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
 begin try
 begin transaction
  update tbl_rack set rack_name=@rack_name,godown_id=@godown_id,modified_by=@modified_by,modified_date=GETDATE()
     where company_id=@company_id and rack_id=@rack_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateSale]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_UpdateSale] 

@sale_id int,
@count int,
@company_id int,
@party_id int,
@invoice_no nvarchar(100),
@total_tax decimal(18,0),
@actual_amount decimal(18, 0),
@grand_total decimal(18, 0),
@discount decimal(18, 0),
@modified_by nvarchar(50),
@modifie_date nvarchar(50)


 as
 begin
 begin try
 begin transaction
 IF(@count!=0)
	begin
		 update tbl_sale set invoice_no=@invoice_no,total_tax=@total_tax,actual_amount=@actual_amount
		 ,total_discount=@discount,grand_total=@grand_total,modified_by=@modified_by,modified_date=@modifie_date
		 where sale_id=@sale_id and company_id=@company_id
    end
 else
    begin
      update tbl_sale set status=0 where sale_id=@sale_id and company_id=@company_id
     end
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_Updatesaledetail]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_Updatesaledetail] 
   
@saledetails_id int,
@product_id int,
@sale_id int,
@batch_id int,
@tax_amt decimal(18,0),
@dicount_amt decimal(18, 0),
@quantity decimal(18, 0),
@amount decimal(18, 0),
@price decimal(18, 0),
@modified_by nvarchar(50),
@modifie_date nvarchar(50)


 as
 begin
	 
	update      tbl_saledetails
	 set        batch_id=@batch_id,product_id=@product_id,tax_amt=@tax_amt,dicount_amt=@dicount_amt,
		        quantity=@quantity,amount=@amount,price=@price,modified_by=@modified_by,modified_date=@modifie_date
    where       sale_id=@sale_id and saledetails_id=@saledetails_id
		
  end
  

GO
/****** Object:  StoredProcedure [dbo].[sp_Updatestockquantity]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_Updatestockquantity] 

@product_id int,
@quantity int,
@company_id int


 as
 begin
 begin try
 begin transaction
 update tbl_stock set qty=qty-@quantity where company_id=@company_id and product_id=@product_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_updatesubscription]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_updatesubscription] 
  @company_id int,
  @user_id int,
  @plan_id int, 
  @transaction_id int,
  @paidamount decimal(18,2),
  @start_date smalldatetime
 as
 begin
	update tbl_subscription set status=0,modified_by=@user_id,modified_date=@start_date where user_id=@user_id and status=1
		declare @duration int, @end_date smalldatetime,@subscription_id int
			select @duration=duration from tbl_plan where plan_id=@plan_id
				set @end_date= DATEADD(month, @duration, @start_date) 
				 insert into tbl_subscription(plan_id,user_id,start_date,end_date,status,created_by,created_date)
				 values (@plan_id,@user_id,@start_date,@end_date,1,@user_id,@start_date)

					set @subscription_id=@@identity

						 insert into tbl_paidpayment(subscription_id,transaction_id,transaction_date,user_id,company_id,paidamount,status,created_by,created_date)
						 values(@subscription_id,@transaction_id,@start_date,@user_id,@company_id,@paidamount,1,@user_id,@start_date)
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTax]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateTax] 
 @company_id int,
  @branch_id int,
 @tax_id int,
 @tax_name nvarchar(50),
 @tax_percentage decimal(18, 2),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
 begin try
 begin transaction
  update tbl_tax set tax_name=@tax_name,tax_percentage=@tax_percentage,modified_by=@modified_by,modified_date=GETDATE() 
    where company_id=@company_id and tax_id=@tax_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUnit]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[sp_UpdateUnit] 
 @company_id int,
 @branch_id int,
 @unit_id int,
 @unit_name nvarchar(50),
 @modified_by nvarchar(50),
 @modified_date datetime
 as
 begin
 begin try
 begin transaction
  update tbl_unit set unit_name=@unit_name,modified_by=@modified_by,modified_date=GETDATE()   
  where company_id=@company_id and unit_id=@unit_id and branch_id=@branch_id
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUser]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[sp_UpdateUser]
@userbranch_id int,
@user_id int,
@user_name nvarchar(50),
@user_emailid nvarchar(50),
@user_mobileno nvarchar(50),
@role_id int,
@branch_id int,
@company_id int,
@status bit,
@modified_by nvarchar(50),
@modified_date smalldatetime,
@first_name nvarchar(50),
@last_name	nvarchar(50)


as
 Begin
    Begin Try
     Begin Transaction

update tbl_user set first_name=@first_name,last_name=@last_name, user_name=@user_name,user_Emai=@user_emailid,
user_mobieno=@user_mobileno,modified_by=@modified_by,
modified_date=@modified_date where user_id=@user_id

 update tbl_userbranch set role_id=@role_id,branch_id=@branch_id,modified_by=@modified_by,
modified_date=@modified_date
 where userbranch_id=@userbranch_id and user_id=@user_id 

     Commit Transaction
End Try
Begin Catch 
Rollback Transaction
insert into tbl_error_log(Error_Type,Error_Msg) values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
End Catch 
   End

GO
/****** Object:  StoredProcedure [dbo].[spAuthenticateUser]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[spAuthenticateUser] 
@user_name nvarchar(100),
@password nvarchar(500)
 as
 begin
 begin try
 begin transaction
 select user_id from tbl_User where user_name=@user_name and password=@password
  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[spAuthenticateUserRole]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[spAuthenticateUserRole] 
@user_id int
 as
 begin
 begin try
 begin transaction


 
 select tbl_userbranch.company_id,tbl_userbranch.branch_id,tbl_role.role_name,(u.first_name + ' ' + u.last_name) as [Name] from tbl_userbranch 
  join tbl_User u on u.user_id = tbl_userbranch.user_id
 inner join tbl_role on tbl_userbranch.role_id=tbl_role.role_id where tbl_userbranch.user_id=@user_id

  commit transaction
  end try
  begin catch
  Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
  end catch
  end

GO
/****** Object:  StoredProcedure [dbo].[spCheckDoubleInMasters]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spCheckDoubleInMasters]
@companyid int
,@tableName sysname
,@columnName nvarchar(100)
,@ValueToCheck nvarchar(100)
,@branch_id int
as
begin
SET NOCOUNT ON;
declare 
@DynamicSQL nvarchar(4000)

SET @DynamicSQL = 'SELECT * FROM ' + @tableName + 
		' where status = 1 and branch_id = '+ cast(@branch_id as varchar(10)) +' and company_id = '+ cast(@companyid as varchar(10))
		+ ' and ' + @columnName + '= ' + char(39) + @ValueToCheck + char(39)
				

EXECUTE sp_executesql @DynamicSQL
end

GO
/****** Object:  StoredProcedure [dbo].[SpGetExistsEmail]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[SpGetExistsEmail] 
 @email varchar(50)
 as
begin
begin try
begin transaction
	 Select @email from tbl_User where user_Emai = @email;
commit transaction
end try
begin catch
Rollback Transaction
insert into tbl_error_log(error_type,error_msg)
 values ('Sp_Error',ERROR_MESSAGE()+'ERROR_PROCEDURE()'+'ERROR_NUMBER()' )
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[SpGetExistsMobile]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Created By :- AL hamed Mohammed
--Created Date :- 22/03/2018
--Perpose :- For get exists Mobile
CREATE PROCEDURE [dbo].[SpGetExistsMobile] 
 @mobileno varchar(50)
 as
begin
	 Select  user_mobieno from tbl_User where user_mobieno = @mobileno;
end


GO
/****** Object:  Trigger [dbo].[trgPurcahseAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurcahseAfterInsert] 
   ON  [dbo].[tbl_purchase]
   AFTER  INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert
        dbo.tbl_purchaseHistory([purchase_id],[party_id],[financialyear_id],[po_no],[status],[created_by]
      ,[created_date],[modified_by],[modified_date],[Po_Date],[company_id],[branch_id],[InvoiceNumber],[PaymentMode_id],[Note])        
    SELECT 
        i.[purchase_id],i.[party_id],i.[financialyear_id],i.[po_no],i.[status],i.[created_by]
      ,i.[created_date],i.[modified_by],i.[modified_date],i.[Po_Date],i.[company_id],i.[branch_id],i.[InvoiceNumber],i.[PaymentMode_id],i.[Note]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgPurchaseAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchaseAfterUpdate]
   ON  [dbo].[tbl_purchase]
   FOR  UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_purchaseHistory([purchase_id],[party_id],[financialyear_id],[po_no],[status],[created_by]
      ,[created_date],[modified_by],[modified_date],[Po_Date],[company_id],[branch_id],[InvoiceNumber],[PaymentMode_id])        
    SELECT 
        i.[purchase_id],i.[party_id],i.[financialyear_id],i.[po_no],i.[status],i.[created_by]
      ,i.[created_date],i.[modified_by],i.[modified_date],i.[Po_Date],i.[company_id],i.[branch_id],i.[InvoiceNumber],i.[PaymentMode_id]
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgPurchaseDetailsAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <11/10/2018>
-- Description:	<Insert the record in Purchase Dr History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchaseDetailsAfterInsert] 
   ON  [dbo].[tbl_purchasedetails]
   AFTER  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert
        dbo.tbl_purchasedetailsHistory([purchasedetails_id],[purchase_id],[product_id],[batch_id],[tax_id],[unit_id],[tax_amt],[dicount_amt],[quantity]
      ,[amount],[created_by],[created_date],[status],[modified_by],[modified_date])        
    SELECT 
        i.[purchasedetails_id],i.[purchase_id],i.[product_id],i.[batch_id],i.[tax_id],i.[unit_id],i.[tax_amt],i.[dicount_amt],i.[quantity]
      ,i.[amount],i.[created_by],i.[created_date],i.[status],i.[modified_by],i.[modified_date]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgPurchaseDetailsAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <11/10/2018>
-- Description:	<Insert the record in Purchase Dr History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchaseDetailsAfterUpdate] 
   ON  [dbo].[tbl_purchasedetails]
   FOR UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert
        dbo.tbl_purchasedetailsHistory([purchasedetails_id],[purchase_id],[product_id],[batch_id],[tax_id],[unit_id],[tax_amt],[dicount_amt],[quantity]
      ,[amount],[created_by],[created_date],[status],[modified_by],[modified_date])        
    SELECT 
        i.[purchasedetails_id],i.[purchase_id],i.[product_id],i.[batch_id],i.[tax_id],i.[unit_id],i.[tax_amt],i.[dicount_amt],i.[quantity]
      ,i.[amount],i.[created_by],i.[created_date],i.[status],i.[modified_by],i.[modified_date]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgPurchasePaymentDetialsAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <27/11/2018>
-- Description:	<Insert the record in tbl_PurchasePaymentDetials History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchasePaymentDetialsAfterInsert] 
   ON  [dbo].[tbl_PurchasePaymentDetials]
   AFTER  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert
        dbo.tbl_PurchasePaymentDetialsHistory([PurchasePaymentId]
      ,[PurchaseId]
      ,[SubTotal]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[GrandTotal]
	  ,PaidAmnt
      ,[GivenAmnt]
      ,[BalanceAmnt]
      ,[FromTable],[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy])        
    SELECT 
         i.Id
      ,i.[PurchaseId]
      ,i.[SubTotal]
      ,i.[TaxAmount]
      ,i.[DiscountAmount]
      ,i.[GrandTotal]
	  ,i.PaidAmnt
      ,i.[GivenAmnt]
      ,i.[BalanceAmnt]
      ,i.[FromTable]
	  ,i.[CreatedDate]
      ,i.[CreatedBy]
      ,i.[ModifiedDate]
      ,i.[ModifiedBy]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgPurchasePaymentDetialsAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <27/11/2018>
-- Description:	<Insert the record in tbl_PurchasePaymentDetials History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchasePaymentDetialsAfterUpdate] 
   ON  [dbo].[tbl_PurchasePaymentDetials]
   AFTER  UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert
        dbo.tbl_PurchasePaymentDetialsHistory([PurchasePaymentId]
      ,[PurchaseId]
      ,[SubTotal]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[GrandTotal]
	  ,PaidAmnt
      ,[GivenAmnt]
      ,[BalanceAmnt]
      ,[FromTable],[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy])        
    SELECT 
         i.Id
      ,i.[PurchaseId]
      ,i.[SubTotal]
      ,i.[TaxAmount]
      ,i.[DiscountAmount]
      ,i.[GrandTotal]
	  ,i.PaidAmnt
      ,i.[GivenAmnt]
      ,i.[BalanceAmnt]
      ,i.[FromTable]
	  ,i.[CreatedDate]
      ,i.[CreatedBy]
      ,i.[ModifiedDate]
      ,i.[ModifiedBy]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgPurchaseReturnAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase return History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchaseReturnAfterInsert]
   ON  [dbo].[tbl_purchasereturn]
   FOR  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_purchasereturnHistory([purchasereturn_id],[company_id],[branch_id],[purchase_id],[financialyear_id],[status],[created_by],[created_date],[modified_by]
      ,[modified_date]
      ,[party_id]
      ,[InvoiceNumber]
      ,[paymentmode_id]      )        
    SELECT 
       i.[purchasereturn_id],i.[company_id],i.[branch_id],i.[purchase_id],i.[financialyear_id],i.[status],i.[created_by],i.[created_date],i.[modified_by]
      ,i.[modified_date]
      ,i.[party_id]
      ,i.[InvoiceNumber]
      ,i.[paymentmode_id]
     
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgPurchaseReturnAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase return History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchaseReturnAfterUpdate]
   ON  [dbo].[tbl_purchasereturn]
   FOR  UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_purchasereturnHistory([purchasereturn_id],[company_id],[branch_id],[purchase_id],[financialyear_id],[status],[created_by],[created_date],[modified_by]
      ,[modified_date]
      ,[party_id]
      ,[InvoiceNumber]
      ,[paymentmode_id]
    )        
    SELECT 
       i.[purchasereturn_id],i.[company_id],i.[branch_id],i.[purchase_id],i.[financialyear_id],i.[status],i.[created_by],i.[created_date],i.[modified_by]
      ,i.[modified_date]
      ,i.[party_id]
      ,i.[InvoiceNumber]
      ,i.[paymentmode_id]
     
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgPurchaseReturnDetailsAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <11/10/2018>
-- Description:	<Insert the record in Purchase return details  History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchaseReturnDetailsAfterInsert] 
   ON  [dbo].[tbl_purchasereturndetails]
   AFTER  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert
        dbo.tbl_purchasereturndetailsHistory([purchasereturndetails_id]
      ,[batch_id]
      ,[product_id]
      ,[unit_id]
      
      ,[tax_amt]
      ,[quantity]
      ,[amount]
      ,[status]
      ,[created_by]
      ,[created_date]
      ,[modified_by]
      ,[modified_date]
      ,[purchasereturn_id]
      ,[discount_amnt]
	  ,[Purchase_taxGroupId])        
    SELECT 
        i.[purchasereturndetails_id]
      ,i.[batch_id]
      ,i.[product_id]
      ,i.[unit_id]
      
      ,i.[tax_amt]
      ,i.[quantity]
      ,i.[amount]
      ,i.[status]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[modified_by]
      ,i.[modified_date]
      ,i.[purchasereturn_id]
      ,i.[discount_amnt]
	  ,i.[Purchase_taxGroupId]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgPurchaseReturnDetailsAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <11/10/2018>
-- Description:	<Insert the record in Purchase return details  History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgPurchaseReturnDetailsAfterUpdate] 
   ON  [dbo].[tbl_purchasereturndetails]
   For Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert
        dbo.tbl_purchasereturndetailsHistory([purchasereturndetails_id]
      ,[batch_id]
      ,[product_id]
      ,[unit_id]
      ,[tax_id]
      ,[tax_amt]
      ,[quantity]
      ,[amount]
      ,[status]
      ,[created_by]
      ,[created_date]
      ,[modified_by]
      ,[modified_date]
      ,[purchasereturn_id]
      ,[discount_amnt])        
    SELECT 
        i.[purchasereturndetails_id]
      ,i.[batch_id]
      ,i.[product_id]
      ,i.[unit_id]
      ,i.[tax_id]
      ,i.[tax_amt]
      ,i.[quantity]
      ,i.[amount]
      ,i.[status]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[modified_by]
      ,i.[modified_date]
      ,i.[purchasereturn_id]
      ,i.[discount_amnt]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgSaleAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSaleAfterInsert]
   ON  [dbo].[tbl_sale]
   FOR  INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_saleHistory(
      [sale_id]
      ,[party_id]
      ,[financialyear_id]      
      ,[status]
      ,[created_by]
      ,[created_date]
      ,[modified_by]
      ,[modified_date]
      ,[company_id]
      ,[branch_id]
      ,[InvoiceNumber]
      ,[paymentmode_id]
	  ,[Note])        
    SELECT 
      
      i.[sale_id]
      ,i.[party_id]
      ,i.[financialyear_id]
     
      ,i.[status]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[modified_by]
      ,i.[modified_date]
      ,i.[company_id]
      ,i.[branch_id]
      ,i.[InvoiceNumber]
      ,i.[paymentmode_id]
      ,i.[Note]
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgSaleAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSaleAfterUpdate]
   ON  [dbo].[tbl_sale]
   FOR  UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_saleHistory(
      [sale_id]
      ,[party_id]
      ,[financialyear_id]      
      ,[status]
      ,[created_by]
      ,[created_date]
      ,[modified_by]
      ,[modified_date]
      ,[company_id]
      ,[branch_id]
      ,[InvoiceNumber]
      ,[paymentmode_id]    )        
    SELECT 
      
      i.[sale_id]
      ,i.[party_id]
      ,i.[financialyear_id]      
      ,i.[status]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[modified_by]
      ,i.[modified_date]
      ,i.[company_id]
      ,i.[branch_id]
      ,i.[InvoiceNumber]
      ,i.[paymentmode_id]
     
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgSaleDetailsAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSaleDetailsAfterInsert]
   ON  [dbo].[tbl_saledetails]
   FOR  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_saledetailsHistory(
     [saledetails_id]
      ,[sale_id]
      ,[product_id]
      ,[batch_id]
      ,[tax_id]
      ,[unit_id]
      ,[tax_amt]
      ,[dicount_amt]
      ,[quantity]
      ,[amount]
      ,[created_by]
      ,[created_date]
      ,[status]
      ,[modified_by]
      ,[modified_date])        
    SELECT 
      
     i.[saledetails_id]
      ,i.[sale_id]
      ,i.[product_id]
      ,i.[batch_id]
      ,i.[tax_id]
      ,i.[unit_id]
      ,i.[tax_amt]
      ,i.[dicount_amt]
      ,i.[quantity]
      ,i.[amount]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[status]
      ,i.[modified_by]
      ,i.[modified_date]
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgSaleDetailsAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSaleDetailsAfterUpdate]
   ON  [dbo].[tbl_saledetails]
   FOR  UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_saledetailsHistory(
     [saledetails_id]
      ,[sale_id]
      ,[product_id]
      ,[batch_id]
      ,[tax_id]
      ,[unit_id]
      ,[tax_amt]
      ,[dicount_amt]
      ,[quantity]
      ,[amount]
      ,[created_by]
      ,[created_date]
      ,[status]
      ,[modified_by]
      ,[modified_date])        
    SELECT 
      
     i.[saledetails_id]
      ,i.[sale_id]
      ,i.[product_id]
      ,i.[batch_id]
      ,i.[tax_id]
      ,i.[unit_id]
      ,i.[tax_amt]
      ,i.[dicount_amt]
      ,i.[quantity]
      ,i.[amount]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[status]
      ,i.[modified_by]
      ,i.[modified_date]
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgSalePaymentDetailsAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <27/11/2018>
-- Description:	<Insert the record in tbl_SalePaymentDetails History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSalePaymentDetailsAfterInsert] 
   ON  [dbo].[tbl_SalePaymentDetails]
   AFTER  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert
        dbo.tbl_SalePaymentDetailsHistory([SalePaymentDetailsId]
      ,[SaleId]
      ,[SubTotal]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[GrandTotal]
	  ,PaidAmnt
      ,[GivenAmnt]
      ,[BalanceAmnt]
      ,[FromTable]
	  ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy])        
    SELECT 
         i.Id
      ,i.SaleId
      ,i.[SubTotal]
      ,i.[TaxAmount]
      ,i.[DiscountAmount]
      ,i.[GrandTotal]
	  ,i.PaidAmnt
      ,i.[GivenAmnt]
      ,i.[BalanceAmnt]
      ,i.[FromTable]
	  ,i.[CreatedDate]
      ,i.[CreatedBy]
      ,i.[ModifiedDate]
      ,i.[ModifiedBy]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgSalePaymentDetailsAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <27/11/2018>
-- Description:	<Insert the record in tbl_SalePaymentDetails History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSalePaymentDetailsAfterUpdate] 
   ON  [dbo].[tbl_SalePaymentDetails]
   AFTER  UPdate
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

      insert
        dbo.tbl_SalePaymentDetailsHistory([SalePaymentDetailsId]
      ,[SaleId]
      ,[SubTotal]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[GrandTotal]
	  ,PaidAmnt
      ,[GivenAmnt]
      ,[BalanceAmnt]
      ,[FromTable]
	  ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy])        
    SELECT 
         i.Id
      ,i.SaleId
      ,i.[SubTotal]
      ,i.[TaxAmount]
      ,i.[DiscountAmount]
      ,i.[GrandTotal]
	  ,i.PaidAmnt
      ,i.[GivenAmnt]
      ,i.[BalanceAmnt]
      ,i.[FromTable]
	  ,i.[CreatedDate]
      ,i.[CreatedBy]
      ,i.[ModifiedDate]
      ,i.[ModifiedBy]
    FROM 
        inserted i

END

GO
/****** Object:  Trigger [dbo].[trgSaleReturnAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSaleReturnAfterInsert]
   ON  [dbo].[tbl_salereturn]
   FOR  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_salereturnHistory(
     [salereturn_id]
      ,[company_id]
      ,[branch_id]
      ,[sale_id]
      ,[financialyear_id]     
      ,[status]
      ,[created_by]
      ,[created_date]
      ,[modified_by]
      ,[modified_date]
      ,[paymentmode_id]    
      ,[InvoiceNumber]      
      ,[party_id])        
    SELECT 
      
    i.[salereturn_id]
      ,i.[company_id]
      ,i.[branch_id]
      ,i.[sale_id]
      ,i.[financialyear_id]     
      ,i.[status]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[modified_by]
      ,i.[modified_date]
      ,i.[paymentmode_id]     
      ,i.[InvoiceNumber]      
      ,i.[party_id]
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgSaleReturnAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSaleReturnAfterUpdate]
   ON  [dbo].[tbl_salereturn]
   FOR  UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_salereturnHistory(
     [salereturn_id]
      ,[company_id]
      ,[branch_id]
      ,[sale_id]
      ,[financialyear_id]
           ,[status]
      ,[created_by]
      ,[created_date]
      ,[modified_by]
      ,[modified_date]
      ,[paymentmode_id]      
      ,[InvoiceNumber]     
      ,[party_id])        
    SELECT 
      
    i.[salereturn_id]
      ,i.[company_id]
      ,i.[branch_id]
      ,i.[sale_id]
      ,i.[financialyear_id]     
      ,i.[status]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[modified_by]
      ,i.[modified_date]
      ,i.[paymentmode_id]     
      ,i.[InvoiceNumber]      
      ,i.[party_id]
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgSaleReturnDetailsAfterInsert]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSaleReturnDetailsAfterInsert]
   ON  [dbo].[tbl_salereturndetails]
   FOR  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    insert
        dbo.tbl_salereturndetailsHistory(
    [salesreturndetails_id]
      ,[batch_id]
      ,[product_id]
      ,[unit_id]
      ,[tax_amt]
      ,[quantity]
      ,[amount]
      ,[status]
      ,[created_by]
      ,[created_date]
      ,[modified_by]
      ,[modified_date]
      ,[dicount_amt]
      ,[salereturn_id]
	  ,[Sales_taxGroupId])        
    SELECT 
      
   i.[salesreturndetails_id]
      ,i.[batch_id]
      ,i.[product_id]
      ,i.[unit_id]
      ,i.[tax_amt]
      ,i.[quantity]
      ,i.[amount]
      ,i.[status]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[modified_by]
      ,i.[modified_date]
      ,i.[dicount_amt]
      ,i.[salereturn_id]
	  ,i.[Sales_taxGroupId]
    FROM 
        inserted i


END

GO
/****** Object:  Trigger [dbo].[trgSaleReturnDetailsAfterUpdate]    Script Date: 3/14/2019 3:41:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shakeeb Khan>
-- Create date: <10/10/2018>
-- Description:	<Insert the record in Purchase History Table>
-- =============================================
CREATE TRIGGER [dbo].[trgSaleReturnDetailsAfterUpdate]
   ON  [dbo].[tbl_salereturndetails]
   FOR  UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

   insert
        dbo.tbl_salereturndetailsHistory(
    [salesreturndetails_id]
      ,[batch_id]
      ,[product_id]
      ,[unit_id]
      ,[tax_amt]
      ,[quantity]
      ,[amount]
      ,[status]
      ,[created_by]
      ,[created_date]
      ,[modified_by]
      ,[modified_date]
      ,[dicount_amt]
      ,[salereturn_id]
	  ,[Sales_taxGroupId])        
    SELECT 
      
   i.[salesreturndetails_id]
      ,i.[batch_id]
      ,i.[product_id]
      ,i.[unit_id]
      ,i.[tax_amt]
      ,i.[quantity]
      ,i.[amount]
      ,i.[status]
      ,i.[created_by]
      ,i.[created_date]
      ,i.[modified_by]
      ,i.[modified_date]
      ,i.[dicount_amt]
      ,i.[salereturn_id]
	  ,i.[Sales_taxGroupId]
    FROM 
        inserted i



END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[35] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl_ActualPurchaseTaxAndPrice"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 137
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_purchase"
            Begin Extent = 
               Top = 6
               Left = 256
               Bottom = 311
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tbl_purchasedetails"
            Begin Extent = 
               Top = 6
               Left = 476
               Bottom = 311
               Right = 662
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "tbl_company"
            Begin Extent = 
               Top = 6
               Left = 700
               Bottom = 137
               Right = 884
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_unit"
            Begin Extent = 
               Top = 6
               Left = 922
               Bottom = 137
               Right = 1092
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_tax"
            Begin Extent = 
               Top = 281
               Left = 83
               Bottom = 412
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 269
               Right = 416
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_PurchaseDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_PurchasePaymentDetials"
            Begin Extent = 
               Top = 166
               Left = 737
               Bottom = 329
               Right = 943
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_PurchaseDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_PurchaseDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl_ActualSalesTaxAndPrice"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 137
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_sale"
            Begin Extent = 
               Top = 6
               Left = 256
               Bottom = 137
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_saledetails"
            Begin Extent = 
               Top = 6
               Left = 476
               Bottom = 137
               Right = 646
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_unit"
            Begin Extent = 
               Top = 6
               Left = 684
               Bottom = 137
               Right = 854
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_tax"
            Begin Extent = 
               Top = 6
               Left = 892
               Bottom = 137
               Right = 1062
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_company"
            Begin Extent = 
               Top = 6
               Left = 1100
               Bottom = 137
               Right = 1284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 269
               Right = 208
            End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SaleDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_financialyear"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 269
               Right = 417
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_SalePaymentDetails"
            Begin Extent = 
               Top = 140
               Left = 465
               Bottom = 303
               Right = 671
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SaleDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SaleDetails'
GO
USE [master]
GO
ALTER DATABASE [IMS1.0] SET  READ_WRITE 
GO
