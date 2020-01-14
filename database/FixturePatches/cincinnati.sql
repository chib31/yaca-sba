WITH f AS (INSERT INTO fixture VALUES
  (default,'2019-07-28',(SELECT id FROM opposition WHERE LOWER(name) LIKE '%cincinnati%'),1,'Greenwich Park','Limited Overs',35,default,TRUE,FALSE,'lost')
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,190,10,180,3,1,9,8)
, (default,(SELECT id FROM f),1,FALSE,210,4,215,5,1,14,1)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Anderson'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Davies'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'T Morgan-Grenville'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Jamieson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'Saril'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'S Freeman'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),1,21,31,5,1,'bowled',null,'Asif',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),2,14,6,0,0,'bowled',null,'Asif',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),3,48,24,2,0,'bowled',null,'Simon',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),4,8,8,1,0,'caught',null,'Elias',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,15,1,0,0,'bowled',null,'Simon',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'T Morgan-Grenville'),6,19,26,6,0,'caught',null,'Hajaad',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),7,29,29,3,1,'caught',null,'Jake',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),8,34,28,3,0,'caught',null,'Ben',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),9,5,1,0,0,'bowled',null,'Jake',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),10,6,4,1,0,'caught',null,'Ben',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'S Freeman'),11,0,0,0,0,'not_out',null,null,null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'S Freeman'),1,42,0,41,0,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),2,42,0,37,1,4,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,42,0,29,2,1,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),4,42,0,45,0,5,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'T Morgan-Grenville'),5,12,0,15,0,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),6,18,0,22,0,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),7,12,0,14,0,0,0,0)




),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),'retired',null,null,1,100)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),2,8)
, (default,(SELECT id FROM i WHERE innings_order = 1),'run_out',(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),null,3,71)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),4,12)
, (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),5,0)






)
SELECT 'complete';