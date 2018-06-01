CREATE TABLE [DWH].[DimJobs] (
    [IdDimJobs] INT           IDENTITY (1, 1) NOT NULL,
    [JobTitle]  NVARCHAR (50) NULL,
    CONSTRAINT [PK_DimJobs] PRIMARY KEY CLUSTERED ([IdDimJobs] ASC)
);

