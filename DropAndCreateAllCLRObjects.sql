
use WIP
GO
sp_configure 'Show Advanced Options',1
go
reconfigure
go
sp_configure 'CLR enabled',1
go
reconfigure
go
sp_configure 'ad hoc distributed queries',1
go

alter database WIP set Trustworthy on
go
reconfigure
go

/****** Object:  StoredProcedure [dbo].[CheckForRepeatedStages]    Script Date: 02/08/2013 11:28:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CheckForRepeatedStages]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CheckForRepeatedStages]
GO

/****** Object:  StoredProcedure [dbo].[GetFullPIDFromSO]    Script Date: 02/08/2013 11:28:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetFullPIDFromSO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetFullPIDFromSO]
GO

/****** Object:  StoredProcedure [dbo].[GetSalesOrderBy6DigPID]    Script Date: 02/08/2013 11:28:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSalesOrderBy6DigPID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSalesOrderBy6DigPID]
GO

/****** Object:  StoredProcedure [dbo].[IdentifySOandAID]    Script Date: 02/08/2013 11:28:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IdentifySOandAID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[IdentifySOandAID]
GO
/****** Object:  StoredProcedure [dbo].[ProcessNewSO]    Script Date: 02/08/2013 11:29:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProcessNewSO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ProcessNewSO]
GO
/****** Object:  StoredProcedure [dbo].[UpdateLabelStatus]    Script Date: 02/08/2013 11:30:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateLabelStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateLabelStatus]
GO
/****** Object:  StoredProcedure [dbo].[UpdatePuckRFID]    Script Date: 02/08/2013 11:30:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdatePuckRFID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdatePuckRFID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLabelString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetLabelString]
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderDataFromPkgDB]    Script Date: 02/08/2013 21:30:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrderDataFromPkgDB]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetOrderDataFromPkgDB]
GO
/****** Object:  UserDefinedFunction [dbo].[GetProductListForSO]    Script Date: 02/08/2013 21:31:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductListForSO]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetProductListForSO]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSOListForFullPID]    Script Date: 02/08/2013 21:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSOListForFullPID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetSOListForFullPID]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSOandAIDListForAID]    Script Date: 02/08/2013 21:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSOandAIDListForAID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetSOandAIDListForAID]
GO
/****** Object:  UserDefinedFunction [dbo].[GetBoxDataFromPkgDB]    Script Date: 02/08/2013 21:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBoxDataFromPkgDB]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetBoxDataFromPkgDB]
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderDataFromPkgDB]    Script Date: 02/08/2013 21:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrderDataFromPkgDB]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetOrderDataFromPkgDB]
GO
/****** Object:  UserDefinedFunction [dbo].[UpdateOrderStatus]    Script Date: 02/08/2013 21:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateOrderStatus]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[UpdateOrderStatus]
GO
/****** Object:  UserDefinedFunction [dbo].[GetLabelFileFullPath]    Script Date: 02/08/2013 21:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLabelFileFullPath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetLabelFileFullPath]
GO
/****** Object:  UserDefinedFunction [dbo].[GetLitFileFullPath]    Script Date: 02/08/2013 21:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLitFileFullPath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetLitFileFullPath]
GO
/****** Object:  UserDefinedFunction [dbo].[GetBarcodeText]    Script Date: 02/08/2013 21:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBarcodeText]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetBarcodeText]
GO



/* DLL Importing Below*/
/****** Object:  SqlAssembly [AlignPkgLibraryStatic]    Script Date: 02/08/2013 21:27:04 ******/
IF  EXISTS (SELECT * FROM sys.assemblies asms WHERE asms.name = N'AlignPkgLibraryStatic' and is_user_defined = 1)
DROP ASSEMBLY [AlignPkgLibraryStatic]

GO
/****** Object:  SqlAssembly [AlignPkgLibrary]    Script Date: 02/08/2013 21:26:32 ******/
IF  EXISTS (SELECT * FROM sys.assemblies asms WHERE asms.name = N'AlignPkgLibrary' and is_user_defined = 1)
DROP ASSEMBLY [AlignPkgLibrary]
GO

/****** Object:  SqlAssembly [BagLabelLibrary]    Script Date: 02/08/2013 21:27:27 ******/
IF  EXISTS (SELECT * FROM sys.assemblies asms WHERE asms.name = N'BagLabelLibrary' and is_user_defined = 1)
DROP ASSEMBLY [BagLabelLibrary]

