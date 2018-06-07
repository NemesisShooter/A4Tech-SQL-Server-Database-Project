CREATE TABLE [DWH].[FactJobChange] (
    [IdDimEmployee] INT   NULL,
    [IdDimJobs]     INT   NULL,
    [IdDimDate]     INT   NULL,
    [FactMoney]     MONEY NULL,
    CONSTRAINT [FK_DimDate] FOREIGN KEY ([IdDimDate]) REFERENCES [DWH].[DimDate] ([DateKey]),
    CONSTRAINT [FK_DimEmployee] FOREIGN KEY ([IdDimEmployee]) REFERENCES [DWH].[DimEmployee] ([IdDimEmployee]),
    CONSTRAINT [FK_DimJobs] FOREIGN KEY ([IdDimJobs]) REFERENCES [DWH].[DimJobs] ([IdDimJobs])
);

