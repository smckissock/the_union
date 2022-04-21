
INSERT INTO App VALUES ('eSports', 'esports')


-- https://www.ranker.com/list/best-esports-teams/ranker-games

INSERT INTO Term VALUES ('Team Liquid', 1)
INSERT INTO Term VALUES ('FaZe Clan', 1)
INSERT INTO Term VALUES ('Cloud9', 1)
INSERT INTO Term VALUES ('OpTic Gaming', 1)
INSERT INTO Term VALUES ('Team SoloMid', 1)
INSERT INTO Term VALUES ('Fnatic', 1)
INSERT INTO Term VALUES ('100 Thieves', 1)
INSERT INTO Term VALUES ('G2 Esports', 1)
INSERT INTO Term VALUES ('Luminosity Gaming', 1)
INSERT INTO Term VALUES ('Team Envy', 1)
INSERT INTO Term VALUES ('Evil Geniuses', 1)
INSERT INTO Term VALUES ('NRG eSports', 1)
INSERT INTO Term VALUES ('Astralis', 1)
INSERT INTO Term VALUES ('Team Kaliber', 1)
INSERT INTO Term VALUES ('Ninjas In Pyjamas', 1)
INSERT INTO Term VALUES ('Team Secret', 1)
INSERT INTO Term VALUES ('Natus Vincere', 1)
INSERT INTO Term VALUES ('compLexity Gaming', 1)
INSERT INTO Term VALUES ('SK Telecom T1', 1)
INSERT INTO Term VALUES ('SK Gaming', 1)
INSERT INTO Term VALUES ('Virtus.pro', 1)
INSERT INTO Term VALUES ('Counter Logic Gaming', 1)
INSERT INTO Term VALUES ('Mousesports', 1)
INSERT INTO Term VALUES ('Team Dignitas', 1)
INSERT INTO Term VALUES ('Echo Fox', 1)
INSERT INTO Term VALUES ('Shadow Aspect', 1)
INSERT INTO Term VALUES ('Flipside Tactics', 1)
INSERT INTO Term VALUES ('Tempo Storm', 1)
INSERT INTO Term VALUES ('Epsilon eSports', 1)
INSERT INTO Term VALUES ('Team LDLC', 1)
INSERT INTO Term VALUES ('Gambit Esports', 1)
INSERT INTO Term VALUES ('Invictus Gaming', 1)
INSERT INTO Term VALUES ('Newbee', 1)
INSERT INTO Term VALUES ('Vici Gaming', 1)
INSERT INTO Term VALUES ('EDward Gaming', 1)
INSERT INTO Term VALUES ('LGD Gaming', 1)
INSERT INTO Term VALUES ('KT Rolster', 1)
INSERT INTO Term VALUES ('Wings Gaming', 1)
INSERT INTO Term VALUES ('Team WE', 1)
INSERT INTO Term VALUES ('Alternate aTTaX', 1)
INSERT INTO Term VALUES ('CDEC Gaming', 1)


-- Fortnite teams
-- https://www.ranker.com/list/best-fortnite-esports-teams/ranker-games?ref=inline&pos=2&a=42&ltype=l&l=2677306&g=1&li_source=LI&li_medium=desktop-grid-inline

INSERT INTO Term VALUES ('Ghost Gaming', 1)
INSERT INTO Term VALUES ('Team Secret', 1)
INSERT INTO Term VALUES ('Solary', 1)
INSERT INTO Term VALUES ('EnVyUs', 1)
INSERT INTO Term VALUES ('Millenium', 1)
INSERT INTO Term VALUES ('SetToDestroyX', 1)
INSERT INTO Term VALUES ('compLexity Gaming', 1)
INSERT INTO Term VALUES ('Pittsburgh Knights', 1)
INSERT INTO Term VALUES ('AGO Gaming', 1)
INSERT INTO Term VALUES ('Oserv Esport', 1)
INSERT INTO Term VALUES ('War Legend', 1)
INSERT INTO Term VALUES ('Team Requiem', 1)
INSERT INTO Term VALUES ('Gentside Esports Club', 1)
INSERT INTO Term VALUES ('GamersOrigin', 1)
INSERT INTO Term VALUES ('Raised by Kings', 1)

 
INSERT INTO AppTerm
SELECT (SELECT ID FROM App WHERE Name = 'eSports'), t.ID 
FROM Term t
WHERE t.ID > 1102


SELECT * FROm MediaCoudBatchView -- 719