GO
/****** Object:  SqlAssembly [BoxLabelLibrary]    Script Date: 02/08/2013 21:27:48 ******/
IF  EXISTS (SELECT * FROM sys.assemblies asms WHERE asms.name = N'BoxLabelLibrary' and is_user_defined = 1)
DROP ASSEMBLY [BoxLabelLibrary]

GO
Declare @DLLPATH Nvarchar(100)
SET @DLLPATH = 'C:\FROM AA_DEV02\SYSDLLS'
/****** Object:  SqlAssembly [AlignPkgLibrary]    Script Date: 02/08/2013 11:40:14 ******/
CREATE ASSEMBLY [AlignPkgLibrary]
AUTHORIZATION [dbo]
FROM @DLLPATH+'AlignPkgLibrary.dll'
WITH PERMISSION_SET = UNSAFE

/****** Object:  SqlAssembly [AlignPkgLibraryStatic]    Script Date: 02/08/2013 11:40:24 ******/
CREATE ASSEMBLY [AlignPkgLibraryStatic]
AUTHORIZATION [dbo]
FROM @DLLPATH+'AlignPkgLibraryStatic.dll'
WITH PERMISSION_SET = UNSAFE

--/****** Object:  SqlAssembly [BagLabelLibrary]    Script Date: 02/08/2013 11:40:29 ******/
--CREATE ASSEMBLY [BagLabelLibrary]
--AUTHORIZATION [dbo]
--FROM @DLLPATH+'BagLabelLibrary.dll'
--WITH PERMISSION_SET = UNSAFE

--/****** Object:  SqlAssembly [BoxLabelLibrary]    Script Date: 02/08/2013 11:40:33 ******/
--CREATE ASSEMBLY [BoxLabelLibrary]
--AUTHORIZATION [dbo]
--FROM @DLLPATH+'BoxLabelLibrary.dll'
--WITH PERMISSION_SET = UNSAFE


GO
/* All SQL Procedures Below*/
/****** Object:  StoredProcedure [dbo].[CheckForRepeatedStages]    Script Date: 02/08/2013 11:28:18 ******/
CREATE PROCEDURE [dbo].[CheckForRepeatedStages]
	@ulSalesOrder [bigint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[CheckForRepeatedStages]
GO

/****** Object:  StoredProcedure [dbo].[GetFullPIDFromSO]    Script Date: 02/08/2013 11:28:27 ******/
CREATE PROCEDURE [dbo].[GetFullPIDFromSO]
	@ulSalesOrder [bigint],
	@ulFullPid [bigint] OUTPUT
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetFullPIDFromSO]
GO
/****** Object:  StoredProcedure [dbo].[GetSalesOrderBy6DigPID]    Script Date: 02/08/2013 11:28:41 ******/
CREATE PROCEDURE [dbo].[GetSalesOrderBy6DigPID]
	@ulPid6 [bigint],
	@ulSalesOrder [bigint] OUTPUT,
	@ulFullPID [bigint] OUTPUT
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetSalesOrderBy6DigPID]
GO
/****** Object:  StoredProcedure [dbo].[IdentifySOandAID]    Script Date: 02/08/2013 11:28:57 ******/
CREATE PROCEDURE [dbo].[IdentifySOandAID]
	@strPid [nvarchar](20),
	@strJaw [nvarchar](2),
	@strStage [nvarchar](5),
	@strType [nvarchar](10),
	@strFullId [nvarchar](20) OUTPUT,
	@ulSalesOrder [bigint] OUTPUT
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[IdentifySOandAID]
GO

