USE RussiaNews
GO

DELETE FROM Event WHERE EventTypeID IN (SELECT ID FROM EventType WHERE AppID = (SELECT ID FROM App WHERE Name = 'Fortnite'))
DELETE FROM EventType WHERE AppID = (SELECT ID FROM App WHERE Name = 'Fortnite') 

INSERT INTO EventType VALUES ('Seasons', '', 10, (SELECT ID FROM App WHERE Name = 'Fortnite'))
INSERT INTO EventType VALUES ('Tournaments', '', 20, (SELECT ID FROM App WHERE Name = 'Fortnite'))
INSERT INTO EventType VALUES ('Pop Culture', '', 30, (SELECT ID FROM App WHERE Name = 'Fortnite'))


INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Seasons' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Season 1', '', '2017-10-13', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Seasons' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Season 2', '', '2017-12-14', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Seasons' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Season 3', '', '2018-02-22', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Seasons' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Season 4', '', '2018-05-01', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Seasons' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Season 5', '', '2018-07-12', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Seasons' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Season 6', '', '2018-09-27', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Seasons' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Season 7', '', '2018-12-06', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Seasons' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Season 8', '', '2018-02-28', GetDate()) 

INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Tournaments' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Secret Skirmish', '', '2019-02-14', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Tournaments' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Winter Royale', '', '2018-12-11', GetDate()) 

INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Pop Culture' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Ninja appears in Super Bowl commercial', '', '2019-02-09', GetDate()) 
INSERT INTO Event VALUES ((SELECT ID FROM EventType WHERE Name = 'Pop Culture' AND AppID = (SELECT ID FROM App WHERE Name = 'Fortnite')), 'Ninja appears on Jimmy Fallon', '', '2018-12-18', GetDate()) 