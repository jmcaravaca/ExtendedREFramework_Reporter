/**** Ejemplo de tabla de datos. Obligatorio siempre id y Reference ****/
/****** Object:  Table [dbo].[JCV_Main]    Script Date: 29/02/2024 9:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JCV_Main](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Reference] [varchar](100) NULL,
	[Data1] [int] NULL,
	[Data2] [varchar](100) NULL,
	[Data3] [datetime] NULL,
 CONSTRAINT [PK_JCV_Main] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ItemProgress] ADD  CONSTRAINT [DF__JCV_TestL__Inser__388F4914]  DEFAULT (getdate()) FOR [InsertTime]
GO
ALTER TABLE [dbo].[JCV_Main] ADD  DEFAULT (NULL) FOR [Reference]
GO
ALTER TABLE [dbo].[JCV_Main] ADD  DEFAULT (NULL) FOR [Data2]
GO