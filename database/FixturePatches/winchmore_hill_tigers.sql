WITH f AS (INSERT INTO fixture VALUES
  (default,'2019-08-11',(SELECT id FROM opposition WHERE LOWER(name) LIKE '%winchmore hill tigers%'),1,'Winchmore Hill CC','Limited Overs',40,default,FALSE,FALSE,'won')
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,180,2,186,0,0,4,2)
, (default,(SELECT id FROM f),1,FALSE,240,8,183,8,3,13,2)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Anderson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'D Gillan'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'L Killen'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Byrne'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Sandham'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Asthana'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Dogar'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),1,88,75,11,0,'not_out',null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),2,18,24,4,0,'caught',null,'Ravi',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),3,29,15,2,0,'caught',null,'Samit',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),4,43,61,10,1,'not_out',null,null,null)







),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),1,42,2,20,2,3,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),2,48,1,40,1,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),3,30,0,17,3,0,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),4,42,1,25,1,2,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),5,30,1,18,1,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Asthana'),6,36,0,38,0,4,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),7,12,0,14,0,2,0,0)




),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),1,20)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),2,2)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),3,11)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),4,2)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),5,9)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),6,31)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'A Dogar'),7,24)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),8,13)



)
SELECT 'complete';