/*** Migracion base, crear DB + tablas comunes de errores ***/

/*****Create DB***/

DECLARE @DatabaseName NVARCHAR(128) = N'ProcesosRPA_UiPath_PRE';

IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = @DatabaseName)
BEGIN
    CREATE DATABASE [ProcesosRPA_UiPath_PRE];
END;


USE [ProcesosRPA_UiPath_PRE]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAplicacion]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetAplicacion](@cod VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @outval VARCHAR(50)
	SELECT @outval = Nombre FROM CodErrores_NombreAplicaciones WHERE CodErrores_NombreAplicaciones.Codigo = @cod
	RETURN @outval
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetProceso]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetProceso](@cod VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @outval VARCHAR(50)
	SELECT @outval = Nombre FROM CodErrores_NombreProcesos WHERE CodErrores_NombreProcesos.Codigo = @cod
	RETURN @outval
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetTipo]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetTipo](@cod VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @outval VARCHAR(50)
	SELECT @outval = Nombre FROM CodErrores_NombreTipos WHERE CodErrores_NombreTipos.Codigo = @cod
	RETURN @outval
END
GO
/****** Object:  Table [dbo].[CodErrores]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CodErrores](
	[Tipo]  AS ([dbo].[GetTipo](substring([Codigo],(1),(1)))),
	[CodTipo]  AS (substring([Codigo],(1),(1))),
	[Aplicacion]  AS ([dbo].[GetAplicacion](substring([Codigo],(3),(4)))),
	[CodAplicacion]  AS (substring([Codigo],(3),(4))),
	[Proceso]  AS ([dbo].[GetProceso](substring([Codigo],(8),(4)))),
	[CodProceso]  AS (substring([Codigo],(8),(4))),
	[CodContador]  AS (substring([Codigo],(13),(4))),
	[Descripcion] [varchar](150) NULL,
	[Codigo] [varchar](20) NOT NULL,
	[DescripcionPT] [varchar](150) NULL,
	[DescripcionEN] [varchar](150) NULL,
	[DescripcionES]  AS ([Descripcion]),
 CONSTRAINT [PK__CodError__06370DADD195FE85] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CodErrores_NombreAplicaciones]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CodErrores_NombreAplicaciones](
	[Codigo] [nchar](4) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
 CONSTRAINT [PK_CodErrores_NombreAplicaciones] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CodErrores_NombreProcesos]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CodErrores_NombreProcesos](
	[Codigo] [nchar](4) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
 CONSTRAINT [PK_CodErrores_NombreProcesos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CodErrores_NombreTipos]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CodErrores_NombreTipos](
	[Codigo] [varchar](2) NOT NULL,
	[Nombre] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemProgress]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemProgress](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[InsertTime] [datetime] NULL,
	[LogProgress] [varchar](max) NULL,
	[TableName] [varchar](50) NULL,
	[ProcessName] [varchar](100) NULL,
 CONSTRAINT [PK__JCV_Test__3213E83FD3ED094E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[RPAInsertItemProgress]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RPAInsertItemProgress]
	@in_ItemDataTable VARCHAR(50),
	@in_ProcessName VARCHAR(50),
	@in_Progress VARCHAR(MAX),
	@in_ItemId INT
AS
BEGIN
	SET NOCOUNT ON;
	IF(@in_ItemId = 0 OR @in_ItemId IS NULL)
	BEGIN
		RAISERROR( 'Cannot have empty arguments', 16, 1);
		RETURN;
	END
	BEGIN
	INSERT Into dbo.ItemProgress 
	(ItemId, LogProgress, TableName, ProcessName)
	VALUES (@in_ItemId, @in_Progress, @in_ItemDataTable, @in_ProcessName)
	END;
END;
GO
/****** Object:  StoredProcedure [dbo].[RPASelectItemProgress]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RPASelectItemProgress]
	@in_Id INT,
	@in_ItemDataTable VARCHAR(50),
	@out_Progress NVARCHAR(MAX) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	IF(@in_Id = 0 OR @in_Id IS NULL)
	BEGIN
		RAISERROR( 'Cannot have empty arguments', 16, 1);
		RETURN;
	END
	BEGIN
		SELECT @out_Progress = STRING_AGG(CONCAT(iprog.LogProgress, ' - ', FORMAT(iprog.InsertTime, 'yyyy-MM-dd HH:mm:ss')), CHAR(13) + CHAR(10))
		FROM dbo.ItemProgress iprog
		WHERE 1=1
		AND iprog.ItemId = @in_Id
		AND iprog.TableName = @in_ItemDataTable
		GROUP BY ItemId;
	END;
END;
GO
