Execute sp_addmessage num,severity,text,lang

Execute sp_addmessage 51001,16,'Parameter %s not supplied.',English
GO
Execute sp_addmessage 51002,16,'Parameter %s is invalid.' ,English
GO
Execute sp_addmessage 51003,16,'Record not found for %s.' ,English
GO
Execute sp_addmessage 51004,16,'%s',English
GO
Execute sp_addmessage 51005,16,'Align procedure %s returned %s',English
GO
Execute sp_addmessage 51006,16,'Multiple records found for %s.',English
GO
Execute sp_addmessage 51007,16,'SalesOrder %d / FullAID %s already assigned to PalletID %d',English
GO
Execute sp_addmessage 51100,16,'eResultPkg-UNKNOWN',English
GO
Execute sp_addmessage 51101,16,'eResultPkg-OK',English
GO
Execute sp_addmessage 51102,16,'eResultPkg-GenericErr',English
GO
Execute sp_addmessage 51104,16,'eResultPkg-NoCommunication',English
GO
Execute sp_addmessage 51105,16,'eResultPkg-DbNotOpen',English
GO
Execute sp_addmessage 51106,16,'eResultPkg-CaseNotFound',English
GO
Execute sp_addmessage 51107,16,'eResultPkg-RecordNotFound',English
GO
Execute sp_addmessage 51108,16,'eResultPkg-DataErr',English
GO
Execute sp_addmessage 51109,16,'eResultPkg-TooManyPIDFound',English
GO
Execute sp_addmessage 51110,16,'eResultPkg-MultiSalesOrderFound',English
GO
Execute sp_addmessage 51111,16,'eResultPkg-NoLabelIdFound',English
GO
Execute sp_addmessage 51112,16,'eResultPkg-TooManyLabelsFound',English
GO
Execute sp_addmessage 51113,16,'eResultPkg-SequenceOutOfOrder',English
GO
Execute sp_addmessage 51114,16,'eResultPkg-DataMismatch',English
GO
Execute sp_addmessage 51115,16,'eResultPkg-Exception',English
GO
Execute sp_addmessage 51116,16,'eResultPkg-SalesOrderNotFound',English
GO
Execute sp_addmessage 51117,16,'eResultPkg-FileNotFound',English
GO
Execute sp_addmessage 51118,16,'eResultPkg-BoxLabelNotRequired',English
GO
Execute sp_addmessage 51119,16,'eResultPkg-LiteratureNotRequired',English
GO
Execute sp_addmessage 51120,16,'eResultPkg-RepeatedStages',English
GO
Execute sp_addmessage 51121,16,'eResultPkg-AlignerIdNotFound',English
GO
Execute sp_addmessage 51122,16,'eResultPkg-PatientIdNotFound',English
GO


Select * from sys.messages where Message_id > 5000
