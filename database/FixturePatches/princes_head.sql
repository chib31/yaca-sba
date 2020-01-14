WITH f AS (INSERT INTO fixture VALUES
  (default,'20/07/2019',(SELECT id FROM opposition WHERE LOWER(name) LIKE '%princes head%'),1,'Richmond Green','Limited Overs',35,default,TRUE,FALSE,'lost')
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,206,10,177,1,2,6,3)
, (default,(SELECT id FROM f),1,FALSE,210,5,181,4,1,14,6)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Mortimer'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Oliver'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'S Ali'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'L Killen'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Anderson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Bishop'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Jamieson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Doy'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Papadopoulos'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Mortimer'),1,22,12,2,0,'lbw',null,'Mike',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Oliver'),2,22,9,2,0,'caught',null,'Mike',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'S Ali'),3,31,36,7,0,'caught',null,'Ray',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),4,14,10,2,0,'caught',null,'Ray',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),5,32,19,2,0,'bowled',null,'Phil',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'L Killen'),6,2,0,0,0,'caught',null,'Phil',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),7,4,4,1,0,'caught',null,'Phil',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),8,45,45,7,0,'stumped',null,'Mike',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),9,30,24,3,0,'bowled',null,'Ian',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),10,3,2,0,0,'not_out',null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),11,4,4,0,0,'caught',null,'Harvey',null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),1,42,3,23,1,0,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),2,42,1,32,1,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,42,0,33,0,2,3,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),4,42,1,58,1,2,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),5,42,1,30,1,8,3,0)






),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),1,2)
, (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),2,31)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'J Doy'),(SELECT id FROM smp WHERE scorecard_name = 'P Bishop'),3,44)
, (default,(SELECT id FROM i WHERE innings_order = 1),'caught',(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),(SELECT id FROM smp WHERE scorecard_name = 'J Papadopoulos'),4,51)

, (default,(SELECT id FROM i WHERE innings_order = 1),'run_out',(SELECT id FROM smp WHERE scorecard_name = 'J Anderson'),null,6,5)





)
SELECT 'complete';