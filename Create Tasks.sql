USE [INJECTOR]
GO
/****** Object:  StoredProcedure [dbo].[uspStartTasks]    Script Date: 09/04/2012 13:48:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  procedure [dbo].[uspStartTasks]
AS
  DECLARE @JobID BINARY(16),
    @ReturnCode INT,
    @v_tStr    nvarchar(80),
    @v_jobnum  SMALLINT,
    @v_tnum    INT,
    @v_job_next_date  datetime
Begin
    set nocount on
    SET @ReturnCode = 0
    IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N'DataSystem Maintenance') < 1
        EXECUTE msdb.dbo.sp_add_category @name = N'DataSystem Maintenance'

  -- See if the job with the same name (if it exists)
    SELECT @JobID = job_id
    FROM   msdb.dbo.sysjobs
    WHERE (name = N'Start_System_Tasks')

    IF (@JobID IS NULL)
    BEGIN
    BEGIN TRANSACTION
      -- Add the job
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT ,
        @job_name = N'Start_System_Tasks', @owner_login_name = N'sa',
        @description = N'No description available.',
        @category_name = N'DataSystem Maintenance', @enabled = 1,
        @notify_level_email = 0, @notify_level_page = 0,
        @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    
      -- Add the job steps
      EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1,
         @step_name = N'Main_SysTasks', @command = N'execute dbo.uspStartTasks',
         @database_name = N'Injector', @server = N'', @database_user_name = N'',
         @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0,
         @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'',
         @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0,
         @on_fail_action = 2
      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
      EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
    
      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    
      -- Add the job schedules
      EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID,
         @name = N'SysTasksSched', @enabled = 1, @freq_type = 64
      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    
      -- Add the Target Servers
      EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID,
         @server_name = N'(local)'
      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    
    COMMIT TRANSACTION
    END

    declare c_jobs CURSOR LOCAL FORWARD_ONLY FOR
        SELECT Tasknumber, Taskid, Tasknextdate from dbo.tblSystemTask
         FOR UPDATE OF Taskid, Tasknextdate
    open c_jobs
    fetch c_jobs into @v_jobnum, @JobID, @v_job_next_date
    WHILE @@FETCH_STATUS = 0
    BEGIN
    set @v_tStr = N'System_Task_' + cast(@v_jobnum as nvarchar)
    -- See if the job with the same name (if it exists)
    SELECT @JobID = job_id
    FROM   msdb.dbo.sysjobs
    WHERE (name = @v_tStr)
    IF (@JobID IS NULL) -- if job does not exist then add it
        BEGIN
        BEGIN TRANSACTION
        -- Add the job
        EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT ,
            @job_name = @v_tStr, @owner_login_name = N'sa',
            @description = N'Injector System Task Monitor',
            @category_name = N'DataSystem Maintenance', @enabled = 1,
            @notify_level_email = 0, @notify_level_page = 0,
            @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
        IF (@@ERROR <> 0 OR @ReturnCode <> 0)
            GOTO QuitWithRollback
        -- Add the job steps
        set @v_tStr = N'Execute dbo.uspRunSystemTask ' + cast(@v_jobnum as nvarchar)
        EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1,
            @step_name = N'Only_Step', @command = @v_tStr,
            @database_name = N'Injector', @server = N'', @database_user_name = N'',
            @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0,
            @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'',
            @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0,
            @on_fail_action = 2
        IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
        EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
    
        IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
        -- Add the job schedules
        set @v_job_next_date = dateadd(ss,10,getdate())
        set @v_tnum = (datepart(hh,@v_job_next_date) * 10000) +
            (datepart(mi,@v_job_next_date) * 100) + datepart(ss,@v_job_next_date)
        EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID,
            @name = N'SysTasksSchedule',
            @enabled = 1, @freq_type = 1, @active_start_time = @v_tnum
        IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    
        -- Add the Target Servers
        EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID,
            @server_name = N'(local)'
        IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    
        update dbo.tblSystemTask
        set Taskid = @JobID, Tasknextdate = Isnull(Tasknextdate,@v_job_next_date)
        where current of c_jobs
        Commit Transaction
        END
    ELSE
        EXECUTE @ReturnCode = msdb.dbo.sp_start_job @job_id = @JobID,
            @server_name = N'(local)', @step_name = N'Only_Step'
    fetch c_jobs into @v_jobnum, @JobID, @v_job_next_date
    END
    CLOSE c_jobs
    DEALLOCATE c_jobs
    GOTO   EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
End
