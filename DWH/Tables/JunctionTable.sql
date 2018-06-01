CREATE TABLE [DWH].[JunctionTable] (
    [AreaID]     INT NULL,
    [LocationID] INT NULL,
    CONSTRAINT [fk_AreaID_JUNK] FOREIGN KEY ([AreaID]) REFERENCES [DWH].[Area] ([AreaID]),
    CONSTRAINT [FK_LocationID_JUNK] FOREIGN KEY ([LocationID]) REFERENCES [DWH].[Location] ([LocationID])
);

