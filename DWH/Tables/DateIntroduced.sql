CREATE TABLE [DWH].[DateIntroduced] (
    [DateID]    INT  IDENTITY (1, 1) NOT NULL,
    [date]      DATE NULL,
    [day]       AS   (datepart(day,[date])),
    [month]     AS   (datepart(month,[date])),
    [DayOfWeek] AS   (datepart(weekday,[date])),
    PRIMARY KEY CLUSTERED ([DateID] ASC)
);

