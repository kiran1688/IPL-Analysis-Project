create database ipl;
use ipl;
drop table matches;
drop table deliveries;
drop table players;
CREATE TABLE matches (
    match_id INT,
    season INT,
    team1 VARCHAR(50),
    team2 VARCHAR(50),
    venue VARCHAR(50),
    winner VARCHAR(50),
    match_date DATE
);
CREATE TABLE players (
    player_id INT,
    player_name VARCHAR(100),
    team VARCHAR(50),
    role VARCHAR(50)
);

CREATE TABLE deliveries (
    match_id INT,
    batsman_runs INT,
    bowler_runs INT,
    is_wicket INT
);

CREATE TABLE team_wins (
    team VARCHAR(50),
    wins INT
);
SELECT winner, COUNT(*) as wins
FROM matches
GROUP BY winner
ORDER BY wins DESC;

SELECT venue, COUNT(*) AS matches_won
FROM matches
GROUP BY venue
ORDER BY matches_won DESC;

SELECT season, winner, COUNT(*) AS wins
FROM matches
GROUP BY season, winner
ORDER BY season, wins DESC;

SELECT AVG(total_runs_per_match) AS avg_runs
FROM (
    SELECT match_id,
           SUM(batsman_runs) AS total_runs_per_match
    FROM deliveries
    GROUP BY match_id
) AS match_totals;

SELECT match_id, SUM(batsman_runs) AS total_runs
FROM deliveries
GROUP BY match_id
ORDER BY total_runs DESC;

SELECT COUNT(*) 
FROM matches
WHERE winner IS NULL;

SELECT venue, winner, COUNT(*) AS wins
FROM matches
GROUP BY venue, winner
ORDER BY venue;

SELECT match_id,
       SUM(is_wicket) AS total_wickets
FROM deliveries
GROUP BY match_id
ORDER BY total_wickets DESC;

SELECT match_id,
       SUM(batsman_runs) AS total_runs
FROM deliveries
GROUP BY match_id
HAVING SUM(batsman_runs) > 350
ORDER BY total_runs DESC;

SELECT 
    winner,
    COUNT(*) * 100.0 /
    (
        SELECT COUNT(*) 
        FROM matches m2
        WHERE m2.team1 = matches.winner 
           OR m2.team2 = matches.winner
    ) AS win_percentage
FROM matches
GROUP BY winner
ORDER BY win_percentage DESC
LIMIT 5;

SELECT 
    MAX(win_percentage) - MIN(win_percentage) AS dominance_gap
FROM (
    SELECT 
        winner,
        COUNT(*) * 100.0 /
        (
            SELECT COUNT(*)
            FROM matches m2
            WHERE m2.team1 = matches.winner
               OR m2.team2 = matches.winner
        ) AS win_percentage
    FROM matches
    WHERE winner IS NOT NULL
    GROUP BY winner
) AS win_stats;

SELECT 
    venue,
    winner,
    COUNT(*) AS wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY venue, winner
ORDER BY venue, wins DESC;





