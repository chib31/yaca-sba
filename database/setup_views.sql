-- Drop all views
DROP VIEW IF EXISTS wicket_details;
DROP VIEW IF EXISTS player_bowling_innings_details;
DROP VIEW IF EXISTS player_batting_innings_details;
DROP VIEW IF EXISTS innings_details;
DROP VIEW IF EXISTS fixture_details;
DROP VIEW IF EXISTS player_details;

CREATE OR REPLACE VIEW player_details AS (
	SELECT
		p.id
	, p.scorecard_name
	, p.cap_number
	, p.shirt_number
	FROM player p
);

CREATE OR REPLACE VIEW fixture_details AS (
	SELECT
		f.id
	, f.date
	, o.name opposition
	, f.location
	, CONCAT(f.match_type||' ('||f.innings_length||')') format
	, p.scorecard_name captain
	, CASE WHEN f.win_toss IS TRUE THEN 'won' WHEN f.win_toss IS FALSE THEN 'lost' ELSE 'n/a' END coin_toss
	, f.bat_first plastics_bat_first
	, pi.runs||' - '||pi.wickets plastics_score
	, oi.runs||' - '||oi.wickets opposition_score
	, f.result
	, CASE 
			WHEN f.result = 'won' THEN
				CASE 
					WHEN f.bat_first THEN 'Won by '||(pi.runs - oi.runs)||' run(s)'
					ELSE 'Won by '||(10 - pi.wickets)||' wicket(s)'
				END
			WHEN f.result = 'lost' THEN
				CASE
					WHEN f.bat_first THEN 'Lost by '||(10 - oi.wickets)||' wicket(s)'
					ELSE 'Lost by '||(oi.runs - pi.runs)||' run(s)'
				END
			WHEN f.result = 'tied' THEN 'Match tied'
			WHEN f.result = 'drawn' THEN 'Match drawn'
			ELSE 'No result'
		END result_details
	, f.over_length
	FROM fixture f
	JOIN opposition o ON f.opposition_id = o.id
	JOIN squad_member sm ON (sm.fixture_id = f.id AND sm.captain IS TRUE)
	JOIN player p ON p.id = sm.player_id
	JOIN constant c ON c.id = 1
	JOIN innings pi ON (pi.fixture_id = f.id AND pi.us_batting IS TRUE)
	JOIN innings oi ON (oi.fixture_id = f.id AND oi.us_batting IS FALSE)
);

CREATE OR REPLACE VIEW innings_details AS (
	SELECT
		i.id
	, f.date
	, i.innings_order
	, CASE WHEN i.us_batting IS TRUE THEN c.team_name ELSE o.name END batting_team
	, CASE WHEN i.us_batting IS FALSE THEN c.team_name ELSE o.name END bowling_team
	, i.deliveries
	, i.wickets
	, i.runs
	, i.byes
	, i.leg_byes
	, i.wides
	, i.no_balls
	, COALESCE(i.byes,0) + COALESCE(i.leg_byes,0) + COALESCE(i.wides,0) + COALESCE(i.no_balls,0) total_extras
	, ROUND(i.runs::decimal / (i.deliveries::decimal / 6), 2) run_rate
	FROM innings i
	JOIN fixture f ON i.fixture_id = f.id
	JOIN opposition o ON f.opposition_id = o.id
	JOIN constant c ON c.id = 1
);

CREATE OR REPLACE VIEW player_batting_innings_details AS (
	SELECT
		pbi.id
	, p.scorecard_name
	, fd.opposition
	, fd.date
	, pbi.position
	, pbi.runs
	, pbi.deliveries
	, pbi.fours
	, pbi.sixes
	, CASE
			WHEN pbi.wicket IN('bowled','caught','hit_twice','hit_wicket','lbw','obstructing','run_out','stumped','timed_out','other') THEN 1
			ELSE 0
		END wicket
	, pbi.wicket wicket_type
	, i.runs team_total
	, fd.result
-- 	, ROUND((pbi.runs::decimal / NULLIF(pbi.deliveries::decimal, 0)) * 100, 2) strike_rate
-- 	, ROUND((pbi.runs::decimal / NULLIF(i.runs::decimal, 0)) * 100, 2) percent_of_total
	FROM player_batting_innings pbi
	JOIN squad_member sm ON pbi.squad_member_id = sm.id
	JOIN player p ON sm.player_id = p.id
	JOIN innings i ON pbi.innings_id = i.id
	JOIN fixture_details fd ON i.fixture_id = fd.id
);

CREATE OR REPLACE VIEW player_bowling_innings_details AS (
	SELECT
    pbi.id
  , p.scorecard_name
	, fd.opposition
  , fd.date
	, pbi.bowler_number
	, pbi.deliveries
	, pbi.maidens
	, pbi.runs
	, pbi.wickets
	, pbi.wides
	, pbi.no_balls
	, pbi.hat_tricks
	, fd.result
  , ROUND(pbi.runs::decimal / NULLIF((pbi.deliveries::decimal / 6),0), 2) economy
	, fd.over_length
	FROM player_bowling_innings pbi
  JOIN squad_member sm ON pbi.squad_member_id = sm.id
  JOIN player p ON sm.player_id = p.id
	JOIN innings i ON pbi.innings_id = i.id
	JOIN fixture_details fd ON i.fixture_id = fd.id
);

CREATE OR REPLACE VIEW wicket_details AS (
	SELECT
		w.id
	, fd.date
	, fd.opposition
	, w.wicket_type
	, pb.scorecard_name bowler
	, pf.scorecard_name fielder
	, w.batting_position
	, w.batter_runs
	FROM wicket w
	JOIN innings i ON w.innings_id = i.id
	JOIN fixture_details fd ON i.fixture_id = fd.id
  LEFT JOIN squad_member smb ON w.bowler_id = smb.id
  LEFT JOIN squad_member smf ON w.fielder_id = smf.id
  LEFT JOIN player pb ON smb.player_id = pb.id
  LEFT JOIN player pf ON smf.player_id = pf.id
);
