CREATE TABLE Road (
    road_id INTEGER,
    road_name VARCHAR(50),
    road_type VARCHAR(30),
    PRIMARY KEY (road_id)
)

CREATE TABLE Section (
    section_id INTEGER,
    section_name VARCHAR(50),
    number_lanes INTEGER,
    city_start INTEGER,
    city_end INTEGER,
    geometry POLYLINE,
    PRIMARY KEY (section_id),
    FOREIGN KEY (city_start) REFERENCES City,
    FOREIGN KEY (city_end) REFERENCES City
)

CREATE TABLE RoadSection (
    road_id INTEGER,
    section_id INTEGER,
    section_number INTEGER
    PRIMARY KEY (road_id, section_id)
    FOREIGN KEY (road_id) REFERENCES Road,
    FOREIGN KEY (section_id) REFERENCES Section
)

CREATE TABLE City (
    city_id INTEGER,
    city_name VARCHAR(50),
    population INTEGER,
    geometry REGION,
    PRIMARY KEY (city_id)
)

SELECT s.number_lanes
FROM Section s
INNER JOIN RoadSection rs ON rs.section_id = s.section_id
INNER JOIN Road r ON r.road_id = rs.road_id
WHERE r.road_name = 'Purwakarta-Bandung'
LIMIT 1

SELECT s.section_name
FROM Section s
INNER JOIN RoadSection rs ON rs.section_id = s.section_id
INNER JOIN Road r ON r.road_id = rs.road_id
WHERE r.road_name = 'Purwakarta-Bandung'

SELECT SUM(Length(s.geometry))
FROM Section s, RoadSection rs, Road r
WHERE s.section_id = rs.section_id
AND rs.road_id = r.road_id
AND r.road_name = 'Purwakarta-Bandung'

SELECT r.*
FROM Road r
INNER JOIN RoadSection rs ON rs.road_id = r.road_id
INNER JOIN Section s ON s.section_id = rs.section_id
WHERE OverlapsLR(s.geometry, (
    SELECT geometry
    FROM City
    WHERE city_name = 'Bandung'
))

SELECT * 
FROM Section
WHERE PointInLine(geometry, @point)

SELECT r.*
FROM Road r
INNER JOIN RoadSection rs ON rs.road_id = r.road_id
INNER JOIN Section s on s.section_id = rs.section_id
WHERE PointInLine(s.geometry, @point)