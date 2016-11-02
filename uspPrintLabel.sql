SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Use [WIP]
go
-- =============================================
-- Author:		Alan Cannon
-- Create date: 2012-10-17
-- Description:	Process to Print Label data to a Specific Printer at Place Contents in that 
-- Printers Print Spool
-- =============================================
ALTER PROCEDURE uspPrintLabel
	-- Add the parameters for the stored procedure here
	--Inputs
	@ulSalesOrder bigint,@ulFullPid bigint,@stLabelTarget nvarchar(10),@eType smallint
AS
BEGIN
	DECLARE @PrinterName nvarchar(50), @strTemp nvarchar(250), @strLabelString nvarchar(max),@strResultText nvarchar(max)
	DECLARE @eResult int,@MSGIDPRE int,@MSGID int,@SEVER int,@intResultCode int,@intStep int,@hDoc bigint
	DECLARE @Left int,@Top int,@Right int,@Bottom int
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--SET locals
	SET @strLabelString = ''
	SET @PrinterName = ''
	SET @MSGIDPRE = 511
	SET @hDoc = 0
	SET @Left = 25
	SET @Top = 25
	SET @Right = 875
	SET @Bottom = 275
	SET @intStep = 0
	
	BEGIN TRY
		EXECUTE @eResult = [WIP].[dbo].[GetLabelString] @ulSalesOrder,@ulFullPID,@stLabelTarget,@eType, @strLabelString OUTPUT
	if @eResult <> 1
		begin
			SET @strTemp =(Select [Text] From sys.messages Where Left(message_id,3)=@MSGIDPRE and right(Message_ID,2) = @eResult and [language_id]=1033 and [MESSAGE_ID]> 50000)
			SET @MSGID = (Select [MESSAGE_ID] From sys.messages Where Left(message_id,3)=@MSGIDPRE and right(Message_ID,2) = @eResult and [language_id]=1033 and [MESSAGE_ID]> 50000)
			SET @SEVER = (Select [SEVERITY] From sys.messages Where Left(message_id,3)=@MSGIDPRE and right(Message_ID,2) = @eResult and [language_id]=1033 and [MESSAGE_ID]> 50000)
			raiserror(@MSGID,@SEVER,1,@strTemp)
		end	
	if @eresult = 1
		BEGIN
			SET @intStep = 1
			--Find the Printer Name to Call and Execute the Print Data to Spool Commands for the Active Printer [STATUS]
			SET @PrinterName=(Select TOP 1 [Printer_Name] from [DBO].[Printer_DATA] Where [TYPE]= 1 and [STATUS] = 1)
			BEGIN 
				EXECUTE [WIP].[dbo].[SpoolDocToPrinter] @PrinterName ,@hDoc OUTPUT
			-- The @hDoc is a Place Holder in the Print Object referencing the Create Handle to the Printer Returns 0 if no connection possible, Returns a GUID for the Place holder
			IF @hDoc = 0 
				SET @intStep = 99
				SET @strTemp = (Select [Text] From sys.messages Where [message_id]=51002 and [language_id]=1033 and [MESSAGE_ID]> 50000)
				SET @strTemp = @strTemp +' uspPrintLabel: Printer Name Not Found or Printer Not Connected'
				raiserror(51002,16,1,@strTemp)

			IF @hDoc <> 0 
				EXECUTE [WIP].[dbo].[DrawTextInRectAsPage] @hDoc,@strLabelString,@Left,@Top,@Right,@Bottom
				EXECUTE [WIP].[dbo].[PrintDoc] @hDoc
				SET @intStep = 3
			END 					
		END
	END TRY
		begin catch
		-- Set return values
		select @intResultCode=error_number(), @strResultText=error_message()
		-- Prior to logging message we need to roll back any started 
		-- transactions
		if (xact_state()) <> 0
			rollback transaction

		-- Insert message into the message log
	    insert into tblMessageLog
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
GO
