WITH f AS (INSERT INTO fixture VALUES
  (default,'2019-06-23',(SELECT id FROM opposition WHERE LOWER(name) LIKE '%norwood exiles%'),1,'','Limited Overs',40,default,TRUE,TRUE,'won')
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),1,TRUE,234,10,168,10,0,7,5)
, (default,(SELECT id FROM f),2,FALSE,240,8,159,0,0,13,4)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Davies'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'D Gillan'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Oliver'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'S Ali'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Sandham'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'Saril'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Doy'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Papadopoulos'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),1,4,0,0,0,'lbw',null,'J Smith',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),2,99,55,5,0,'lbw',null,'M Hider',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),3,12,3,0,0,'bowled',null,'J Thompson',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),4,27,11,1,0,'caught',null,'C Arthur',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),5,40,55,8,0,'caught',null,'A Parfitt',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),6,5,6,0,0,'bowled',null,'M Hider',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'S Ali'),7,8,8,0,0,'stumped',null,'J Tonkin',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),8,15,6,0,0,'bowled',null,'J Tonkin',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),9,1,0,0,0,'bowled',null,'A Parfitt',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),10,1,0,0,0,'bowled',null,'A Parfitt',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),11,5,2,0,0,'not_out',null,null,null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),1,48,2,20,1,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Sandham'),2,30,0,30,0,0,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),3,48,0,27,3,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),4,42,1,26,0,0,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),5,12,0,12,0,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'S Ali'),6,42,0,30,0,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),7,18,0,14,3,5,0,0)




),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),'lbw',null,(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),1,34)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'Saril'),2,37)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),3,5)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),4,43)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),5,4)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),6,15)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),7,0)

, (default,(SELECT id FROM i WHERE innings_order = 1),'run_out',(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),null,9,3)


)
SELECT 'complete';