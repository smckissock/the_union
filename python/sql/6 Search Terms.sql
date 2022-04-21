USE TrumpRussia
GO

INSERT INTO RdfType VALUES ('Person', 'http://dbpedia.org/ontology/Person') 
INSERT INTO RdfType VALUES ('Organization', 'http://dbpedia.org/ontology/Organisation') 
INSERT INTO RdfType VALUES ('Place', 'http://dbpedia.org/ontology/PopulatedPlace') 

INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Yevgeniy Prigozhin'))




INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Aras Agalarov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Dmitry Peskov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Dmitry Rybolovlev'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Dmytro Firtash'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Emin Agalarov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Igor Sechin'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Konstantin Kilimnik'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Natalia Veselnitskaya'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Rick Dearborn'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Rinat Akhmetshin'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Sergei Ivanov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Sergey Kislyak'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Sergey Lavrov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Sergey Shoygu'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Valery Gerasimov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Viktor Khrapunov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Viktor Yanukovych'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Sergei Gorkov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Irakly Kaveladze'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Alexander Mashkevich'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Herman Gref'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Sergei Ryabkov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Evgeny Buryakov'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Yevgeniy Prigozhin'))


INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Affliction Entertainment'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Crowdstrike'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Essential Consultants'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Leonard Blavatnik'))
INSERT INTO SearchTerm VALUES ((SELECT ID FROM Entity WHERE Name = 'Oleg Deripaska'))

