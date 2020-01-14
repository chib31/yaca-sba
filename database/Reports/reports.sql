-- Match Results
SELECT *
FROM fixture_details
ORDER BY date
;

-- Season Summary
SELECT 
	fd.result
, COUNT(*)
FROM fixture_details fd
GROUP BY fd.result
;

-- Batting stats
SELECT
	pbid.player_name
, COUNT(*) innings
, SUM(pbid.runs) runs
, SUM(pbid.deliveries) deliveries
, SUM(pbid.fours) fours
, SUM(pbid.sixes) sixes
, SUM(pbid.wicket) wickets
, ROUND(SUM(pbid.runs::decimal) / NULLIF(SUM(pbid.wicket::decimal), 0), 2) average
, ROUND((SUM(pbid.runs::decimal) * 100) / SUM(pbid.deliveries)::decimal, 2) strike_rate
, COUNT(*) FILTER (WHERE pbid.wicket = 0) not_outs
, ROUND(SUM(pbid.runs::decimal) / NULLIF(COUNT(*), 0), 2) runs_per_innings
, MAX(pbid.runs) highest_score
, MIN(pbid.runs) lowest_score
, COUNT(*) FILTER (WHERE pbid.runs = 0) ducks
, ROUND(AVG(pbid.position), 2) avg_position
FROM player_batting_innings_details pbid
GROUP BY pbid.player_name
ORDER BY runs DESC, deliveries
;

-- Team batting stats
SELECT
  COUNT(*) innings
, SUM(pbid.runs) runs
, SUM(pbid.deliveries) deliveries
, SUM(pbid.fours) fours
, SUM(pbid.sixes) sixes
, SUM(pbid.wicket) wickets
, ROUND(SUM(pbid.runs::decimal) / NULLIF(SUM(pbid.wicket::decimal), 0), 2) average
, ROUND((SUM(pbid.runs::decimal) * 100) / SUM(pbid.deliveries)::decimal, 2) strike_rate
, COUNT(*) FILTER (WHERE pbid.wicket = 0) not_outs
, COUNT(*) FILTER (WHERE pbid.runs = 0) ducks
FROM player_batting_innings_details pbid
;

-- Batting performances
SELECT *
FROM player_batting_innings_details pbid
ORDER BY runs DESC
;

-- Bowling stats
SELECT
	pbid.player_name
, COUNT(*) innings_bowled
, TRUNC(SUM(pbid.deliveries)::decimal / 6) + (0.1 * MOD(SUM(pbid.deliveries)::decimal, 6)) overs
, SUM(pbid.maidens) maidens
, SUM(pbid.runs) runs
, SUM(pbid.wickets) wickets
, SUM(pbid.wides) wides
, SUM(pbid.no_balls) no_balls
, SUM(pbid.hat_tricks) hat_tricks
, ROUND(SUM(pbid.runs)::decimal / NULLIF(SUM(pbid.wickets)::decimal, 0), 2) average
, ROUND(SUM(pbid.runs)::decimal / (NULLIF(SUM(pbid.deliveries)::decimal, 0) / 6), 2) economy
, ROUND(SUM(pbid.deliveries)::decimal / NULLIF(SUM(pbid.wickets)::decimal, 0), 2) strike_rate
, ROUND(AVG(pbid.bowler_number), 2) avg_bowling_order
, ROUND(SUM(pbid.deliveries)::decimal / NULLIF(SUM(pbid.wides)::decimal, 0), 2) deliveries_per_wide
, ROUND(SUM(pbid.deliveries)::decimal / NULLIF(SUM(pbid.no_balls)::decimal, 0), 2) deliveries_per_no_ball
FROM player_bowling_innings_details pbid
GROUP BY player_name
ORDER BY wickets DESC
;

-- Team bowling stats
SELECT
  COUNT(*) innings_bowled
, TRUNC(SUM(pbid.deliveries)::decimal / 6) + (0.1 * MOD(SUM(pbid.deliveries)::decimal, 6)) overs
, SUM(pbid.deliveries) deliveries
, SUM(pbid.maidens) maidens
, SUM(pbid.runs) runs
, SUM(pbid.wickets) wickets
, SUM(pbid.wides) wides
, SUM(pbid.no_balls) no_balls
, SUM(pbid.hat_tricks) hat_tricks
, ROUND(SUM(pbid.runs)::decimal / NULLIF(SUM(pbid.wickets)::decimal, 0), 2) average
, ROUND(SUM(pbid.runs)::decimal / (NULLIF(SUM(pbid.deliveries)::decimal, 0) / 6), 2) economy
, ROUND(SUM(pbid.deliveries)::decimal / NULLIF(SUM(pbid.wickets)::decimal, 0), 2) strike_rate
FROM player_bowling_innings_details pbid
;

