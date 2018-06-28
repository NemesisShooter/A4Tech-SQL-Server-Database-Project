USE [msdb]
GO

/*
    /ISSERVER 
	This specifies that we're using the fancy new execution engine built into the SSISDB
    We pass in the package we want to execute to this option
    /SERVER 
	Where will these packages be found
    Specify the server name and optional instance
    /X86 
	As the fine documentation notes, this option only works for invocation from SQL Agent but this is how you specify you need to use the 32 bit dtexec.exe
    /Par 
	Specify parameter values as needed
    Indicates our standard, Basic, level of logging
    The next instance of /Par specifies whether the caller should wait for the process to complete (synchronous versus asynchronous process). Yes, the job steps should wait for the process to complete.
    /Reporting
	What information should be reported. This is odd because the useful information you used to get in an SQL Agent job report is no longer there. It will just say Consult the SSISDB reports for more information
    E, report Errors only.
	/ENVREFERENCE
	Reference ID of environment 

	@mycommand = N'/ISSERVER "\"\SSISDB\POC\SSISConfigMixAndMatch\Package.dtsx\"" /SERVER "\".\dev2014\"" /X86 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
*/

DECLARE
@StartDate NVARCHAR(8) = CONVERT(NVARCHAR(8), DATEADD(DAY,1,GETDATE()), 112),
@IsServer NVARCHAR(100) = 'SSISDB\DEV\A4Tech\Package.dtsx',
@Server NVARCHAR(60) = 'M-SIMIONIDI',
@ReferenceId NVARCHAR(3) = 
(
SELECT  reference_id
  FROM  [SSISDB].[catalog].[environment_references] er
        JOIN [SSISDB].[catalog].[projects] p ON p.project_id = er.project_id
 WHERE  er.environment_name = 'DEV'
   AND  p.name              = 'A4Tech'
   ),
@DtExecBit NVARCHAR(2)= '64'

DECLARE
@CommandLine NVARCHAR(200) = N'/ISSERVER "\"\' + @IsServer + '\"" /SERVER "\"' + @Server + '\"" /ENVREFERENCE ' + @ReferenceId + '/X' + @DtExecBit + ' /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'


--Add a job
EXEC sp_add_job
    @job_name = N'Run SSIS' ;

--Add a job step named process step. This step runs the stored procedure
EXEC sp_add_jobstep
    @job_name = N'Run SSIS',
    @step_name = N'process step',
    @subsystem = N'SSIS',
    @command = @CommandLine

--Schedule the job at a specified date and time
EXEC sp_add_jobschedule 
@job_name = N'Run SSIS',
@name = N'Run SSIS',
@freq_type = 4,
@freq_interval = 1,
@active_start_date = @StartDate,
@active_start_time = '160000'

-- Add the job to the SQL Server Server
EXEC sp_add_jobserver
    @job_name =  N'Run SSIS',
    @server_name = @@servername