CREATE TABLE [DWH].[Location] (
    [LocationID]   INT           IDENTITY (1, 1) NOT NULL,
    [Postcode 1]   VARCHAR (255) NULL,
    [Easting]      DECIMAL (18)  NULL,
    [Northing]     DECIMAL (18)  NULL,
    [County Code]  VARCHAR (255) NULL,
    [County Name]  VARCHAR (255) NULL,
    [Country Code] VARCHAR (255) NULL,
    [Country Name] VARCHAR (255) NULL,
    [Region Code]  VARCHAR (255) NULL,
    [Region Name]  VARCHAR (255) NULL,
    [VERSION]      INT           NULL,
    PRIMARY KEY CLUSTERED ([LocationID] ASC)
);

