

INSERT INTO App VALUES ('Congress', 'Congress')


INSERT INTO Term 
SELECT 
	FullName
	, 1 
FROM CongressView  


INSERT INTO AppTerm
SELECT (SELECT ID FROM App WHERE Name = 'Congress'), t.ID 
FROM Term t
WHERE t.ID > 564






INSERT INTO App VALUES ('Senate', 'Senate')


INSERT INTO Term 
SELECT 
	FullName
	, 1 
FROM SenateView  


INSERT INTO AppTerm
SELECT (SELECT ID FROM App WHERE Name = 'Senate'), t.ID 
FROM Term t
WHERE t.ID > 1002


