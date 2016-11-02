select * from sys.syslanguages
order by msglangid

Select * from sys.messages where message_id >50000
Execute sp_addmessage 51001,16,'Parámetro %s no suministrado...',Spanish

SET Language English
Begin Tran
	 RaiseError(51001,16,1, N'abcde')
Commit Tran
Begin Tran
SET Language Spanish
Declare @id int,@Severity int,@msg varchar(max),@vs nvarchar(2)
Set @vs = '%s'
Select @ID=Message_ID,@Severity=severity,@Msg=text from Sys.Messages where message_id = 51001 and language_id = 1033
Set @msg = (Select REPLACE(@msg,@vs,N'abcde'))
--Select @msg
--RAISERROR (@id, @Severity, -1,N'ABCD')

RAISERROR (@id,@Severity,-1,@msg)
SET Language English
Commit Tran