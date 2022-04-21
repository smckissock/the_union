


INSERT INTO App VALUES ('Ryan McElveen', '')
INSERT INTO App VALUES ('Fortnite', '')
INSERT INTO App VALUES ('Niskanen Center', '')
INSERT INTO App VALUES ('USAID', '')
INSERT INTO App VALUES ('The Bulwark', '')
INSERT INTO App VALUES ('Raised by Kings', '')
INSERT INTO App VALUES ('Cory Booker', '')
INSERT INTO App VALUES ('Fannie Mae', '')
INSERT INTO App VALUES ('Freddie Mac', '')
INSERT INTO App VALUES ('Steelers', '')
INSERT INTO App VALUES ('Amy Klobachar', '')
INSERT INTO App VALUES ('Committee To Investigate Russia', '')
INSERT INTO App VALUES ('Center for American Progress', '')
INSERT INTO App VALUES ('Atlantic Council', '')
INSERT INTO App VALUES ('Media Cloud', '')
INSERT INTO App VALUES ('DiffBott', '')

UPDATE App SET ShortName = Name WHERE ShortName = ''  


INSERT INTO Term 
SELECT Name, 1 FROM App WHERE SHORTName NOT IN ('RussiaNews', 'McElveen') 


INSERT INTO AppTerm
SELECT a.ID, t.ID 
FROM App a
JOIN  Term t ON t.Name = a.Name
WHERE a.ShortName NOT IN ('RussiaNews', 'McElveen') 