-- Highest score per position
SELECT 
	pbid.position AS "#"
,	pbid.scorecard_name AS name
, pbid.opposition
, pbid.runs
, pbid.deliveries
, pbid.fours
, pbid.sixes
, pbid.wicket
, pbid.strike_rate AS "S/R"
, pbid.percent_of_total AS "% of Total"
FROM player_batting_innings_details pbid
JOIN (
  SELECT position, MAX(runs) max_val
  FROM player_batting_innings_details
  GROUP BY position
) m
ON m.position = pbid.position
WHERE pbid.runs = m.max_val
ORDER BY pbid.position ASC
;

-- Runs without boundaries
SELECT
	pbid.player_name
, SUM(pbid.runs) - (SUM(pbid.fours) * 4) - (SUM(pbid.sixes) * 6) runs_without_boundaries
FROM player_batting_innings_details pbid
GROUP BY pbid.player_name
ORDER BY runs_without_boundaries DESC
;

-- Swan award
SELECT player_name, deliveries, opposition, wicket_type
FROM player_batting_innings_details pbid
WHERE runs = 0
AND deliveries IS NOT NULL
ORDER BY deliveries DESC
;



-- Most per wicket type
SELECT player_name, wicket_type, COUNT(*) total
FROM player_batting_innings_details pbid
WHERE wicket_type NOT IN('not_out', 'bowled', 'caught')
GROUP BY player_name, wicket_type
ORDER BY total DESC
;

-- Giant Killers
SELECT
	COALESCE(wd.bowler, '(fielders)') bowler
, COUNT(*) wickets
, ROUND(AVG(wd.batting_position::decimal),2) average_batting_position_of_victims
, ROUND(AVG(wd.batter_runs::decimal),2) average_runs_scored_by_victims
, SUM(wd.batter_runs) total_runs_scored_by_victims
FROM wicket_details wd
GROUP BY wd.bowler
ORDER BY average_batting_position_of_victims DESC
;

-- Fielding Stats
SELECT
	RANK() OVER (ORDER BY COUNT(*) DESC)
, wd.fielder
, COUNT(*) FILTER(WHERE wd.wicket_type = 'caught') catches
, COUNT(*) FILTER(WHERE wd.wicket_type = 'run_out') run_outs
, COUNT(*) FILTER(WHERE wd.wicket_type = 'stumped') stumpings
, COUNT(*) total
FROM wicket_details wd
LEFT JOIN player_details pd ON wd.fielder = pd.player_name
WHERE fielder IS NOT NULL
GROUP BY fielder
ORDER BY total DESC
;

-- Batting stats
SELECT
	pbid.player_name
, COUNT(*) innings
, pbid.runs runs
, pbid.deliveries deliveries
, pbid.fours fours
, pbid.sixes sixes
, SUM(pbid.wicket) wickets
, ROUND(SUM(pbid.runs::decimal) / NULLIF(SUM(pbid.wicket::decimal), 0), 2) average
, ROUND((SUM(pbid.runs::decimal) * 100) / SUM(pbid.deliveries)::decimal, 2) strike_rate
, COUNT(*) FILTER (WHERE pbid.wicket = 0) not_outs
, ROUND(SUM(pbid.runs::decimal) / NULLIF(COUNT(*), 0), 2) runs_per_innings
, MAX(pbid.runs) highest_score
, MIN(pbid.runs) lowest_score
, COUNT(*) FILTER (WHERE pbid.runs = 0) ducks
, ROUND(AVG(pbid.position), 2) avg_position
FROM player_batting_innings_details pbid
GROUP BY pbid.player_name
ORDER BY runs DESC
;

SELECT * FROM player_batting_innings_details WHERE runs > 10 ORDER BY strike_rate DESC;

-- Personal win %
SELECT
  p.scorecard_name "name"
     , COUNT(*) matches
     , COUNT(*) FILTER (WHERE f.result = 'won') wins
     , COUNT(*) FILTER (WHERE f.result = 'lost') losses
     , CONCAT((COUNT(*) FILTER (WHERE f.result = 'won') * 100) / COUNT(*), '%') "win %"
FROM squad_member sm
       JOIN player p on sm.player_id = p.id
       JOIN fixture f ON sm.fixture_id = f.id
GROUP BY p.scorecard_name
HAVING COUNT(*) > 2
ORDER BY (COUNT(*) FILTER (WHERE f.result = 'won') * 100) / COUNT(*) DESC, matches DESC;

