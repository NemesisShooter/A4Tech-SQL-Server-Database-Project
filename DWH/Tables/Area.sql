CREATE TABLE [DWH].[Area] (
    [AreaID]                          INT           IDENTITY (1, 1) NOT NULL,
    [Output Area Classification Name] VARCHAR (255) NULL,
    [European Electoral Region Name]  VARCHAR (255) NULL,
    [Primary Care Trust Name]         VARCHAR (255) NULL,
    [Location]                        VARCHAR (255) NULL,
    [VERSION]                         INT           NULL,
    PRIMARY KEY CLUSTERED ([AreaID] ASC)
);

