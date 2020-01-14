WITH f AS (INSERT INTO fixture VALUES
  (default,'2019-05-06',(SELECT id FROM opposition WHERE LOWER(name) LIKE '%graces%'),1,'Barnes Elms CC','Limited Overs',20,default,FALSE,FALSE,'lost')
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,120,7,103,1,0,20,0)
, (default,(SELECT id FROM f),1,FALSE,120,6,121,3,4,17,1)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Webb'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'D Gillan'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Anderson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Byrne'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Mortimer'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Jamieson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Oliver'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Papadopoulos'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Mortimer'),1,32,14,1,0,'bowled',null,'Neen',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),2,9,10,1,0,'caught',null,'Jeshant',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),3,41,33,3,0,'stumped',null,'Sam',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),4,10,3,0,0,'bowled',null,'Neen',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),5,1,0,0,0,'lbw',null,'Neen',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),6,6,1,0,0,'bowled',null,'Neen',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),7,9,8,0,0,'not_out',null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),8,4,8,2,0,'bowled',null,'Sanjeev',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),9,6,6,0,0,'not_out',null,null,null)


),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),1,24,0,18,1,1,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),2,24,0,18,2,6,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,24,0,9,0,1,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),4,12,0,18,1,1,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),5,24,0,24,1,1,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),6,12,0,27,0,7,1,0)





),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),1,11)
, (default,(SELECT id FROM i WHERE innings_order = 1),'lbw',null,(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),2,9)

, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'D Gillan'),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),4,3)
, (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'M Webb'),5,6)
, (default,(SELECT id FROM i WHERE innings_order = 1),'run_out',(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),null,6,9)
, (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),7,2)




)
SELECT 'complete';