-- Drop all tables
DROP TABLE IF EXISTS wicket CASCADE;
DROP TABLE IF EXISTS player_bowling_innings CASCADE;
DROP TABLE IF EXISTS player_batting_innings CASCADE;
DROP TABLE IF EXISTS innings CASCADE;
DROP TABLE IF EXISTS squad_member CASCADE;
DROP TABLE IF EXISTS fixture CASCADE;
DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS opposition CASCADE;
DROP TABLE IF EXISTS constant CASCADE;

-- Drop all types
DROP TYPE result_type;
DROP TYPE wicket_type;

-----------------------------------------------

-- Create all tables
CREATE TABLE opposition (
  id SERIAL PRIMARY KEY
, name VARCHAR(100) UNIQUE
);

CREATE TABLE player (
  id SERIAL PRIMARY KEY
, first_name VARCHAR NOT NULL
, middle_names VARCHAR
, last_name VARCHAR
, preferred_name VARCHAR
, scorecard_name VARCHAR UNIQUE NOT NULL
, cap_number INT UNIQUE
, date_of_membership DATE
, shirt_number INT
);

CREATE TYPE result_type AS ENUM ('won','lost','tied','drawn','n/a');

CREATE TABLE fixture (
  id SERIAL PRIMARY KEY
, date DATE NOT NULL
, opposition_id INT NOT NULL REFERENCES opposition(id)
, fixture_order INT DEFAULT 1 NOT NULL
, location VARCHAR(100)
, match_type VARCHAR(20) NOT NULL
, innings_length INT
, over_length INT DEFAULT 6
, win_toss BOOLEAN
, bat_first BOOLEAN NOT NULL
, result result_type NOT NULL
, UNIQUE (date, fixture_order)
);

CREATE TABLE squad_member (
  id SERIAL PRIMARY KEY
, fixture_id INT NOT NULL REFERENCES fixture(id)
, player_id INT NOT NULL REFERENCES player(id)
, captain BOOLEAN
, keeper BOOLEAN
, UNIQUE (fixture_id, player_id)
, UNIQUE (fixture_id, captain)
, UNIQUE (fixture_id, keeper)
);

CREATE TABLE innings (
  id SERIAL PRIMARY KEY
, fixture_id INT NOT NULL REFERENCES fixture(id)
, innings_order INT NOT NULL
, us_batting BOOLEAN NOT NULL
, deliveries INT
, wickets INT
, runs INT
, byes INT
, leg_byes INT
, wides INT
, no_balls INT
, UNIQUE (fixture_id, innings_order)
);

CREATE TYPE wicket_type AS ENUM ('dnb','not_out','retired','bowled','caught','hit_twice','hit_wicket','lbw','obstructing','run_out','stumped','timed_out','other');

CREATE TABLE player_batting_innings(
  id SERIAL PRIMARY KEY
, innings_id INT NOT NULL REFERENCES innings(id)
, squad_member_id INT NOT NULL REFERENCES squad_member(id)
, position INT NOT NULL
, deliveries INT
, runs INT NOT NULL
, fours INT
, sixes INT
, wicket wicket_type NOT NULL
, wicket_fielder VARCHAR(30)
, wicket_bowler VARCHAR(30)
, where_caught VARCHAR(100)
, UNIQUE (innings_id, position)
);

CREATE TABLE player_bowling_innings(
  id SERIAL PRIMARY KEY
, innings_id INT NOT NULL REFERENCES innings(id)
, squad_member_id INT NOT NULL REFERENCES squad_member(id)
, bowler_number INT NOT NULL
, deliveries INT
, maidens INT
, runs INT
, wickets INT
, wides INT
, no_balls INT
, hat_tricks INT
, UNIQUE (innings_id, bowler_number)
, UNIQUE (innings_id, squad_member_id)
);

CREATE TABLE wicket (
  id SERIAL PRIMARY KEY
, innings_id INT NOT NULL REFERENCES innings(id)
, wicket_type wicket_type NOT NULL
, fielder_id INT REFERENCES squad_member(id)
, bowler_id INT REFERENCES squad_member(id)
, batting_position INT
, batter_runs INT
, UNIQUE (innings_id, batting_position)
);

ALTER TABLE wicket
ADD CONSTRAINT bowler_required CHECK(bowler_id IS NOT NULL OR wicket_type IN('dnb','not_out','retired','hit_twice','obstructing','run_out','timed_out','other'));

ALTER TABLE wicket
ADD CONSTRAINT fielder_required CHECK(fielder_id IS NOT NULL OR wicket_type IN('dnb','not_out','retired','bowled','hit_twice','hit_wicket','lbw','obstructing','timed_out','other'));

ALTER TABLE wicket
ADD CONSTRAINT bowler_not_allowed CHECK(bowler_id IS NULL OR wicket_type IN('bowled','caught','hit_wicket','lbw','stumped','other'));

ALTER TABLE wicket
ADD CONSTRAINT fielder_not_allowed CHECK(fielder_id IS NULL OR wicket_type IN('caught','run_out','stumped','other'));

CREATE TABLE constant (
	id INTEGER UNIQUE NOT NULL DEFAULT 1
, team_name VARCHAR(100)
);