/****** Object:  StoredProcedure [dbo].[ProcessNewSO]    Script Date: 02/08/2013 11:29:15 ******/
CREATE PROCEDURE [dbo].[ProcessNewSO]
	@ulSalesOrder [bigint],
	@ulFullPid [bigint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[ProcessNewSO]
GO

/****** Object:  StoredProcedure [dbo].[UpdatePuckRFID]    Script Date: 02/08/2013 11:30:42 ******/
CREATE PROCEDURE [dbo].[UpdatePuckRFID]
	@ulFullPID [bigint],
	@stRFID [nvarchar](20),
	@strProdID [nvarchar](20),
	@bytSeqNum [tinyint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[UpdatePuckRFID]
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 02/08/2013 11:30:42 ******/
CREATE PROCEDURE [dbo].[UpdateOrderStatus]
	@ulSalesOrder [bigint],
	@eStatus [TinyInt]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[UpdateOrderStatus]
GO
/****** Object:  StoredProcedure [dbo].[GetLabelFileFullPath]    Script Date: 02/08/2013 11:30:42 ******/
CREATE PROCEDURE [dbo].[GetLabelFileFullPath]
	@ulSalesOrder [Bigint],
	@ulFullPID [bigint],
	@uiItemNo [tinyInt],
	@chAlignerType [NvarChar](2),
	@eLabelType [tinyint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetLabelFileFullPath]
GO
/****** Object:  StoredProcedure [dbo].[GetLitFileFullPath]    Script Date: 02/08/2013 11:30:42 ******/
CREATE PROCEDURE [dbo].[GetLitFileFullPath]
	@ulSalesOrder [Bigint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetLitFileFullPath]
GO
/****** Object:  StoredProcedure [dbo].[GetBarcodeText]    Script Date: 02/08/2013 11:30:42 ******/
CREATE PROCEDURE [dbo].[GetBarcodeText]
	@ulSalesOrder [Bigint],
	@ulPIDFULL [bigint],
	@uiStage [TinyInt],
	@chAlignerType [Char]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetBarcodeText]
GO





/* All SQL Functions Below*/
/****** Object:  UserDefinedFunction [dbo].[GetOrderDataFromPkgDB]    Script Date: 02/08/2013 11:45:39 ******/
CREATE FUNCTION [dbo].[GetOrderDataFromPkgDB](@ulSalesOrder [bigint], @ulFullPID [bigint], @bFullAID [bit])
RETURNS  TABLE (
	[BARCODE] [nvarchar](200) NULL,
	[PROD1] [nvarchar](20) NULL,
	[PROD2] [nvarchar](20) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetOrderDataFromPkgDB]
GO

/****** Object:  UserDefinedFunction [dbo].[GetProductListForSO]    Script Date: 02/08/2013 11:45:48 ******/
CREATE FUNCTION [dbo].[GetProductListForSO](@ulSalesOrder [bigint])
RETURNS  TABLE (
	[ProductID] [nvarchar](20) NULL,
	[SequenceNUM] [tinyint] NULL,
	[HASPARTNER] [bit] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetProductListForSO]
GO

/****** Object:  UserDefinedFunction [dbo].[GetSOListForFullPID]    Script Date: 02/08/2013 11:45:53 ******/
CREATE FUNCTION [dbo].[GetSOListForFullPID](@ulFullPID [bigint])
RETURNS  TABLE (
	[SALESORDERID] [nvarchar](160) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetSOListForFullPID]
GO

/****** Object:  UserDefinedFunction [dbo].[GetSOListForFullPID]    Script Date: 02/08/2013 11:45:53 ******/
CREATE FUNCTION [dbo].[GetSOandAIDListForAID](@ulFullPID Nvarchar(20), @intMaxRows [bigint])
RETURNS  TABLE (
	[SalesOrder] INT,
	[FullAID] [nvarchar](20) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetSOandAIDListForAID]
GO

/****** Object:  UserDefinedFunction [dbo].[GetSOListForFullPID]    Script Date: 02/08/2013 11:45:53 ******/
CREATE FUNCTION [dbo].[GetBoxDataFromPkgDB](@ulSalesOrder BIGINT,@ulFullPID BIGINT)
RETURNS  TABLE (
	[BoxId] BIGINT,
	[BagAmt] BIGINT,	
	[BagAmtFirst] BIGINT,
	[BagAmtSec] BIGINT	
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetBoxDataFromPkgDB]
GO
/****** Object:  UserDefinedFunction [dbo].[GetOrderDataFromPkgDB]    Script Date: 03/13/2013 18:02:50 ******/
CREATE FUNCTION [dbo].[GetOrderDataFromPkgDB](@ulSalesOrder bigint, @ulFullPID bigint, @bFullAID bit)
RETURNS  TABLE (
	[BoxNo] BIGINT,
	[BagNo] BIGINT,
	[PuckId1] Nvarchar(25),
	[Prod1] Nvarchar(25) NULL,
	[SeqNo1] BIGINT,
	[PuckId2] Nvarchar(25),
	[Prod2] Nvarchar(25) NULL,
	[SeqNo2] BIGINT,	
	[BarCode] Nvarchar(10) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [AlignPkgLibraryStatic].[AlignPkgLibraryStatic.AlignPkgLibraryStatic].[GetOrderDataFromPkgDB]
GO