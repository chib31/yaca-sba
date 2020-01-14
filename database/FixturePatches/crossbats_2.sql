WITH f AS (INSERT INTO fixture VALUES
  (default,'2019-08-03',(SELECT id FROM opposition WHERE LOWER(name) LIKE '%crossbats%'),1,'Marble Hill Park','Limited Overs',35,default,TRUE,TRUE,'lost')
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),1,TRUE,208,10,149,1,5,12,3)
, (default,(SELECT id FROM f),2,FALSE,187,6,153,5,0,18,0)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Jamieson'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Mortimer'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Davies'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'D Gillan'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Winter'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Doy'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Papadopoulos'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Oliver'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Mortimer'),1,11,5,1,0,'caught',null,'Humphrey',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),2,7,13,3,0,'run_out',null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),3,1,1,0,0,'run_out',null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),4,49,33,4,1,'caught',null,'Larry',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Winter'),5,26,9,0,0,'caught',null,'Larry',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),6,60,60,10,0,'caught',null,'Humphrey',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),7,8,1,0,0,'bowled',null,'Amir',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),8,1,0,0,0,'stumped',null,'Amir',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),9,35,5,0,0,'not_out',null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),10,6,1,0,0,'caught',null,'Humphrey',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),11,5,0,0,0,'bowled',null,'A Skinner',null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),1,42,1,38,1,6,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),2,19,0,17,1,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),3,18,0,11,0,3,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),4,36,0,41,2,6,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),5,36,0,18,2,3,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),6,18,0,11,0,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),7,18,1,9,0,0,0,0)




),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),1,9)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),2,9)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,56)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),4,23)
, (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),5,14)

, (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),7,0)




)
SELECT 'complete';