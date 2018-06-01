CREATE TABLE [DWH].[FData] (
    [FDataID]    INT IDENTITY (1, 1) NOT NULL,
    [LocationID] INT NULL,
    [AreaID]     INT NULL,
    [DateID]     INT NULL,
    [Population] INT NULL,
    PRIMARY KEY CLUSTERED ([FDataID] ASC),
    CONSTRAINT [fk_AreaID] FOREIGN KEY ([AreaID]) REFERENCES [DWH].[Area] ([AreaID]),
    CONSTRAINT [FK_DateID] FOREIGN KEY ([DateID]) REFERENCES [DWH].[DateIntroduced] ([DateID]),
    CONSTRAINT [FK_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [DWH].[Location] ([LocationID])
);

