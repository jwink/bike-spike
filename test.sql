
CREATE DATABASE xxxxx;

\c xxxxx;

CREATE TABLE xxxx (
  id serial4 PRIMARY KEY,
  day integer,
  hour integer,
  UNIQUE (day, hour)
);

INSERT INTO xxxx (day, hour) VAUES (10, 8);

SELECT a.hour, sum(a.avail_bikes_avg), s.quadrant FROM averages as a INNER JOIN stations as s ON a.station_id=s.station_id WHERE (day_of_week=3) GROUP BY quadrant, hour ORDER BY hour;

SELECT sum(avg_bikes), hour, quadrant FROM saturations GROUP BY quadrant, hour ORDER BY quadrant, hour;

SELECT sum(avg_bikes), hour FROM saturations GROUP BY hour ORDER BY hour;;


