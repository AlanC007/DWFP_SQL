USE [DBNAME]
GO
/****** Object:  StoredProcedure [dbo].[uspCreateBatch]    Script Date: 2/11/2016 10:35:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Alan Cannon
-- Create date: 10-DEC-2007
-- Description:	Template USP
-- =============================================
ALTER PROCEDURE [dbo].[uspTemplate]
	-- Add the parameters for the stored procedure here
	-- Inputs
		@Input1 int,
	
	--Outputs
		@intResultCode int output,			-- Result Code Standard Return Value 0 = fail, 1=pass
		@strResultText nvarchar(255) output	-- Text to return if we fail the call
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Set @intResultCode = 0
	Set @strResultText = ''

    -- Insert statements for procedure here
	begin try
		--Check the Entry before proceeding
			if isnull(@Input1,0)=0 raiserror(51001,16,1,'Input1')	-- "Parameter %s not supplied."

		-- Your Code Here
	end try

	begin catch
		-- Set return values
		select @intResultCode=error_number(), @strResultText=error_message()

		-- Prior to logging message we need to roll back any started 
		-- transactions
		if (xact_state()) <> 0
			rollback transaction

		-- Insert message into the error log
	    insert into tblErrorLog
			(MsgDate, 
			 MsgNumber, 
			 MsgText, 
			 MsgSeverity, 
			 MsgProcedure)
			values
			(getdate(),
			 error_number(),
			 error_message(),
			 error_severity(),
			 error_procedure())
	end catch


END



