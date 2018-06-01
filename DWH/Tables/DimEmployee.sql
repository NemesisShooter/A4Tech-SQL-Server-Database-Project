CREATE TABLE [DWH].[DimEmployee] (
    [IdDimEmployee]    INT           IDENTITY (1, 1) NOT NULL,
    [BusinessEntityID] INT           NULL,
    [Title]            NVARCHAR (5)  NULL,
    [FirstName]        NVARCHAR (50) NULL,
    [LastName]         NVARCHAR (50) NULL,
    [StartDate]        DATE          NULL,
    [EndDate]          DATE          NULL,
    CONSTRAINT [PK_DimEmployee] PRIMARY KEY CLUSTERED ([IdDimEmployee] ASC)
);

