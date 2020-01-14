WITH f AS (INSERT INTO fixture VALUES
  (default,'2019-06-02',(SELECT id FROM opposition WHERE LOWER(name) LIKE '%railway taverners%'),1,'North Middlesex CC','Limited Overs',40,default,null,FALSE,'lost')
RETURNING id),

i AS (INSERT INTO innings VALUES
  (default,(SELECT id FROM f),2,TRUE,238,10,208,11,4,15,1)
, (default,(SELECT id FROM f),1,FALSE,240,4,275,16,3,6,4)
RETURNING id, innings_order),

sm AS (INSERT INTO squad_member VALUES
  (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Jamieson'),TRUE,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Webster'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'J Dewhirst'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'L Killen'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'A Mortimer'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'H Jamieson'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'S Ali'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'M Davies'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'P Byrne'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'C Bradbury'),null,null)
, (default,(SELECT id FROM f),(SELECT id FROM player WHERE scorecard_name = 'R Bishop'),null,null)
RETURNING id, player_id),

smp AS (SELECT sm.id, p.scorecard_name FROM sm JOIN player p ON sm.player_id = p.id),

pbat AS (INSERT INTO player_batting_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'R Bishop'),1,40,23,3,0,'bowled',null,'A James',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),2,21,20,4,0,'bowled',null,'David',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Dewhirst'),3,8,4,0,0,'bowled',null,'Buster',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'L Killen'),4,28,7,1,0,'caught',null,'Bazza',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'A Mortimer'),5,30,15,0,0,'caught',null,'Jockey',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'H Jamieson'),6,20,21,3,1,'caught',null,'Greg',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'S Ali'),7,14,10,1,0,'caught',null,'Jockey',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),8,14,10,1,0,'caught',null,'Jockey',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),9,25,33,3,2,'not_out',null,null,null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),10,11,16,2,0,'bowled',null,'David',null)
, (default,(SELECT id FROM i WHERE innings_order = 2),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),11,7,15,2,1,'bowled',null,'Mulligan',null)
),

pbowl AS (INSERT INTO player_bowling_innings VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'P Byrne'),1,48,0,53,0,3,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),2,48,0,50,1,1,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,48,0,36,1,1,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),4,48,0,36,1,1,0,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'S Ali'),5,36,0,57,0,0,1,0)
, (default,(SELECT id FROM i WHERE innings_order = 1),(SELECT id FROM smp WHERE scorecard_name = 'A Webster'),6,12,0,22,0,1,0,0)





),

w AS (INSERT INTO wicket VALUES
  (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),1,11)
, (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'C Bradbury'),2,122)
, (default,(SELECT id FROM i WHERE innings_order = 1),'bowled',null,(SELECT id FROM smp WHERE scorecard_name = 'J Jamieson'),3,5)

, (default,(SELECT id FROM i WHERE innings_order = 1),'run_out',(SELECT id FROM smp WHERE scorecard_name = 'M Davies'),null,5,9)






)
SELECT 'complete';